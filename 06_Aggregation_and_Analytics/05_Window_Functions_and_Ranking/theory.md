# Window Functions & Ranking

## Overview
Window functions perform calculations across a set of table rows related to the current row, **without collapsing the result into a single row** like aggregate functions (`SUM`, `COUNT`, `AVG` with `GROUP BY`) do. Each row keeps its identity, and gets an extra computed value attached to it.

They are widely used for ranking, running totals, moving metrics, and comparisons across partitions (groups) of data.

### Sample table used in every example below

`dbo.Employee`

| EmployeeID | EmployeeName | DepartmentID | Department | Salary |
|---|---|---|---|---|
| 1 | Ahmed  | 10 | Sales      | 5000 |
| 2 | Sara   | 10 | Sales      | 7000 |
| 3 | Omar   | 10 | Sales      | 7000 |
| 4 | Laila  | 10 | Sales      | 4000 |
| 5 | Youssef| 20 | IT         | 9000 |
| 6 | Nour   | 20 | IT         | 9000 |
| 7 | Karim  | 20 | IT         | 6000 |
| 8 | Mona   | 30 | HR         | 5500 |

We'll reuse this table for `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `NTILE`, and `SUM() OVER()` so you can compare results side by side.

---

## 1. ROW_NUMBER()

**What it does:** Assigns a **unique, sequential** integer to each row within the result set (or within each partition), based on the specified `ORDER BY`. No ties — even if two rows have identical values, they still get different numbers (the order between them is arbitrary unless you add a tie-breaker column).

```sql
SELECT EmployeeName, Salary,
       ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RankNumber
FROM dbo.Employee;
```

**Result (whole table, no partition):**

| EmployeeName | Salary | RankNumber |
|---|---|---|
| Youssef | 9000 | 1 |
| Nour    | 9000 | 2 |
| Sara    | 7000 | 3 |
| Omar    | 7000 | 4 |
| Karim   | 6000 | 5 |
| Mona    | 5500 | 6 |
| Ahmed   | 5000 | 7 |
| Laila   | 4000 | 8 |

Notice Youssef and Nour both earn 9000, but they still get different numbers (1 and 2) — `ROW_NUMBER()` never produces ties.

### With PARTITION BY

```sql
SELECT DepartmentID, EmployeeName, Salary,
       ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS DeptRank
FROM dbo.Employee;
```

`PARTITION BY DepartmentID` resets the counter to 1 at the start of every department. Instead of one global ranking, you get one ranking per group:

| DepartmentID | EmployeeName | Salary | DeptRank |
|---|---|---|---|
| 10 | Sara    | 7000 | 1 |
| 10 | Omar    | 7000 | 2 |
| 10 | Ahmed   | 5000 | 3 |
| 10 | Laila   | 4000 | 4 |
| 20 | Youssef | 9000 | 1 |
| 20 | Nour    | 9000 | 2 |
| 20 | Karim   | 6000 | 3 |
| 30 | Mona    | 5500 | 1 |

**Typical use:** picking the "top 1" row per group (e.g. latest order per customer), by wrapping this in a CTE and filtering `WHERE DeptRank = 1`.

---

## 2. RANK() and DENSE_RANK()

**What they do:** Both assign a rank based on `ORDER BY`, and both give **the same rank to tied rows** — this is the key difference from `ROW_NUMBER()`. They differ in what happens *after* a tie:

- `RANK()` skips the following rank number(s) — leaves a gap equal to the number of ties.
- `DENSE_RANK()` does **not** skip — the next rank is always +1 from the previous one.

```sql
SELECT EmployeeName, Salary,
       RANK() OVER (ORDER BY Salary DESC) AS RankValue,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRankValue
FROM dbo.Employee;
```

| EmployeeName | Salary | RankValue | DenseRankValue |
|---|---|---|---|
| Youssef | 9000 | 1 | 1 |
| Nour    | 9000 | 1 | 1 |
| Sara    | 7000 | 3 | 2 |
| Omar    | 7000 | 3 | 2 |
| Karim   | 6000 | 5 | 3 |
| Mona    | 5500 | 6 | 4 |
| Ahmed   | 5000 | 7 | 5 |
| Laila   | 4000 | 8 | 6 |

Look at Sara/Omar: after two rows tied at rank 1, `RANK()` jumps straight to **3** (rank 2 is "used up" by the tie), while `DENSE_RANK()` moves cleanly to **2**.

### With PARTITION BY

```sql
SELECT DepartmentID, EmployeeName, Salary,
       RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS RankValue,
       DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS DenseRankValue
FROM dbo.Employee;
```

| DepartmentID | EmployeeName | Salary | RankValue | DenseRankValue |
|---|---|---|---|---|
| 10 | Sara    | 7000 | 1 | 1 |
| 10 | Omar    | 7000 | 1 | 1 |
| 10 | Ahmed   | 5000 | 3 | 2 |
| 10 | Laila   | 4000 | 4 | 3 |
| 20 | Youssef | 9000 | 1 | 1 |
| 20 | Nour    | 9000 | 1 | 1 |
| 20 | Karim   | 6000 | 3 | 2 |
| 30 | Mona    | 5500 | 1 | 1 |

Again, ranking restarts per department — Sales and IT each have their own #1, independent of salary in other departments.

**Typical use:** "top N per group with ties respected" — e.g. leaderboard where equal scores should share a place.

---

## 3. NTILE(n)

**What it does:** Splits the rows into `n` roughly equal-sized buckets (groups), numbered 1 to `n`, based on the `ORDER BY`. If rows don't divide evenly, the earlier buckets get the extra rows.

```sql
SELECT EmployeeName, Salary,
       NTILE(4) OVER (ORDER BY Salary) AS Quartile
FROM dbo.Employee;
```

| EmployeeName | Salary | Quartile |
|---|---|---|
| Laila   | 4000 | 1 |
| Ahmed   | 5000 | 1 |
| Mona    | 5500 | 2 |
| Karim   | 6000 | 2 |
| Sara    | 7000 | 3 |
| Omar    | 7000 | 3 |
| Youssef | 9000 | 4 |
| Nour    | 9000 | 4 |

With 8 rows and `NTILE(4)`, each bucket gets exactly 2 rows — bucket 1 is the lowest-paid quartile, bucket 4 the highest-paid.

### With PARTITION BY

```sql
SELECT DepartmentID, EmployeeName, Salary,
       NTILE(2) OVER (PARTITION BY DepartmentID ORDER BY Salary) AS SalaryHalf
FROM dbo.Employee;
```

| DepartmentID | EmployeeName | Salary | SalaryHalf |
|---|---|---|---|
| 10 | Laila   | 4000 | 1 |
| 10 | Ahmed   | 5000 | 1 |
| 10 | Sara    | 7000 | 2 |
| 10 | Omar    | 7000 | 2 |
| 20 | Karim   | 6000 | 1 |
| 20 | Youssef | 9000 | 2 |
| 20 | Nour    | 9000 | 2 |
| 30 | Mona    | 5500 | 1 |

Now bucketing happens **inside each department** — Sales is split into its own lower/upper half, and IT into its own, instead of one company-wide split.

**Typical use:** dividing customers into spending quartiles, students into performance bands, etc.

---

## 4. SUM() OVER() — running total

**What it does:** Instead of collapsing rows into one total (like `SUM()` with `GROUP BY` would), `SUM(...) OVER (ORDER BY ...)` keeps every row and adds a cumulative sum computed up to that row, based on the specified order.

```sql
SELECT EmployeeName, Salary,
       SUM(Salary) OVER (ORDER BY EmployeeID) AS RunningTotal
FROM dbo.Employee;
```

| EmployeeName | Salary | RunningTotal |
|---|---|---|
| Ahmed   | 5000 | 5000 |
| Sara    | 7000 | 12000 |
| Omar    | 7000 | 19000 |
| Laila   | 4000 | 23000 |
| Youssef | 9000 | 32000 |
| Nour    | 9000 | 41000 |
| Karim   | 6000 | 47000 |
| Mona    | 5500 | 52500 |

Each row's `RunningTotal` = sum of its own salary + all salaries in rows before it (per the `ORDER BY`).

### With PARTITION BY

```sql
SELECT DepartmentID, EmployeeName, Salary,
       SUM(Salary) OVER (PARTITION BY DepartmentID ORDER BY EmployeeID) AS DeptRunningTotal
FROM dbo.Employee;
```

| DepartmentID | EmployeeName | Salary | DeptRunningTotal |
|---|---|---|---|
| 10 | Ahmed   | 5000 | 5000 |
| 10 | Sara    | 7000 | 12000 |
| 10 | Omar    | 7000 | 19000 |
| 10 | Laila   | 4000 | 23000 |
| 20 | Youssef | 9000 | 9000 |
| 20 | Nour    | 9000 | 18000 |
| 20 | Karim   | 6000 | 24000 |
| 30 | Mona    | 5500 | 5500 |

The running total **resets at the start of each department** instead of continuing across the whole table — IT's running total starts fresh at 9000 rather than continuing from Sales' 23000.

**Typical use:** cumulative sales by day, running balance per account, year-to-date totals per branch.

---

## 5. LAG() and LEAD()

**What they do:** Let you look at a value from **another row** relative to the current one, without a self-join. `LAG()` looks *backward* (previous row), `LEAD()` looks *forward* (next row), based on the `ORDER BY`. Both accept an optional second argument for how many rows to offset (default 1), and an optional third argument as a default value when there's no such row (otherwise it returns `NULL`).

```sql
SELECT EmployeeName, Salary,
       LAG(Salary, 1) OVER (ORDER BY EmployeeID) AS PrevSalary,
       LEAD(Salary, 1) OVER (ORDER BY EmployeeID) AS NextSalary
FROM dbo.Employee;
```

| EmployeeName | Salary | PrevSalary | NextSalary |
|---|---|---|---|
| Ahmed   | 5000 | NULL | 7000 |
| Sara    | 7000 | 5000 | 7000 |
| Omar    | 7000 | 7000 | 4000 |
| Laila   | 4000 | 7000 | 9000 |
| Youssef | 9000 | 4000 | 9000 |
| Nour    | 9000 | 9000 | 6000 |
| Karim   | 6000 | 9000 | 5500 |
| Mona    | 5500 | 6000 | NULL |

Ahmed is the first row in this order, so `PrevSalary` is `NULL` (no row before it). Mona is the last, so `NextSalary` is `NULL`.

### With PARTITION BY

```sql
SELECT DepartmentID, EmployeeName, Salary,
       LAG(Salary, 1) OVER (PARTITION BY DepartmentID ORDER BY EmployeeID) AS PrevDeptSalary,
       LEAD(Salary, 1) OVER (PARTITION BY DepartmentID ORDER BY EmployeeID) AS NextDeptSalary
FROM dbo.Employee;
```

| DepartmentID | EmployeeName | Salary | PrevDeptSalary | NextDeptSalary |
|---|---|---|---|---|
| 10 | Ahmed   | 5000 | NULL | 7000 |
| 10 | Sara    | 7000 | 5000 | 7000 |
| 10 | Omar    | 7000 | 7000 | 4000 |
| 10 | Laila   | 4000 | 7000 | NULL |
| 20 | Youssef | 9000 | NULL | 9000 |
| 20 | Nour    | 9000 | 9000 | 6000 |
| 20 | Karim   | 6000 | 9000 | NULL |
| 30 | Mona    | 5500 | NULL | NULL |

Without partitioning, Laila (last in Sales) would "see" Youssef's 9000 as her `NextSalary` — but with `PARTITION BY DepartmentID`, the lookback/lookahead **never crosses department boundaries**, so Laila correctly gets `NULL` and Youssef (first in IT) also gets `NULL` for `PrevDeptSalary`.

**Typical use:** month-over-month comparison, detecting a change from the previous row, calculating the gap between consecutive events.

---

## 6. FIRST_VALUE() and LAST_VALUE()

**What they do:** Return a value from the **first** or **last** row of the window, based on `ORDER BY`, and repeat it across every row in that window.

⚠️ `LAST_VALUE()` has a common gotcha: by default the window frame only extends up to the *current row*, so `LAST_VALUE()` often just returns the current row's own value unless you explicitly widen the frame with `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING`.

```sql
SELECT EmployeeName, Salary,
       FIRST_VALUE(EmployeeName) OVER (ORDER BY Salary DESC) AS HighestPaid,
       LAST_VALUE(EmployeeName) OVER (
           ORDER BY Salary DESC
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS LowestPaid
FROM dbo.Employee;
```

| EmployeeName | Salary | HighestPaid | LowestPaid |
|---|---|---|---|
| Youssef | 9000 | Youssef | Laila |
| Nour    | 9000 | Youssef | Laila |
| Sara    | 7000 | Youssef | Laila |
| Omar    | 7000 | Youssef | Laila |
| Karim   | 6000 | Youssef | Laila |
| Mona    | 5500 | Youssef | Laila |
| Ahmed   | 5000 | Youssef | Laila |
| Laila   | 4000 | Youssef | Laila |

Every row gets the same `HighestPaid`/`LowestPaid` value — it's like tagging each row with "who's #1 and who's last in this window."

### With PARTITION BY

```sql
SELECT DepartmentID, EmployeeName, Salary,
       FIRST_VALUE(EmployeeName) OVER (
           PARTITION BY DepartmentID ORDER BY Salary DESC
       ) AS TopEarnerInDept,
       LAST_VALUE(EmployeeName) OVER (
           PARTITION BY DepartmentID ORDER BY Salary DESC
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS LowestEarnerInDept
FROM dbo.Employee;
```

| DepartmentID | EmployeeName | Salary | TopEarnerInDept | LowestEarnerInDept |
|---|---|---|---|---|
| 10 | Sara    | 7000 | Sara    | Laila |
| 10 | Omar    | 7000 | Sara    | Laila |
| 10 | Ahmed   | 5000 | Sara    | Laila |
| 10 | Laila   | 4000 | Sara    | Laila |
| 20 | Youssef | 9000 | Youssef | Karim |
| 20 | Nour    | 9000 | Youssef | Karim |
| 20 | Karim   | 6000 | Youssef | Karim |
| 30 | Mona    | 5500 | Mona    | Mona  |

Now each department gets its **own** top earner and lowest earner tagged onto every row of that department, instead of one company-wide answer.

**Typical use:** showing "highest score in this class" next to every student's row, comparing each row to the best/worst in its group.

---

## 7. PERCENT_RANK()

**What it does:** Calculates the **relative rank** of a row as a value between 0 and 1, using the formula `(rank - 1) / (total_rows - 1)`. The lowest-ranked row always gets `0`, the highest-ranked row always gets `1`, and everyone else falls proportionally in between. Unlike `RANK()`, it expresses "how far up the list" a row is, not its raw position.

```sql
SELECT EmployeeName, Salary,
       RANK() OVER (ORDER BY Salary) AS RankValue,
       PERCENT_RANK() OVER (ORDER BY Salary) AS PctRank
FROM dbo.Employee;
```

| EmployeeName | Salary | RankValue | PctRank |
|---|---|---|---|
| Laila   | 4000 | 1 | 0.000 |
| Ahmed   | 5000 | 2 | 0.143 |
| Mona    | 5500 | 3 | 0.286 |
| Karim   | 6000 | 4 | 0.429 |
| Sara    | 7000 | 5 | 0.571 |
| Omar    | 7000 | 5 | 0.571 |
| Youssef | 9000 | 7 | 0.857 |
| Nour    | 9000 | 7 | 0.857 |

With 8 rows, `PctRank = (RankValue - 1) / (8 - 1)`. Laila (lowest) sits at 0.0, and the two top earners sit at 0.857 (not 1.0, because `RANK()` — not `ROW_NUMBER()` — feeds the formula and their tie pulls the value down slightly from what a solo top earner would get).

### With PARTITION BY

```sql
SELECT DepartmentID, EmployeeName, Salary,
       PERCENT_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary) AS PctRankInDept
FROM dbo.Employee;
```

| DepartmentID | EmployeeName | Salary | PctRankInDept |
|---|---|---|---|
| 10 | Laila   | 4000 | 0.000 |
| 10 | Ahmed   | 5000 | 0.333 |
| 10 | Sara    | 7000 | 0.667 |
| 10 | Omar    | 7000 | 0.667 |
| 20 | Karim   | 6000 | 0.000 |
| 20 | Youssef | 9000 | 0.500 |
| 20 | Nour    | 9000 | 0.500 |
| 30 | Mona    | 5500 | 0.000 |

The 0-to-1 scale now recalculates **within each department** (denominator = department's row count − 1), so Karim (lowest in IT) gets 0.000 just like Laila (lowest in Sales), even though their salaries differ.

**Typical use:** percentile scoring (e.g. "this student scored better than X% of their class"), normalizing rank across groups of different sizes.

---

## 8. How PARTITION BY works, in general

`PARTITION BY` doesn't filter or group rows away like `GROUP BY` does — it just tells the window function **"reset your calculation whenever this column's value changes."**

- Without `PARTITION BY`: the function sees the *entire result set* as one window.
- With `PARTITION BY column`: the function sees the result set broken into independent windows, one per distinct value of `column`, and the calculation (numbering, ranking, summing, bucketing) restarts at the top of each one.

Rows are always still returned individually — `PARTITION BY` never reduces row count, it only changes what each row is compared against.

---

## 9. Common use cases

- Top-N performers per department (`ROW_NUMBER` / `RANK` + `PARTITION BY`)
- Running total of sales, overall or per branch (`SUM() OVER`)
- Ranking students by score, with or without ties (`RANK` vs `DENSE_RANK`)
- Splitting data into quartiles/bands per group (`NTILE` + `PARTITION BY`)
- Calculating moving/cumulative metrics over time
- Comparing a row to the previous/next row, e.g. month-over-month change (`LAG` / `LEAD`)
- Tagging every row with the group's best/worst value (`FIRST_VALUE` / `LAST_VALUE`)
- Percentile scoring, e.g. "better than X% of the class" (`PERCENT_RANK`)

---

## 10. Key takeaways

Window functions let you:
- Rank rows (`ROW_NUMBER`, `RANK`, `DENSE_RANK`, `PERCENT_RANK`)
- Bucket rows into equal groups (`NTILE`)
- Compute running/cumulative values (`SUM() OVER`)
- Look at neighboring rows without a self-join (`LAG`, `LEAD`)
- Pull a value from the top/bottom of a window into every row (`FIRST_VALUE`, `LAST_VALUE`)
- Do all of the above **per group** instead of across the whole table, using `PARTITION BY`

> 💡 **Core idea**
> Window functions keep row-level detail while computing analytical values contextually across the set of rows related to the current row. `PARTITION BY` is what lets you scope that context to a group instead of the whole table.

---

> 🔗 **See also**
> - [../01_Aggregate_Functions/theory.md](../01_Aggregate_Functions/theory.md)
> - [../06_Built_in_Functions/theory.md](../06_Built_in_Functions/theory.md)
