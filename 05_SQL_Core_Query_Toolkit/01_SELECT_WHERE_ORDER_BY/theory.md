# SELECT, WHERE, ORDER BY & Query Fundamentals

## Overview
The `SELECT` statement is the core of SQL data retrieval. It extracts rows and columns from database tables, filters them using conditions in `WHERE`, applies conditional logic, restricts result sizes with `TOP`, and formats output using `ORDER BY`.

Understanding how SQL processes queries logically—rather than how they are written—is essential for writing correct and optimized queries.

---

## 1. Logical Query Processing (Order of Execution)

Although a query is written starting with `SELECT`, SQL Server evaluates clauses in a specific **logical query processing sequence**:

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
- **Column Aliases in WHERE**: You **cannot** use a column alias defined in `SELECT` inside a `WHERE` clause because `WHERE` (step 4) executes *before* `SELECT` (step 7).
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
- **ORDER BY Can Use Aliases**: `ORDER BY` (step 9) executes *after* `SELECT` (step 7), so sorting by column aliases is allowed.

---

## 2. SELECT

`SELECT` projects the required columns from a table:

```sql
SELECT StudentID, StudentName
FROM dbo.Student;
```

To retrieve all columns:
```sql
SELECT *
FROM dbo.Student;
```
> ⚠️ **Best Practice**: Avoid `SELECT *` in production applications. It increases network I/O, prevents index-only covering queries, and can break applications if table schemas change.

---

## 3. Filtering Rows with WHERE

`WHERE` filters rows based on logical expressions evaluating to `TRUE`, `FALSE`, or `UNKNOWN`.

```sql
SELECT StudentID, StudentName, Age
FROM dbo.Student
WHERE Age >= 20;
```

---

## 4. Pattern Matching with the `LIKE` Operator

The `LIKE` operator searches for specified string patterns using wildcard characters.

### Wildcard reference:
| Wildcard | Meaning | Example | Matches |
|---|---|---|---|
| `%` | Any sequence of zero or more characters | `'A%'` | `Alice`, `Adam`, `A` |
| `_` | Exactly one single character | `'A_i'` | `Ali`, `Avi` (not `Alice`) |
| `[a-z]` | Any single character within the specified range/set | `'[M-N]x'` | `Mx`, `Nx` |
| `[^a-z]` | Any single character NOT within the specified set | `'[^A-C]%'` | `David`, `Ethan` |

### Code Examples:
```sql
-- Names starting with 'A'
SELECT * FROM Student WHERE StudentName LIKE 'A%';

-- Names ending with 'son'
SELECT * FROM Student WHERE StudentName LIKE '%son';

-- Second letter must be 'o'
SELECT * FROM Student WHERE StudentName LIKE '_o%';

-- First character starts with A, B, or C
SELECT * FROM Student WHERE StudentName LIKE '[A-C]%';
```

### Searching Literal Wildcards using `ESCAPE`
If you need to search for text containing an actual `%` or `_`, use the `ESCAPE` clause:
```sql
-- Search for discount values containing '10%'
SELECT * FROM Promotion 
WHERE PromoCode LIKE '%10\%' ESCAPE '\';
```

### Performance & SARGability Note:
- `LIKE 'ABC%'` is **SARGable** (Search Argument Able); SQL Server can use an index seek on the column.
- `LIKE '%ABC'` is **non-SARGable**; SQL Server must scan the entire table/index row-by-row.

> 🔍 **Where to find more advanced text search?**
> For complex document search, stemming, or fuzzy matching across millions of rows, use **SQL Server Full-Text Search** (`CONTAINS`, `FREETEXT`), which uses dedicated full-text indexes instead of `LIKE`.

---

## 5. Limiting Results with `TOP` & `TOP WITH TIES`

`TOP` restricts the number or percentage of rows returned by a query.

### Syntax & Usage:
```sql
-- Top 3 highest scores
SELECT TOP (3) StudentID, StudentName, Score
FROM Student
ORDER BY Score DESC;

-- Top 10 percent of rows
SELECT TOP (10) PERCENT StudentID, StudentName, Score
FROM Student
ORDER BY Score DESC;

-- Parameterized TOP
DECLARE @n INT = 5;
SELECT TOP (@n) * FROM Student ORDER BY StudentID;
```

### `TOP WITH TIES`
If multiple rows share the same value in the `ORDER BY` column as the last qualifying row, `WITH TIES` includes all tied rows in the output.

> ⚠️ **Requirement**: `TOP WITH TIES` **requires** an `ORDER BY` clause.

```sql
-- Table has scores: 100, 95, 90, 90, 85
-- Without WITH TIES: Returns exactly 3 rows (100, 95, 90)
-- With WITH TIES: Returns 4 rows because the two '90' scores tie for 3rd place!

SELECT TOP (3) WITH TIES StudentID, StudentName, Score
FROM Student
ORDER BY Score DESC;
```

---

## 6. Conditional Logic: `CASE` Expression & `IIF`

SQL Server provides conditional evaluation within queries.

### Simple `CASE` (Matches exact values)
```sql
SELECT StudentName, DepartmentID,
    CASE DepartmentID
        WHEN 10 THEN 'Computer Science'
        WHEN 20 THEN 'Mathematics'
        WHEN 30 THEN 'Physics'
        ELSE 'General Studies'
    END AS DepartmentName
FROM Student;
```

### Searched `CASE` (Evaluates boolean expressions in order)
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

### `IIF()` Ternary Function
`IIF(boolean_expression, true_value, false_value)` is a shorthand ternary syntax for a two-way `CASE` expression.

```sql
-- Simple pass/fail indicator
SELECT StudentName, Score,
    IIF(Score >= 60, 'Pass', 'Fail') AS Status
FROM Student;

-- IIF inside ORDER BY for dynamic sorting
SELECT StudentName, Age
FROM Student
ORDER BY IIF(Age >= 20, 1, 2), StudentName;
```

---

## 7. Random Sorting with `NEWID()`

To retrieve a random row or shuffle a result set, sort by `NEWID()` (which generates a unique GUID for every row evaluated):

```sql
-- Pick a random winner from qualifying students
SELECT TOP (1) StudentID, StudentName
FROM Student
WHERE Score >= 80
ORDER BY NEWID();
```

---

## 8. Putting It Together

```sql
SELECT TOP (5) WITH TIES
    StudentID, 
    StudentName, 
    Score,
    IIF(Score >= 50, 'Passed', 'Failed') AS ResultStatus,
    CASE 
        WHEN StudentName LIKE 'A%' THEN 'Group Alpha'
        ELSE 'Group Standard'
    END AS StudentGroup
FROM dbo.Student
WHERE Score IS NOT NULL
ORDER BY Score DESC;
```

---

## 9. Key Takeaways

- **Order of Execution**: `FROM` → `WHERE` → `SELECT` → `ORDER BY` → `TOP`. Alias defined in `SELECT` cannot be used in `WHERE`.
- **LIKE Pattern Matching**: `%` (many chars), `_` (one char), `[...]` (set), `ESCAPE` for literal search. Leading wildcards (`'%abc'`) disable index seeks.
- **TOP WITH TIES**: Returns extra rows if there are ties at the cutoff boundary (requires `ORDER BY`).
- **CASE & IIF**: Enable inline conditional logic in queries.
- **NEWID() Sorting**: `ORDER BY NEWID()` produces random row ordering.

---

> 🔗 **See also**
> - [../02_JOINS/theory.md](../02_JOINS/theory.md)
> - [../05_Set_Operators/theory.md](../05_Set_Operators/theory.md)
> - [../06_Subqueries/theory.md](../06_Subqueries/theory.md)
> - [../syntax_cheatsheet.md](../syntax_cheatsheet.md)
