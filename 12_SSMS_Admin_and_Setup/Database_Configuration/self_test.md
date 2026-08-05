# Self-Test — SSMS Database Configuration

> Status: ✅ Ready for practice.

**Q1. Where do you configure database properties in SSMS?**

<details>
<summary>Show answer</summary>
Right-click the database → Properties.
</details>

**Q2. What are common database settings you may configure?**

<details>
<summary>Show answer</summary>
Recovery model, files, filegroups, compatibility level, and permissions.
</details>

**Q3. What is a recovery model?**

<details>
<summary>Show answer</summary>
It defines how the database handles logging and restore operations.
</details>

**Q4. Why is file configuration important?**

<details>
<summary>Show answer</summary>
Because data files and log files affect storage capacity, growth, performance, and recovery.
</details>

**Q5. What is the T-SQL command to create a database?**

<details>
<summary>Show answer</summary>
CREATE DATABASE DatabaseName;
</details>

**Q6. Why should admins review permissions after configuration changes?**

<details>
<summary>Show answer</summary>
Because new or changed settings may affect access and security.
</details>

---

## Quick revision

- Database properties = user-visible settings and runtime behavior
- Files and filegroups = data storage layout
- Recovery model = backup/restore strategy
- Permissions = access policy for users and roles
