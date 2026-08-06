# Self-Test: Set Operators (UNION, UNION ALL, INTERSECT, EXCEPT)

Test your knowledge of set operations in SQL Server.

---

### Q1. What is the primary functional difference between `UNION` and `UNION ALL`?
**Answer**: `UNION` combines result sets and automatically removes duplicate rows using a sort/distinct phase. `UNION ALL` concatenates all rows from both datasets including duplicates, making `UNION ALL` significantly faster.

---

### Q2. What are the two mandatory rules for queries combined with set operators?
**Answer**:
1. All `SELECT` statements must return the exact same number of columns.
2. Corresponding columns (in positional order) must have compatible data types.

---

### Q3. How does `INTERSECT` differ from an `INNER JOIN` regarding `NULL` values?
**Answer**: `INNER JOIN` evaluates `NULL = NULL` as `UNKNOWN` and excludes `NULL` rows unless explicitly handled. `INTERSECT` treats two `NULL` values as equal and includes them in the intersecting result set if present in both queries.

---

### Q4. Given Query A returning `{A, B, C}` and Query B returning `{B, C, D}`, what does `Query A EXCEPT Query B` return?
**Answer**: `{A}`. `EXCEPT` returns distinct rows from the first query that do not exist in the second query.

---

### Q5. Where must the `ORDER BY` clause be placed in a set operation query?
**Answer**: The `ORDER BY` clause must be placed at the very end of the entire statement, after the final `SELECT` query.
