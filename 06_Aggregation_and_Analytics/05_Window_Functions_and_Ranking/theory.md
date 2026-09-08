# Window Functions & Ranking

## Overview
Window functions perform calculations across a set of table rows related to the current row, **without collapsing the result into a single row** like aggregate functions with `GROUP BY` do. Each row retains its individual identity while gaining computed analytical columns.

---

## 1. Baseline Data for Window Examples

**`Employee` Table**
| EmployeeID | EmployeeName | DepartmentID | Department | Salary |
| :--- | :--- | :--- | :--- | :--- |
| **1** | Ahmed | **10** | Sales | **5000** |
| **2** | Sara | **10** | Sales | **7000** |
| **3** | Omar | **10** | Sales | **7000** |
| **4** | Laila | **10** | Sales | **4000** |
| **5** | Youssef | **20** | IT | **9000** |
| **6** | Nour | **20** | IT | **9000** |
| **7** | Karim | **20** | IT | **6000** |
| **8** | Mona | **30** | HR | **5500** |

---

## 2. Core Window Functions: Syntax & Behavior

### A. `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`

#### T-SQL & PostgreSQL Syntax (Identical)
```sql
SELECT 
    EmployeeName, 
    Salary,
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum,
    RANK() OVER (ORDER BY Salary DESC) AS RankVal,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRankVal
FROM Employee;
```

#### Execution Output:
| EmployeeName | Salary | RowNum | RankVal | DenseRankVal |
| :--- | :--- | :--- | :--- | :--- |
| **Youssef** | **9000** | 1 | 1 | 1 |
| **Nour** | **9000** | 2 | 1 | 1 |
| **Sara** | **7000** | 3 | 3 | 2 |
| **Omar** | **7000** | 4 | 3 | 2 |
| **Karim** | **6000** | 5 | 5 | 3 |

---

### B. Running Totals with `SUM() OVER()`

#### T-SQL & PostgreSQL Syntax (Identical)
```sql
SELECT 
    DepartmentID, 
    EmployeeName, 
    Salary,
    SUM(Salary) OVER (
        PARTITION BY DepartmentID 
        ORDER BY EmployeeID
    ) AS DeptRunningTotal
FROM Employee;
```

---

### C. Lookback & Lookahead with `LAG()` and `LEAD()`

#### T-SQL & PostgreSQL Syntax (Identical)
```sql
SELECT 
    EmployeeName, 
    Salary,
    LAG(Salary, 1) OVER (ORDER BY EmployeeID) AS PrevSalary,
    LEAD(Salary, 1) OVER (ORDER BY EmployeeID) AS NextSalary
FROM Employee;
```

---

## 3. PostgreSQL Comparison & Compatibility

| Window Function Feature | SQL Server (T-SQL) | PostgreSQL | Notes |
| :--- | :--- | :--- | :--- |
| **`ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`** | ✅ Supported | ✅ Supported | 100% ANSI standard |
| **`NTILE(n)`, `PERCENT_RANK()`, `CUME_DIST()`** | ✅ Supported | ✅ Supported | 100% ANSI standard |
| **`LAG()`, `LEAD()`** | ✅ Supported | ✅ Supported | 100% ANSI standard |
| **`FIRST_VALUE()`, `LAST_VALUE()`** | ✅ Supported | ✅ Supported | 100% ANSI standard |
| **Window Frame Clauses (`ROWS / RANGE BETWEEN`)**| ✅ Supported | ✅ Supported | Identical syntax |
| **Named `WINDOW` Clause** | ❌ Not Supported | ✅ Supported | PostgreSQL allows `WINDOW w AS (PARTITION BY dept ORDER BY salary)` |

---

## 4. Key Takeaways

- **`ROW_NUMBER()`**: Unique sequential counter; no ties allowed.
- **`RANK()`**: Equal values get tied rank numbers; skips subsequent numbers (e.g. 1, 1, 3).
- **`DENSE_RANK()`**: Equal values get tied rank numbers; does not skip subsequent numbers (e.g. 1, 1, 2).
- **`LAG` / `LEAD`**: Access previous or next row values without a self-join.
- **`PARTITION BY`**: Resets the window calculation boundary for each distinct partition value.

---

> 🔗 **See also**
> - [../01_Aggregate_Functions/theory.md](../01_Aggregate_Functions/theory.md)
> - [../06_Built_in_Functions/theory.md](../06_Built_in_Functions/theory.md)
