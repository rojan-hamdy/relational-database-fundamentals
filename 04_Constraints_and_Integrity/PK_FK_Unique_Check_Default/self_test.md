# Self-Test — PK, FK, Unique, Check, Default Constraints & Identity Management

**Q1. What does a Primary Key (PK) do?**

<details>
<summary>Show answer</summary>
It uniquely identifies each row in a table. A primary key must be unique and cannot contain NULL values.
</details>

**Q2. What is an `IDENTITY(seed, increment)` column property?**

<details>
<summary>Show answer</summary>
It creates an auto-incrementing surrogate integer primary key that starts at the given `seed` value and increases by `increment` for each newly inserted row.
</details>

**Q3. How do you manually insert an explicit primary key value into an `IDENTITY` column?**

<details>
<summary>Show answer</summary>
By turning on `SET IDENTITY_INSERT dbo.TableName ON`, performing the `INSERT` with explicit column values, and then turning `SET IDENTITY_INSERT dbo.TableName OFF`.
</details>

**Q4. What command is used to inspect or reset a table's auto-increment counter?**

<details>
<summary>Show answer</summary>
`DBCC CHECKIDENT ('dbo.TableName', RESEED, new_value)`.
</details>

**Q5. What is a Foreign Key (FK)?**

<details>
<summary>Show answer</summary>
A foreign key references the primary key of another table to enforce referential integrity between child and parent records.
</details>

**Q6. What is the difference between a `UNIQUE` constraint and a `PRIMARY KEY`?**

<details>
<summary>Show answer</summary>
A table can have only one `PRIMARY KEY` (which forbids NULLs). A table can have multiple `UNIQUE` constraints (which enforce uniqueness while allowing a single NULL value in SQL Server).
</details>

**Q7. What does a `CHECK` constraint enforce?**

<details>
<summary>Show answer</summary>
It enforces a logical boolean condition or valid range of values on column data (e.g. `CHECK (Price > 0)`).
</details>

**Q8. What is a `DEFAULT` constraint?**

<details>
<summary>Show answer</summary>
It automatically assigns a fallback value (e.g. `DEFAULT GETDATE()`) when a column value is omitted during an `INSERT`.
</details>

---

## Quick revision

- **PK**: Unique row identifier (`NOT NULL` + `UNIQUE`).
- **IDENTITY**: Auto-incrementing surrogate keys (`IDENTITY(seed, increment)`).
- **SET IDENTITY_INSERT**: Allows explicit key value insertions when ON.
- **DBCC CHECKIDENT**: Checks or reseeds (`RESEED`) identity counters.
- **FK**: Guarantees referential relationship between tables.
- **UNIQUE**: Prevents duplicate column values.
- **CHECK**: Enforces valid range/boolean business rules.
- **DEFAULT**: Supplies automatic fallback values.
