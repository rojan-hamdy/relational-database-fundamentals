# GROUP BY & HAVING

## Overview
`GROUP BY` partitions individual rows into summary groups based on shared column values. Aggregate functions are then computed for each group. `HAVING` filters those aggregated group summary rows.

---

## 1. Logical Execution Flow: WHERE vs GROUP BY vs HAVING

```text
┌─────────────────────────────────────────────────────────────┐
│ 1. WHERE      Filters individual rows BEFORE grouping      │
│               (e.g., WHERE Age >= 20)                       │
├─────────────────────────────────────────────────────────────┤
│ 2. GROUP BY   Splits remaining rows into summary buckets    │
│               (e.g., GROUP BY DepartmentID)                 │
├─────────────────────────────────────────────────────────────┤
│ 3. HAVING     Filters summary buckets AFTER aggregation     │
│               (e.g., HAVING COUNT(*) >= 2)                  │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. Baseline Data for GROUP BY Examples

**`Student` Table**
| StudentID | StudentName | DepartmentID | Age |
| :--- | :--- | :--- | :--- |
| **1** | Alice | **10** | **22** |
| **2** | Bob | **10** | **25** |
| **3** | Charlie | **20** | **19** |
| **4** | Dana | **30** | **21** |

---

## 3. Query Execution Walkthrough

```sql
SELECT DepartmentID, AVG(Age) AS AvgAge, COUNT(*) AS TotalStudents
FROM Student
WHERE Age >= 20
GROUP BY DepartmentID
HAVING COUNT(*) >= 2;
```

### Execution Steps:
1. **`WHERE Age >= 20`**: Drops `Charlie` (Age 19). Remaining students: `Alice` (22), `Bob` (25), `Dana` (21).
2. **`GROUP BY DepartmentID`**:
   * **Group 10**: `Alice` (22), `Bob` (25) $\rightarrow$ `AvgAge = 23.5`, `Count = 2`
   * **Group 30**: `Dana` (21) $\rightarrow$ `AvgAge = 21.0`, `Count = 1`
3. **`HAVING COUNT(*) >= 2`**: Drops **Group 30** (`Count = 1`).

#### Final Output:
| DepartmentID | AvgAge | TotalStudents |
| :--- | :--- | :--- |
| **10** | **23.5** | **2** |

---

## 4. PostgreSQL Comparison & Compatibility

| Feature | SQL Server (T-SQL) | PostgreSQL | Notes |
| :--- | :--- | :--- | :--- |
| **`GROUP BY` Clause** | ✅ Supported | ✅ Supported | 100% ANSI standard |
| **`HAVING` Clause** | ✅ Supported | ✅ Supported | 100% ANSI standard |
| **Non-grouped columns in `SELECT`** | ❌ Blocked (Must be in `GROUP BY` or aggregated) | ❌ Blocked (Must be in `GROUP BY` or aggregated) | Both engines strictly enforce ANSI compliance |
| **Primary Key Functional Dependency** | ❌ Requires grouping all SELECT cols | ✅ Allows non-grouped PK columns | PostgreSQL allows omitting columns if Primary Key is in `GROUP BY` |

---

## 5. Key Takeaways

- **`WHERE`**: Filters row-by-row before grouping takes place.
- **`GROUP BY`**: Collapses rows sharing identical group key values.
- **`HAVING`**: Filters summarized groups based on aggregate results (e.g. `HAVING COUNT(*) > 5`).
- **Rule**: Every non-aggregated column in `SELECT` must be included in `GROUP BY`.

---

> 🔗 **See also**
> - [../01_Aggregate_Functions/theory.md](../01_Aggregate_Functions/theory.md)
> - [../03_ROLLUP_CUBE_GROUPING_SETS/theory.md](../03_ROLLUP_CUBE_GROUPING_SETS/theory.md)
