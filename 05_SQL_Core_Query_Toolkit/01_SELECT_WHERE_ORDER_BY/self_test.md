# Self-Test — SELECT, WHERE, ORDER BY & Query Fundamentals

**Q1. What is the logical query processing order (order of execution) in SQL Server?**

<details>
<summary>Show answer</summary>
The logical execution order is:
1. `FROM`
2. `ON`
3. `JOIN`
4. `WHERE`
5. `GROUP BY`
6. `HAVING`
7. `SELECT`
8. `DISTINCT`
9. `ORDER BY`
10. `TOP` / `OFFSET-FETCH`
</details>

**Q2. Why can't you use a column alias defined in the `SELECT` clause inside the `WHERE` clause?**

<details>
<summary>Show answer</summary>
Because the `WHERE` clause (step 4) executes **before** the `SELECT` clause (step 7) in the logical query processing order, so the column alias does not exist yet when `WHERE` is evaluated.
</details>

**Q3. How does the `LIKE` wildcard `_` differ from `%`?**

<details>
<summary>Show answer</summary>
`%` matches any sequence of zero or more characters, whereas `_` matches **exactly one** single character.
</details>

**Q4. What is the difference between `LIKE 'ABC%'` and `LIKE '%ABC'` regarding performance?**

<details>
<summary>Show answer</summary>
`LIKE 'ABC%'` is SARGable (Search Argument Able), meaning SQL Server can perform an index seek. `LIKE '%ABC'` starts with a wildcard and is non-SARGable, forcing SQL Server to scan the entire index or table.
</details>

**Q5. How do you search for a string that contains a literal `%` character?**

<details>
<summary>Show answer</summary>
By using the `ESCAPE` clause, for example: `WHERE Code LIKE '%10\%' ESCAPE '\'`.
</details>

**Q6. What does `TOP (3) WITH TIES` do when used with an `ORDER BY` clause?**

<details>
<summary>Show answer</summary>
It returns the top 3 rows plus any additional rows that share the exact same sort value as the 3rd row according to the `ORDER BY` criteria.
</details>

**Q7. How do `CASE` and `IIF()` differ?**

<details>
<summary>Show answer</summary>
`CASE` is a full ANSI-standard conditional expression supporting multiple `WHEN...THEN` branches. `IIF(condition, true_val, false_val)` is a T-SQL inline ternary function that acts as a shorthand for a two-way `CASE` expression.
</details>

**Q8. How can you randomly sort or pick a random row from a table?**

<details>
<summary>Show answer</summary>
By ordering by `NEWID()`, for example: `SELECT TOP (1) * FROM Student ORDER BY NEWID();`.
</details>

---

## Quick revision

- **Execution Order**: `FROM` → `WHERE` → `SELECT` → `ORDER BY` → `TOP`. Aliases in `SELECT` cannot be used in `WHERE`.
- **LIKE**: `%` (many chars), `_` (1 char), `[...]` (range/set), `ESCAPE` for literal `%` or `_`.
- **TOP WITH TIES**: Requires `ORDER BY`; includes rows tied with the cutoff value.
- **CASE / IIF**: Inline conditional evaluation.
- **NEWID()**: Sorts rows in random order.
