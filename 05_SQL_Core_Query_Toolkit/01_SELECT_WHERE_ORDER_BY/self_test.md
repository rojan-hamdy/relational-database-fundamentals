# Self-Test — SELECT, WHERE, ORDER BY

> Status: ✅ Ready for practice.

**Q1. What does SELECT do?**

<details>
<summary>Show answer</summary>
SELECT retrieves columns from a table or tables.
</details>

**Q2. What is the purpose of WHERE?**

<details>
<summary>Show answer</summary>
WHERE filters rows based on a condition.
</details>

**Q3. What does ORDER BY do?**

<details>
<summary>Show answer</summary>
ORDER BY sorts the result set in ascending or descending order.
</details>

**Q4. Why is SELECT * often discouraged in production?**

<details>
<summary>Show answer</summary>
It may return unnecessary columns and reduce performance.
</details>

**Q5. Write a query that shows students older than 20 sorted by age descending.**

<details>
<summary>Show answer</summary>
```sql
SELECT StudentName, Age
FROM Student
WHERE Age > 20
ORDER BY Age DESC;
```
</details>

**Q6. Which clause is used to restrict rows before sorting?**

<details>
<summary>Show answer</summary>
WHERE is used before sorting, and ORDER BY is used after the row set is produced.
</details>

---

## Quick revision

- SELECT = choose columns
- WHERE = filter rows
- ORDER BY = sort result set
