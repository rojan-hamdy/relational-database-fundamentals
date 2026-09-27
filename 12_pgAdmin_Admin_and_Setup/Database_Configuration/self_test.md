# Self-Test — pgAdmin & PostgreSQL Database Configuration

**Q1. Where do you configure database properties in pgAdmin?**

<details>
<summary>Show answer</summary>
Right-click the database in the Browser panel → select Properties...
</details>

**Q2. What are common database properties configured in PostgreSQL?**

<details>
<summary>Show answer</summary>
Encoding (e.g. UTF8), Database Owner, Tablespaces, Connection Limits, search_path, and per-database parameters.
</details>

**Q3. What is a PostgreSQL Tablespace?**

<details>
<summary>Show answer</summary>
A storage location on disk where PostgreSQL stores database files (e.g., mapping high-throughput databases to SSD drives).
</details>

**Q4. Why is setting a connection limit on a database important?**

<details>
<summary>Show answer</summary>
Because each connection spawns a PostgreSQL process; limiting connections prevents resource exhaustion.
</details>

**Q5. What is the SQL command to create a database with a specific owner in PostgreSQL?**

<details>
<summary>Show answer</summary>
CREATE DATABASE DatabaseName WITH OWNER = RoleName ENCODING = 'UTF8';
</details>

**Q6. Why should admins review default permissions (ALTER DEFAULT PRIVILEGES)?**

<details>
<summary>Show answer</summary>
Because default privileges determine whether newly created tables in a schema are automatically accessible to designated application roles.
</details>

---

## Quick revision

- Database properties = Owner, Encoding, Tablespace, Connection Limit
- Tablespaces = physical storage location management
- Schemas = isolated namespaces within a database
- Default Privileges = rules for future table access inside a schema
