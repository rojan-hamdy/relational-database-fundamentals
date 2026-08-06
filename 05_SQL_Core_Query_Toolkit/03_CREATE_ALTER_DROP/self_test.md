# Self-Test — CREATE, ALTER, DROP, Schemas & Identity Management

**Q1. What is a Schema in SQL Server, and why is it useful?**

<details>
<summary>Show answer</summary>
A Schema is a logical container and security boundary inside a database. It allows object grouping (`schema.object`), namespace isolation, and granting permissions at the schema level.
</details>

**Q2. How do you move an existing table named `dbo.Student` into the `sales` schema?**

<details>
<summary>Show answer</summary>
Using `ALTER SCHEMA sales TRANSFER dbo.Student;`.
</details>

**Q3. What does `IDENTITY(100, 10)` mean when defining a primary key column?**

<details>
<summary>Show answer</summary>
It creates an auto-incrementing column that starts at a seed value of `100` and increments by `10` for every new row inserted.
</details>

**Q4. What is the purpose of `SET IDENTITY_INSERT dbo.TableName ON`?**

<details>
<summary>Show answer</summary>
It temporarily allows manual explicit insertion of specific key values into an `IDENTITY` column (e.g. during data migrations).
</details>

**Q5. How can you check or reset the current identity counter of a table?**

<details>
<summary>Show answer</summary>
By using `DBCC CHECKIDENT ('dbo.TableName', NORESEED)` to inspect, or `DBCC CHECKIDENT ('dbo.TableName', RESEED, new_value)` to reset the counter.
</details>

**Q6. Why is `SCOPE_IDENTITY()` safer than `@@IDENTITY` in application queries?**

<details>
<summary>Show answer</summary>
`SCOPE_IDENTITY()` returns the last identity value generated within the current scope (current query or procedure). `@@IDENTITY` returns the last identity value generated anywhere in the session, which can be altered by triggers inserting rows into audit tables.
</details>

---

## Quick revision

- **CREATE / ALTER / DROP**: Manage database object blueprints.
- **Schemas**: Logical security containers (`CREATE SCHEMA`, `ALTER SCHEMA TRANSFER`).
- **IDENTITY**: Auto-incrementing surrogate keys (`IDENTITY(seed, increment)`).
- **SET IDENTITY_INSERT**: Allows explicit identity value insertion.
- **DBCC CHECKIDENT**: Inspects or resets (`RESEED`) identity counters.
- **SCOPE_IDENTITY()**: Returns newly generated ID in current scope.
