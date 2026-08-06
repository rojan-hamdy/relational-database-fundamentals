# Self-Test — Subqueries (Scalar, Correlated, ALL, ANY/SOME)

**Q1. What happens if a scalar subquery used in a `WHERE score = (subquery)` clause returns 3 rows?**

<details>
<summary>Show answer</summary>
SQL Server throws a runtime error (Error 512: *"Subquery returned more than 1 value"*), because a scalar comparison operator expects exactly one value.
</details>

**Q2. What is the fundamental difference between `> ALL` and `> ANY`?**

<details>
<summary>Show answer</summary>
- `> ALL (subquery)` evaluates to `TRUE` only if the outer value is greater than **every single value** returned by the subquery (equivalent to `> MAX(subquery)`).
- `> ANY (subquery)` evaluates to `TRUE` if the outer value is greater than **at least one value** returned by the subquery (equivalent to `> MIN(subquery)`).
</details>

**Q3. What is the relation between `= ANY (subquery)` and `IN (subquery)`?**

<details>
<summary>Show answer</summary>
They are functionally identical. `= ANY` evaluates to `TRUE` if the value matches any row in the subquery set, exactly like `IN`.
</details>

**Q4. Why is `NOT IN` dangerous when the subquery returns a dataset containing a `NULL` value?**

<details>
<summary>Show answer</summary>
In SQL three-valued logic, comparing any value against `NULL` results in `UNKNOWN`. If a subquery returns a set containing `NULL`, `x NOT IN (val1, val2, NULL)` becomes `x <> val1 AND x <> val2 AND x <> NULL`. Since `x <> NULL` is `UNKNOWN`, the entire condition evaluates to `UNKNOWN`/`FALSE`, returning 0 rows. Using `NOT EXISTS` avoids this issue.
</details>

**Q5. What makes a correlated subquery different from a standard non-correlated subquery?**

<details>
<summary>Show answer</summary>
A correlated subquery references columns from the outer query table, requiring the inner subquery to be executed once for every candidate row evaluated by the outer query.
</details>

---

## Quick revision

- **Scalar Subquery**: Returns 1 row, 1 column.
- **Correlated Subquery**: References outer columns; evaluates per outer row.
- **EXISTS**: Efficient existence check; short-circuits on first match.
- **ALL**: Must satisfy condition against **every** element (`> ALL` = `> MAX`).
- **ANY / SOME**: Satisfies condition if **at least one** element matches (`> ANY` = `> MIN`, `= ANY` = `IN`).
- **NULL Trap**: `NOT IN` or `<> ALL` returns 0 rows if subquery contains `NULL`. Use `NOT EXISTS` instead.
