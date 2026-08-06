# Subqueries: Scalar, Correlated & Set Comparisons (ALL, ANY, SOME)

## Overview
A **subquery** (also known as an inner query or nested query) is a `SELECT` statement embedded inside another SQL statement (`SELECT`, `INSERT`, `UPDATE`, `DELETE`). 

Subqueries evaluate dynamically to provide values, row sets, or existence checks to the main outer query.

---

## 1. Classification of Subqueries

Subqueries are categorized by how they return data and how they interact with the outer query:

```text
                     ┌───────────────────────────────┐
                     │         SUBQUERIES            │
                     └───────────────┬───────────────┘
                                     │
           ┌─────────────────────────┼─────────────────────────┐
           ▼                         ▼                         ▼
  ┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
  │ Scalar Subquery │       │ Multi-Row / Set │       │   Correlated    │
  │ (Returns 1 value│       │ (Returns column │       │ (References     │
  │   1 row, 1 col) │       │  or table set)  │       │  outer columns) │
  └─────────────────┘       └─────────────────┘       └─────────────────┘
```

---

## 2. Scalar Subqueries

A **Scalar Subquery** returns exactly **one row and one column** (a single value). It can be used anywhere a literal expression or value is permitted (in `SELECT`, `WHERE`, `HAVING`).

```sql
-- Find students scoring above the average score of all students
SELECT StudentID, StudentName, Score
FROM dbo.Student
WHERE Score > (SELECT AVG(Score) FROM dbo.Student);
```
> ⚠️ **Error Warning**: If a scalar subquery unexpectedly returns more than one row, SQL Server throws runtime error 512 (*"Subquery returned more than 1 value"*).

---

## 3. Correlated Subqueries & `EXISTS`

A **Correlated Subquery** references columns from the outer query table. The inner subquery is re-evaluated for **every row** processed by the outer query.

```sql
-- Find students who score higher than their own department's average score
SELECT s.StudentID, s.StudentName, s.Score, s.DepartmentID
FROM dbo.Student AS s
WHERE s.Score > (
    SELECT AVG(d.Score) 
    FROM dbo.Student AS d 
    WHERE d.DepartmentID = s.DepartmentID  -- Correlated reference to outer 's'
);
```

### `EXISTS` and `NOT EXISTS`
`EXISTS` tests whether a subquery returns **any rows at all**. It stops scanning as soon as the first matching row is found (short-circuit evaluation).

```sql
-- Find departments that have at least one enrolled student
SELECT DepartmentID, DepartmentName
FROM dbo.Department AS dept
WHERE EXISTS (
    SELECT 1 FROM dbo.Student AS s 
    WHERE s.DepartmentID = dept.DepartmentID
);
```

---

## 4. Multi-Row Operators: `ALL` and `ANY` (`SOME`)

When a subquery returns a single column containing **multiple rows**, you compare outer values against the set using `IN`, `ALL`, or `ANY` (`SOME` is an exact synonym for `ANY`).

### Syntax & Logical Meaning:

| Operator Expression | Meaning / Equivalence | Logical Evaluator |
|---|---|---|
| `x > ALL (subquery)` | Greater than **EVERY** value in the subquery | `x > MAX(subquery)` |
| `x < ALL (subquery)` | Less than **EVERY** value in the subquery | `x < MIN(subquery)` |
| `x = ALL (subquery)` | Equal to every value (only true if all subquery rows match `x`) | Rarely used |
| `x > ANY (subquery)` | Greater than **AT LEAST ONE** value in the subquery | `x > MIN(subquery)` |
| `x < ANY (subquery)` | Less than **AT LEAST ONE** value in the subquery | `x < MAX(subquery)` |
| `x = ANY (subquery)` | Equal to at least one value in the subquery | **Identical to `x IN (subquery)`** |

---

## 5. Code Examples: `ALL` vs `ANY`

Assuming the subquery returns the set of scores `{70, 80, 90}` for Department 10:

### 1. Using `> ALL` (Must exceed maximum)
```sql
-- Find students whose score is higher than ALL students in Department 10
-- Equivalent to: WHERE Score > 90
SELECT StudentName, Score
FROM dbo.Student
WHERE Score > ALL (
    SELECT Score 
    FROM dbo.Student 
    WHERE DepartmentID = 10
);
```

### 2. Using `> ANY` (Must exceed minimum)
```sql
-- Find students whose score is higher than AT LEAST ONE student in Department 10
-- Equivalent to: WHERE Score > 70
SELECT StudentName, Score
FROM dbo.Student
WHERE Score > ANY (
    SELECT Score 
    FROM dbo.Student 
    WHERE DepartmentID = 10
);
```

---

## 6. Critical Warning: `NULL` Handling in `NOT IN` vs `ALL`

If a subquery returns a result set containing even a single `NULL` value, `NOT IN` and `<> ALL` operations will evaluate to `UNKNOWN` for **all rows**, returning an **empty result set**!

```sql
-- ⚠️ DANGER: If Department 20 has a NULL manager, this query returns 0 rows!
SELECT EmployeeName 
FROM dbo.Employee 
WHERE ManagerID NOT IN (SELECT ManagerID FROM dbo.Department);

-- ✅ SAFE SOLUTION: Use NOT EXISTS or filter NULLs explicitly
SELECT EmployeeName 
FROM dbo.Employee AS e
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.Department AS d 
    WHERE d.ManagerID = e.ManagerID
);
```

---

## 7. Key Takeaways

- **Scalar Subquery**: Returns 1 row, 1 column; usable anywhere an expression is expected.
- **Correlated Subquery**: References outer query columns; executes once per outer row.
- **EXISTS / NOT EXISTS**: Preferred existence check; short-circuits on first match.
- **ALL**: Must satisfy condition against **every single element** in the subquery (`> ALL` = `> MAX`).
- **ANY / SOME**: Satisfies condition if **at least one element** matches (`> ANY` = `> MIN`, `= ANY` = `IN`).
- **NULL Trap**: `NOT IN` or `<> ALL` fails if the subquery output contains `NULL`. Use `NOT EXISTS` instead.

---

> 🔗 **See also**
> - [../01_SELECT_WHERE_ORDER_BY/theory.md](../01_SELECT_WHERE_ORDER_BY/theory.md)
> - [../02_JOINS/theory.md](../02_JOINS/theory.md)
> - [../05_Set_Operators/theory.md](../05_Set_Operators/theory.md)
> - [../syntax_cheatsheet.md](../syntax_cheatsheet.md)
