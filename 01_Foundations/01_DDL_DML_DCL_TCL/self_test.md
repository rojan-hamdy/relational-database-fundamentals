# Self-Test — DDL, DML, DCL, TCL — Definitions & Function of Each

> Status: ✅ Ready for practice.

**Q1. What does DDL stand for, and what is its main function?**

<details>
<summary>Show answer</summary>
DDL stands for Data Definition Language. It defines or changes the structure of database objects using commands like CREATE, ALTER, and DROP.
</details>

**Q2. Which category of SQL is used to add, change, and delete records in a table?**

<details>
<summary>Show answer</summary>
DML, or Data Manipulation Language. It uses commands such as INSERT, UPDATE, DELETE, and SELECT.
</details>

**Q3. What is the purpose of DCL in SQL Server?**

<details>
<summary>Show answer</summary>
DCL controls permissions and access. It uses GRANT, REVOKE, and similar commands to allow or restrict user access to database objects.
</details>

**Q4. What does TCL manage, and which commands belong to it?**

<details>
<summary>Show answer</summary>
TCL manages transactions, ensuring that related changes are saved or undone as a single unit. Common commands are BEGIN TRANSACTION, COMMIT, ROLLBACK, and SAVE TRANSACTION.
</details>

**Q5. Which would you use to create a new table: DDL, DML, DCL, or TCL?**

<details>
<summary>Show answer</summary>
DDL. Example: CREATE TABLE Students (...);
</details>

**Q6. Why is COMMIT important in a transaction?**

<details>
<summary>Show answer</summary>
COMMIT permanently saves the transaction changes. If the operation fails, ROLLBACK can undo the changes instead.
</details>

**Q7. How is DDL different from DML?**

<details>
<summary>Show answer</summary>
DDL changes the database structure (schema), while DML changes the actual data stored in that structure.
</details>

**Q8. Give one example of a DCL command and one example of a TCL command.**

<details>
<summary>Show answer</summary>
DCL example: GRANT SELECT ON Students TO AppUser;
TCL example: BEGIN TRANSACTION; COMMIT;
</details>

---

## Quick Revision

- DDL = structure
- DML = data
- DCL = permissions
- TCL = transaction control

> 🧪 **Try it yourself**
> Create a table, insert data, grant a user access, and then wrap the operation in a transaction. Observe the difference between schema changes, data changes, permissions, and commit/rollback behavior.

