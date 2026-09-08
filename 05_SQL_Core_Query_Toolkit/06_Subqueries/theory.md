# Subqueries: Scalar, Correlated & Set Comparisons (ALL, ANY, SOME)

## Overview
A **subquery** (inner query) is a `SELECT` statement embedded inside another SQL query (`SELECT`, `INSERT`, `UPDATE`, `DELETE`). Subqueries evaluate dynamically to provide values, row sets, or existence checks to the outer query.

---

## 1. Baseline Data for Subquery Examples

**`Student` Table**
| StudentID | StudentName | DepartmentID | Score |
| :--- | :--- | :--- | :--- |
| **101** | Alice | **10** | **95** |
| **102** | Bob | **10** | **85** |
| **103** | Charlie | **20** | **70** |
| **104** | David | **20** | **60** |

---

## 2. Scalar Subqueries

A **Scalar Subquery** returns a single value (1 row, 1 column).

### T-SQL & PostgreSQL Syntax (Identical)
```sql
-- Find students scoring above the average score of all students
SELECT StudentID, StudentName, Score
FROM Student
WHERE Score > (SELECT AVG(Score) FROM Student);
```

### Execution Walkthrough
1. Engine evaluates inner subquery: `SELECT AVG(Score) FROM Student` $\rightarrow$ returns **`77.5`**.
2. Outer query evaluates: `WHERE Score > 77.5`.
3. Output: `Alice` (95) and `Bob` (85).

---

## 3. Correlated Subqueries & `EXISTS`

A **Correlated Subquery** references columns from the outer query table, executing once for every candidate row evaluated by the outer query.

### T-SQL & PostgreSQL Syntax (Identical)
```sql
-- Find students who score higher than their own department's average score
SELECT s.StudentID, s.StudentName, s.Score, s.DepartmentID
FROM Student AS s
WHERE s.Score > (
    SELECT AVG(d.Score) 
    FROM Student AS d 
    WHERE d.DepartmentID = s.DepartmentID
);
```

### `EXISTS` and `NOT EXISTS` Existence Checks

```sql
-- Find departments that have at least one enrolled student
SELECT DepartmentID, DepartmentName
FROM Department AS dept
WHERE EXISTS (
    SELECT 1 FROM Student AS s 
    WHERE s.DepartmentID = dept.DepartmentID
);
```
> ℹ️ `EXISTS` short-circuits as soon as a single matching row is found in the inner table.

---

## 4. Multi-Row Set Comparisons (`ALL`, `ANY`, `SOME`)

| Expression | Meaning / Equivalence | Logical Evaluator |
| :--- | :--- | :--- |
| `x > ALL (subquery)` | Greater than **EVERY** value returned | `x > MAX(subquery)` |
| `x < ALL (subquery)` | Less than **EVERY** value returned | `x < MIN(subquery)` |
| `x > ANY (subquery)` | Greater than **AT LEAST ONE** value returned | `x > MIN(subquery)` |
| `x = ANY (subquery)` | Equal to at least one value | Identical to `x IN (subquery)` |

### T-SQL & PostgreSQL Syntax (Identical)
```sql
-- Find students scoring higher than ALL students in Dept 20 (Max of Dept 20 is 70)
SELECT StudentName, Score
FROM Student
WHERE Score > ALL (
    SELECT Score FROM Student WHERE DepartmentID = 20
);
```

---

## 5. PostgreSQL Comparison & Compatibility

| Subquery Feature | SQL Server (T-SQL) | PostgreSQL | Notes |
| :--- | :--- | :--- | :--- |
| **Scalar Subquery** | ✅ Supported | ✅ Supported | 100% ANSI standard |
| **Correlated Subquery** | ✅ Supported | ✅ Supported | 100% ANSI standard |
| **`EXISTS` / `NOT EXISTS`** | ✅ Supported | ✅ Supported | 100% ANSI standard |
| **`ALL` / `ANY` / `SOME`** | ✅ Supported | ✅ Supported | 100% ANSI standard |
| **Subqueries in `FROM` (CTEs / Derived Tables)** | Alias required | Alias required | Both engines require aliasing derived tables: `FROM (...) AS tbl` |

---

## 6. Key Takeaways

- **Scalar Subquery**: Returns 1 value (1x1). Throws error if multiple rows returned.
- **Correlated Subquery**: Binds to outer table row by row.
- **EXISTS / NOT EXISTS**: Fast existence check; safe against `NULL` traps.
- **ALL vs ANY**: `ALL` requires meeting condition for all set elements; `ANY` requires meeting condition for at least one.
- **Derived Tables**: Subqueries in `FROM` must have a table alias in both SQL Server and PostgreSQL.

---

> 🔗 **See also**
> - [../01_SELECT_WHERE_ORDER_BY/theory.md](../01_SELECT_WHERE_ORDER_BY/theory.md)
> - [../02_JOINS/theory.md](../02_JOINS/theory.md)
> - [../05_Set_Operators/theory.md](../05_Set_Operators/theory.md)
