# PIVOT & UNPIVOT

## Overview
`PIVOT` rotates row values into dynamic summary columns. `UNPIVOT` performs the inverse transformation: rotating columns back into rows.

---

## 1. PIVOT: Transforming Rows to Columns

### Baseline Data: `Employee` Table

| DepartmentID | Gender | Salary |
| :--- | :--- | :--- |
| **10** | **M** | **5000** |
| **10** | **F** | **6000** |
| **20** | **M** | **7000** |

---

### A. SQL Server (T-SQL) Syntax: Native `PIVOT` Operator
```sql
SELECT DepartmentID, [M], [F]
FROM (
    SELECT DepartmentID, Gender, Salary
    FROM Employee
) AS SourceTable
PIVOT (
    SUM(Salary)
    FOR Gender IN ([M], [F])
) AS PivotTable;
```

---

### B. PostgreSQL Syntax: Conditional Aggregation & `crosstab()`

PostgreSQL does **not** have a native keyword operator named `PIVOT`. Instead, developers use **Conditional Aggregation** (Standard ANSI SQL - Recommended) or the `tablefunc` extension (`crosstab()`).

#### Option 1: PostgreSQL Conditional Aggregation (`FILTER` / `CASE`) — *Recommended*
```sql
-- Standard ANSI SQL approach in PostgreSQL:
SELECT 
    DepartmentID,
    SUM(Salary) FILTER (WHERE Gender = 'M') AS "M",
    SUM(Salary) FILTER (WHERE Gender = 'F') AS "F"
FROM Employee
GROUP BY DepartmentID;

-- Equivalent using standard CASE WHEN:
SELECT 
    DepartmentID,
    SUM(CASE WHEN Gender = 'M' THEN Salary ELSE 0 END) AS "M",
    SUM(CASE WHEN Gender = 'F' THEN Salary ELSE 0 END) AS "F"
FROM Employee
GROUP BY DepartmentID;
```

#### Option 2: PostgreSQL `crosstab()` Extension
```sql
CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT * FROM crosstab(
    'SELECT DepartmentID, Gender, SUM(Salary) FROM Employee GROUP BY 1, 2 ORDER BY 1, 2',
    'VALUES (''M''), (''F'')'
) AS ct(DepartmentID INT, "M" NUMERIC, "F" NUMERIC);
```

#### Pivoted Result (Both Engines):
| DepartmentID | M | F |
| :--- | :--- | :--- |
| **10** | **5000** | **6000** |
| **20** | **7000** | **`NULL`** |

---

## 2. UNPIVOT: Transforming Columns to Rows

### A. SQL Server (T-SQL) Syntax
```sql
SELECT DepartmentID, Gender, Salary
FROM EmployeePivot
UNPIVOT (
    Salary FOR Gender IN ([M], [F])
) AS UnpivotTable;
```

### B. PostgreSQL Syntax: `LATERAL` Join & `VALUES`
```sql
-- In PostgreSQL, UNPIVOT is performed using CROSS JOIN LATERAL with VALUES:
SELECT e.DepartmentID, u.Gender, u.Salary
FROM EmployeePivot AS e
CROSS JOIN LATERAL (
    VALUES ('M', e.M), ('F', e.F)
) AS u(Gender, Salary)
WHERE u.Salary IS NOT NULL;
```

---

## 3. Comparison Matrix

| Feature | SQL Server (T-SQL) | PostgreSQL |
| :--- | :--- | :--- |
| **Row-to-Column Pivot** | Native `PIVOT` operator | Conditional Aggregation `FILTER (WHERE ...)` or `crosstab()` |
| **Column-to-Row Unpivot** | Native `UNPIVOT` operator | `CROSS JOIN LATERAL (VALUES ...)` |
| **ANSI Standard Compliance** | Proprietary syntax | `FILTER (WHERE ...)` is ANSI SQL:2003 standard |

---

> 🔗 **See also**
> - [../03_ROLLUP_CUBE_GROUPING_SETS/theory.md](../03_ROLLUP_CUBE_GROUPING_SETS/theory.md)
> - [../05_Window_Functions_and_Ranking/theory.md](../05_Window_Functions_and_Ranking/theory.md)
