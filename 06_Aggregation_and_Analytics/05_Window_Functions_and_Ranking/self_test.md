# Self-Test — Window Functions & Ranking

**Q1. What is a window function?**
<details>
<summary>Show answer</summary>
A window function performs calculations across a set of rows related to the current row without collapsing the result set.
</details>

**Q2. What does ROW_NUMBER() do?**
<details>
<summary>Show answer</summary>
It assigns a unique sequential number to each row in a result set. Even tied values get different numbers.
</details>

**Q3. What is the difference between RANK() and DENSE_RANK()?**
<details>
<summary>Show answer</summary>
Both give the same rank to tied rows. RANK() then skips the following rank number(s), leaving a gap; DENSE_RANK() keeps ranks consecutive with no gap.
</details>

**Q4. What does NTILE(n) do?**
<details>
<summary>Show answer</summary>
It divides the rows into n roughly equal-sized buckets, numbered 1 to n, based on the ORDER BY. If rows don't divide evenly, the earlier buckets get the extra rows.
</details>

**Q5. What does SUM() OVER(ORDER BY ...) calculate, and how is it different from SUM() with GROUP BY?**
<details>
<summary>Show answer</summary>
It calculates a running (cumulative) total up to each row while keeping every row in the result — unlike GROUP BY, which collapses rows into one total per group.
</details>

**Q6. What do LAG() and LEAD() do?**
<details>
<summary>Show answer</summary>
LAG() returns a value from a previous row, and LEAD() returns a value from a following row, based on the ORDER BY — without needing a self-join. If there's no such row, the result is NULL unless a default is specified.
</details>

**Q7. What's the difference between FIRST_VALUE() and LAST_VALUE()?**
<details>
<summary>Show answer</summary>
FIRST_VALUE() returns a value from the first row of the window; LAST_VALUE() returns a value from the last row. Both repeat that value across every row in the window. LAST_VALUE() commonly needs an explicit frame (ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) — otherwise it defaults to the current row's own value.
</details>

**Q8. What does PERCENT_RANK() return?**
<details>
<summary>Show answer</summary>
A value between 0 and 1 showing a row's relative rank in the result set, calculated as (rank - 1) / (total_rows - 1). The lowest-ranked row is 0 and the highest-ranked row is 1.
</details>

**Q9. What does PARTITION BY do in a window function?**
<details>
<summary>Show answer</summary>
It divides the rows into independent groups by the given column, and the window calculation restarts at the top of each group instead of running across the whole result set. It never removes or collapses rows.
</details>

**Q10. Why are window functions useful?**
<details>
<summary>Show answer</summary>
They allow ranking, cumulative totals, row-to-row comparisons, and per-group analysis without losing row-level detail.
</details>

**Q11. Give one example of a running calculation using a window function.**
<details>
<summary>Show answer</summary>
A cumulative sum of sales over time, e.g. SUM(Sales) OVER (ORDER BY Date).
</details>

**Q12. If a table has 8 rows split evenly across 2 departments, and you use ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC), what's the highest number you'd see?**
<details>
<summary>Show answer</summary>
4 — the count resets to 1 at the start of each department, so with 4 rows per department the numbering never exceeds 4.
</details>

---

## Quick revision

- **ROW_NUMBER** = unique sequence, no ties
- **RANK** = gap after ties
- **DENSE_RANK** = no gap after ties
- **NTILE(n)** = splits rows into n equal buckets
- **SUM() OVER** = running/cumulative total, keeps all rows
- **LAG / LEAD** = look at previous / next row's value
- **FIRST_VALUE / LAST_VALUE** = value from the top / bottom of the window, repeated on every row
- **PERCENT_RANK** = relative rank as a 0–1 value
- **PARTITION BY** = restarts the calculation for each group, without dropping rows
