# Self-Test — Database System Concepts and Architecture


**Q1. What is the difference between a database and a DBMS?**

<details>
<summary>Show answer</summary>
A database is the stored data and its structure. A DBMS is the software system that manages, secures, queries, and maintains that data.
</details>

**Q2. What are the three database architecture levels?**

<details>
<summary>Show answer</summary>
External level, conceptual level, and internal level.
</details>

**Q3. What is a schema?**

<details>
<summary>Show answer</summary>
A schema is the logical structure of the database, including tables, columns, relationships, and constraints. In PostgreSQL, "schema" also refers to a namespace (such as the default `public` schema) that groups related tables within a database.
</details>

**Q4. What does the query processor do?**

<details>
<summary>Show answer</summary>
It parses SQL, optimizes execution plans, and runs the queries efficiently. In PostgreSQL, the planner's chosen execution plan can be inspected with `EXPLAIN`.
</details>

**Q5. Why is concurrency control important?**

<details>
<summary>Show answer</summary>
Because multiple users may access or update the same data at the same time. Concurrency control prevents inconsistent results. PostgreSQL handles this primarily through MVCC (Multi-Version Concurrency Control) rather than heavy locking.
</details>

**Q6. What is the purpose of the recovery manager?**

<details>
<summary>Show answer</summary>
It helps restore the database after a system crash or failure by using logs and recovery procedures. PostgreSQL implements this via Write-Ahead Logging (WAL).
</details>

**Q7. What is the main difference between the conceptual and internal levels?**

<details>
<summary>Show answer</summary>
The conceptual level describes the logical design of the data, while the internal level describes how it is physically stored and accessed.
</details>

**Q8. In PostgreSQL, which tool is commonly used to create databases and tables graphically?**

<details>
<summary>Show answer</summary>
pgAdmin.
</details>

---

## Quick review

- Database = stored data
- DBMS = software managing the data
- Schema = design structure (and, in PostgreSQL, also a namespace within a database)
- Instance = current data state at a point in time (and, in PostgreSQL, the running server/cluster)
- Architecture levels = external, conceptual, internal
- Core DBMS responsibilities = storage, query processing, transaction control, recovery, security
