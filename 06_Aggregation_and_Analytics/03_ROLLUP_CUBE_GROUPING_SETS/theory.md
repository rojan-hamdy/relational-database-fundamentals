# ROLLUP, CUBE, GROUPING SETS

> Status: ✅ Built as the multi-level aggregation lesson.

## Overview
These functions create multiple grouping levels in a single query. They are useful when reporting requires totals, subtotals, and category breakdowns.

---

## 1. ROLLUP

`ROLLUP` creates hierarchical subtotal rows.

```sql
SELECT DepartmentID, SUM(Salary) AS TotalSalary
FROM dbo.Employee
GROUP BY ROLLUP (DepartmentID);
```

This returns:
- one row per department
- a grand total row at the end

---

## 2. CUBE

`CUBE` creates totals for all combinations of the grouped dimensions.

```sql
SELECT DepartmentID, Gender, SUM(Salary) AS TotalSalary
FROM dbo.Employee
GROUP BY CUBE (DepartmentID, Gender);
```

This may return:
- department totals,
- gender totals,
- overall total,
- combinations of both.

---

## 3. GROUPING SETS

`GROUPING SETS` lets you explicitly define the grouping combinations you want.

```sql
SELECT DepartmentID, Gender, SUM(Salary) AS TotalSalary
FROM dbo.Employee
GROUP BY GROUPING SETS (
    (DepartmentID),
    (Gender),
    ()
);
```

This gives a controlled set of groupings instead of all possible CUBE combinations.

---

## 4. Example dataset

```sql
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    Gender VARCHAR(10),
    Salary DECIMAL(10,2)
);

INSERT INTO Employee (EmployeeID, DepartmentID, Gender, Salary)
VALUES (1, 10, 'M', 5000),
       (2, 10, 'F', 6000),
       (3, 20, 'M', 4500),
       (4, 20, 'F', 5500);
```

```sql
SELECT DepartmentID, Gender, SUM(Salary) AS TotalSalary
FROM Employee
GROUP BY ROLLUP (DepartmentID, Gender);
```

---

## 5. Practical use

Use these grouping operators for:
- financial reports,
- executive summaries,
- category totals,
- drill-down and roll-up reporting.

---

## 6. Key takeaways

- `ROLLUP`: hierarchical subtotals
- `CUBE`: all combinations of dimensions
- `GROUPING SETS`: custom subset of groupings

> 💡 **Core idea**
> These operators help create compact, multi-level reporting summaries without writing many separate queries.

---

> 🔗 **See also**
> - [../02_GROUP_BY_HAVING/theory.md](../02_GROUP_BY_HAVING/theory.md)
> - [../05_Window_Functions_and_Ranking/theory.md](../05_Window_Functions_and_Ranking/theory.md)
