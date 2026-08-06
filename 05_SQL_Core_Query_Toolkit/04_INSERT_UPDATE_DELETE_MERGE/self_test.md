# Self-Test — INSERT, UPDATE, DELETE, TRUNCATE, MERGE & SELECT INTO

**Q1. What is the main difference between `INSERT INTO ... SELECT` and `SELECT INTO`?**

<details>
<summary>Show answer</summary>
`INSERT INTO ... SELECT` requires the target table to **already exist**. `SELECT INTO` creates a **new table on the fly** based on the columns and data returned by the query.
</details>

**Q2. When using `SELECT INTO`, which table objects/constraints are NOT copied to the new table?**

<details>
<summary>Show answer</summary>
Primary Keys, Foreign Keys, Indexes, Triggers, Check Constraints, Default Constraints, and explicit Table Permissions are lost. (Column names, data types, nullability, and the `IDENTITY` property are copied).
</details>

**Q3. What are the key architectural differences between `TRUNCATE TABLE` and `DELETE FROM`?**

<details>
<summary>Show answer</summary>
- Category: `TRUNCATE` is DDL; `DELETE` is DML.
- Operation: `TRUNCATE` deallocates data pages (minimally logged); `DELETE` removes rows individually (fully logged).
- Identity: `TRUNCATE` resets identity seed; `DELETE` does not.
- Speed: `TRUNCATE` is significantly faster on large tables.
</details>

**Q4. Can `TRUNCATE TABLE` be executed on a table referenced by a Foreign Key constraint?**

<details>
<summary>Show answer</summary>
No. `TRUNCATE TABLE` cannot be run if the table is referenced by any Foreign Key constraint from another table, even if the referencing table is empty.
</details>

**Q5. Can `TRUNCATE TABLE` be rolled back inside an explicit transaction?**

<details>
<summary>Show answer</summary>
Yes. Contrary to popular belief, `TRUNCATE TABLE` **can be rolled back** if executed inside a `BEGIN TRANSACTION...ROLLBACK TRANSACTION` block.
</details>

**Q6. What does the `MERGE` statement accomplish?**

<details>
<summary>Show answer</summary>
`MERGE` combines `INSERT`, `UPDATE`, and `DELETE` operations into a single atomic statement to synchronize a target table with a source table.
</details>

---

## Quick revision

- **INSERT SELECT**: Appends query results into an existing table.
- **SELECT INTO**: Creates a new table dynamically from query results.
- **TRUNCATE**: Fast DDL page deallocation; resets identity; cannot run if referenced by FK.
- **DELETE**: DML row-by-row removal; retains identity counter.
- **MERGE**: Upserts and synchronizes tables in one operation.
