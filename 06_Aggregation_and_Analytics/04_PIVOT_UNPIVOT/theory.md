# PIVOT & UNPIVOT

> Status: ✅ Built as the table-rotation lesson.

## Overview
`PIVOT` rotates rows into columns. `UNPIVOT` does the opposite: it turns columns into rows.

These are very useful in reporting when data must be displayed in a matrix format.

---

## 1. PIVOT

```sql
SELECT *
FROM (
    SELECT DepartmentID, Gender, Salary
    FROM dbo.Employee
) AS SourceTable
PIVOT (
    SUM(Salary)
    FOR Gender IN ([M], [F])
) AS PivotTable;
```

This turns gender values into columns so you can compare male and female salaries by department.

---

## 2. UNPIVOT

```sql
SELECT DepartmentID, Gender, Salary
FROM (
    SELECT DepartmentID, [M], [F]
    FROM dbo.EmployeePivot
) AS SourceTable
UNPIVOT (
    Salary FOR Gender IN ([M], [F])
) AS UnpivotTable;
```

This takes columns such as `M` and `F` and converts them back into rows.

---

## 3. Typical use cases

- budget vs actual comparisons,
- monthly sales matrix,
- regional performance reports,
- converting row-wise data to column-wise summaries.

---

## 4. Example table

```sql
CREATE TABLE EmployeePivot (
    DepartmentID INT,
    M INT,
    F INT
);
```

---

## 5. Key takeaways

- `PIVOT`: columns become dimensions
- `UNPIVOT`: dimensions become rows

> 💡 **Core idea**
> Pivot operations help convert data into report-friendly layouts without custom Excel-style manual reshaping.

---

> 🔗 **See also**
> - [../03_ROLLUP_CUBE_GROUPING_SETS/theory.md](../03_ROLLUP_CUBE_GROUPING_SETS/theory.md)
> - [../05_Window_Functions_and_Ranking/theory.md](../05_Window_Functions_and_Ranking/theory.md)
