# Self-Test — GROUP BY & HAVING

> Status: ✅ Ready for practice.

**Q1. What does GROUP BY do?**

<details>
<summary>Show answer</summary>
It groups rows that share the same values in one or more columns.
</details>

**Q2. What does HAVING do?**

<details>
<summary>Show answer</summary>
HAVING filters grouped results after aggregation.
</details>

**Q3. What is the main difference between WHERE and HAVING?**

<details>
<summary>Show answer</summary>
WHERE filters rows before grouping, while HAVING filters groups after aggregate calculations.
</details>

**Q4. Write a query that counts students per department.**

<details>
<summary>Show answer</summary>
```sql
SELECT DepartmentID, COUNT(*) AS NumberOfStudents
FROM Student
GROUP BY DepartmentID;
```
</details>

**Q5. Which clause would you use to show only departments with more than 5 students?**

<details>
<summary>Show answer</summary>
HAVING COUNT(*) > 5.
</details>

**Q6. Why are GROUP BY and HAVING essential for reporting?**

<details>
<summary>Show answer</summary>
They let you summarize data by category and filter those summaries.
</details>

---

## Quick revision

- GROUP BY = aggregate by category
- HAVING = filter aggregated groups
- WHERE = filter rows before grouping
