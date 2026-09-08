# SELECT, WHERE, ORDER BY & Query Fundamentals

## Overview
The `SELECT` statement is the core of SQL data retrieval. It extracts rows and columns from database tables, filters them using conditions in `WHERE`, applies conditional logic, restricts result sizes, and formats output using `ORDER BY`.

---

## 1. Logical Query Processing (Order of Execution)

Although a query is written starting with `SELECT`, database engines evaluate clauses in a specific **logical query processing sequence**:

```text
Logical Execution Order:

┌─────────────────────────────────────────────────────────────┐
│ 1. FROM        (Identify source tables)                     │
│ 2. ON          (Apply join conditions)                      │
│ 3. JOIN        (Combine table rows)                         │
│ 4. WHERE       (Filter rows before grouping)                │
│ 5. GROUP BY    (Group rows into summary rows)               │
│ 6. HAVING      (Filter grouped summary rows)                │
│ 7. SELECT      (Evaluate expressions & column list)         │
│ 8. DISTINCT    (Remove duplicate output rows)               │
│ 9. ORDER BY    (Sort final result set)                      │
│ 10. TOP /      (Limit returned row count)                   │
│     OFFSET-FETCH                                            │
└─────────────────────────────────────────────────────────────┘
```

### Key Implications of Execution Order
* **Column Aliases in `WHERE`**: You **cannot** use a column alias defined in `SELECT` inside a `WHERE` clause because `WHERE` (step 4) executes *before* `SELECT` (step 7).
  ```sql
  -- ❌ FAILS: MonthlySalary is evaluated in step 7, after step 4
  SELECT Salary / 12 AS MonthlySalary
  FROM Employee
  WHERE MonthlySalary > 5000;

  -- ✅ CORRECT: Repeat the expression or use a CTE / derived table
  SELECT Salary / 12 AS MonthlySalary
  FROM Employee
  WHERE (Salary / 12) > 5000;
  ```
* **`ORDER BY` Can Use Aliases**: `ORDER BY` (step 9) executes *after* `SELECT` (step 7), so sorting by column aliases is allowed in both T-SQL and PostgreSQL.

---

## 2. SELECT & Projection

`SELECT` projects the required columns from a table:

### SQL Server & PostgreSQL Syntax
```sql
SELECT StudentID, StudentName
FROM Student;
```

> ⚠️ **Best Practice**: Avoid `SELECT *` in production applications. It increases network I/O, prevents index-only covering queries, and can break applications if table schemas change.

---

## 3. Pattern Matching with `LIKE`

### Wildcard Reference
| Wildcard | Meaning | SQL Server Example | PostgreSQL Equivalent |
| :--- | :--- | :--- | :--- |
| `%` | Any sequence of zero or more characters | `'A%'` | `'A%'` |
| `_` | Exactly one single character | `'A_i'` | `'A_i'` |
| `[a-z]` | Range or set of characters | `'[M-N]x'` | `~ '^[M-N]x'` (Regex) |
| `[^a-z]` | NOT within range or set | `'[^A-C]%'` | `!~ '^[A-C]'` (Regex) |

### Code Examples

#### SQL Server (T-SQL)
```sql
-- Names starting with 'A'
SELECT * FROM Student WHERE StudentName LIKE 'A%';

-- Names with 'o' as second letter
SELECT * FROM Student WHERE StudentName LIKE '_o%';

-- First letter A, B, or C (Character Class)
SELECT * FROM Student WHERE StudentName LIKE '[A-C]%';
```

#### PostgreSQL
```sql
-- Standard wildcards are identical:
SELECT * FROM Student WHERE StudentName LIKE 'A%';

-- For character classes or complex patterns, PostgreSQL uses Regular Expressions (~):
SELECT * FROM Student WHERE StudentName ~ '^[A-C]';
```

---

## 4. Limiting Result Sets: `TOP` vs `LIMIT`

### A. SQL Server (T-SQL) Syntax
```sql
-- Return top 3 highest scoring students
SELECT TOP (3) StudentID, StudentName, Score
FROM Student
ORDER BY Score DESC;

-- Return top 10 percent of rows
SELECT TOP (10) PERCENT StudentID, StudentName, Score
FROM Student
ORDER BY Score DESC;
```

### B. PostgreSQL Syntax
```sql
-- PostgreSQL uses LIMIT / OFFSET syntax (ANSI Standard)
SELECT StudentID, StudentName, Score
FROM Student
ORDER BY Score DESC
LIMIT 3;

-- OFFSET pagination in PostgreSQL
SELECT StudentID, StudentName, Score
FROM Student
ORDER BY Score DESC
LIMIT 3 OFFSET 3;
```
> ℹ️ **PostgreSQL Note**: PostgreSQL does not use `TOP (N)`. It uses `LIMIT N` or ANSI `FETCH FIRST N ROWS ONLY`.

---

## 5. Handling Ties: `TOP WITH TIES` vs `FETCH WITH TIES`

If multiple rows share the same value in the `ORDER BY` column as the last qualifying row, `WITH TIES` includes all tied rows.

### Execution Walkthrough

**Initial Dataset: `Student` Table**
| StudentID | StudentName | Score |
| :--- | :--- | :--- |
| **101** | Alice | **100** |
| **102** | Bob | **95** |
| **103** | Charlie | **90** |
| **104** | David | **90** |
| **105** | Emma | **85** |

### SQL Server (T-SQL)
```sql
SELECT TOP (3) WITH TIES StudentID, StudentName, Score
FROM Student
ORDER BY Score DESC;
```

### PostgreSQL (PostgreSQL 13+)
```sql
SELECT StudentID, StudentName, Score
FROM Student
ORDER BY Score DESC
FETCH FIRST 3 ROWS WITH TIES;
```

#### Expected Output (Both Engines):
| StudentID | StudentName | Score | Notes |
| :--- | :--- | :--- | :--- |
| **101** | Alice | **100** | Rank 1 |
| **102** | Bob | **95** | Rank 2 |
| **103** | Charlie | **90** | Rank 3 |
| **104** | David | **90** | **Included due to tie with Charlie at Score = 90!** |

---

## 6. Conditional Logic: `CASE` & `IIF`

### A. Searched `CASE` Expression (Identical in SQL Server & PostgreSQL)
```sql
SELECT StudentName, Score,
    CASE 
        WHEN Score >= 90 THEN 'Grade A'
        WHEN Score >= 80 THEN 'Grade B'
        WHEN Score >= 70 THEN 'Grade C'
        ELSE 'Needs Improvement'
    END AS PerformanceGrade
FROM Student;
```

### B. Inline Ternary: `IIF()`

#### SQL Server (T-SQL)
```sql
-- Shorthand ternary evaluation
SELECT StudentName, Score,
    IIF(Score >= 60, 'Pass', 'Fail') AS Status
FROM Student;
```

#### PostgreSQL
```sql
-- PostgreSQL does not have IIF(); use standard CASE expression instead:
SELECT StudentName, Score,
    CASE WHEN Score >= 60 THEN 'Pass' ELSE 'Fail' END AS Status
FROM Student;
```

---

## 7. Shuffling / Random Sorting

### SQL Server (T-SQL)
```sql
-- Select 1 random winning student
SELECT TOP (1) StudentID, StudentName
FROM Student
ORDER BY NEWID();
```

### PostgreSQL
```sql
-- Select 1 random winning student
SELECT StudentID, StudentName
FROM Student
ORDER BY RANDOM()
LIMIT 1;
```
> ℹ️ **Engine Difference**: SQL Server uses `NEWID()`, while PostgreSQL uses `RANDOM()`.

---

## 8. Summary Matrix

| Query Concept | SQL Server (T-SQL) | PostgreSQL |
| :--- | :--- | :--- |
| **Logical Order of Execution** | `FROM` → `WHERE` → `SELECT` → `ORDER BY` | `FROM` → `WHERE` → `SELECT` → `ORDER BY` |
| **Limit Row Count** | `TOP (N)` | `LIMIT N` or `FETCH FIRST N ROWS ONLY` |
| **Include Tied Cutoff Rows** | `TOP (N) WITH TIES` | `FETCH FIRST N ROWS WITH TIES` |
| **Ternary If** | `IIF(cond, true, false)` | `CASE WHEN cond THEN true ELSE false END` |
| **Random Sorting** | `ORDER BY NEWID()` | `ORDER BY RANDOM()` |
| **Character Class Matching** | `LIKE '[A-Z]%'` | `~ '^[A-Z]'` (Regex) |

---

> 🔗 **See also**
> - [../02_JOINS/theory.md](../02_JOINS/theory.md)
> - [../05_Set_Operators/theory.md](../05_Set_Operators/theory.md)
> - [../06_Subqueries/theory.md](../06_Subqueries/theory.md)
