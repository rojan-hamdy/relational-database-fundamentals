# Self-Test — Set Operators (UNION, UNION ALL, INTERSECT, EXCEPT)

**Q1. What is the primary functional and performance difference between `UNION` and `UNION ALL`?**

<details>
<summary>Show answer</summary>
`UNION` combines result sets and automatically removes duplicate rows using a sort/distinct phase. `UNION ALL` concatenates all rows from both datasets including duplicates, making `UNION ALL` significantly faster.
</details>

**Q2. What are the two mandatory rules for queries combined with set operators?**

<details>
<summary>Show answer</summary>
1. All `SELECT` statements must return the exact same number of columns.
2. Corresponding columns (in positional order) must have compatible data types.
</details>

**Q3. How does `INTERSECT` differ from an `INNER JOIN` regarding `NULL` values?**

<details>
<summary>Show answer</summary>
`INNER JOIN` evaluates `NULL = NULL` as `UNKNOWN` and excludes `NULL` rows unless explicitly handled. `INTERSECT` treats two `NULL` values as equal and includes them in the intersecting result set if present in both queries.
</details>

**Q4. Given Query A returning `{A, B, C}` and Query B returning `{B, C, D}`, what does `Query A EXCEPT Query B` return?**

<details>
<summary>Show answer</summary>
`{A}`. `EXCEPT` returns distinct rows from the first query that do not exist in the second query.
</details>

**Q5. Where must the `ORDER BY` clause be placed in a set operation query?**

<details>
<summary>Show answer</summary>
The `ORDER BY` clause must be placed at the very end of the entire statement, after the final `SELECT` query.
</details>

---

## Quick revision

- **UNION**: Merges rows & removes duplicates (slower).
- **UNION ALL**: Merges rows & keeps duplicates (faster).
- **INTERSECT**: Returns rows present in both sets (treats NULL as equal).
- **EXCEPT**: Returns rows in the first set absent in the second set.
- **Rule**: Column counts and positional data types must match across all queries.
- **Sorting**: `ORDER BY` belongs at the very end.
