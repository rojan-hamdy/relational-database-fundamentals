# Self-Test — Window Functions & Ranking

**Q1. What is a window function?**

<details>
<summary>Show answer</summary>
A window function performs calculations across a set of rows related to the current row without collapsing the result set.
</details>

**Q2. What does ROW_NUMBER() do?**

<details>
<summary>Show answer</summary>
It assigns a unique sequential number to each row in a result set.
</details>

**Q3. What is the difference between RANK() and DENSE_RANK()?**

<details>
<summary>Show answer</summary>
RANK() leaves gaps after ties; DENSE_RANK() keeps consecutive ranks.
</details>

**Q4. What does PARTITION BY do in a window function?**

<details>
<summary>Show answer</summary>
It divides the data into subsets before the window calculation is applied.
</details>

**Q5. Why are window functions useful?**

<details>
<summary>Show answer</summary>
They allow ranking, cumulative totals, and per-group comparisons without losing row-level details.
</details>

**Q6. Give one example of a running calculation using a window function.**

<details>
<summary>Show answer</summary>
A cumulative sum of sales over time.
</details>

---

## Quick revision

- ROW_NUMBER = unique sequence
- RANK = gap after ties
- DENSE_RANK = no gap after ties
- PARTITION BY = separate calculation groups
