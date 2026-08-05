# Self-Test — JOINs (Inner, Outer, Cross, Self)

> Status: ✅ Ready for practice.

**Q1. What is the purpose of a JOIN?**

<details>
<summary>Show answer</summary>
A JOIN combines rows from two or more tables based on related columns.
</details>

**Q2. What is the difference between INNER JOIN and LEFT JOIN?**

<details>
<summary>Show answer</summary>
INNER JOIN returns only matching rows. LEFT JOIN returns all rows from the left table and NULLs for unmatched rows on the right side.
</details>

**Q3. When would you use RIGHT JOIN?**

<details>
<summary>Show answer</summary>
When you want to preserve every row from the right table and show matches from the left table where they exist.
</details>

**Q4. What is a self-join?**

<details>
<summary>Show answer</summary>
A self-join is when a table is joined to itself, usually to compare records within the same table.
</details>

**Q5. What does CROSS JOIN produce?**

<details>
<summary>Show answer</summary>
A Cartesian product: every row in one table paired with every row in the other table.
</details>

**Q6. Why is the join condition important?**

<details>
<summary>Show answer</summary>
The join condition defines how rows are matched; without a correct condition, the result can be meaningless or too large.
</details>

---

## Quick revision

- INNER JOIN = matches only
- LEFT JOIN = all left rows
- RIGHT JOIN = all right rows
- FULL JOIN = all rows from both tables
- CROSS JOIN = all combinations
- SELF JOIN = table joined to itself
