# Self-Test — Import/Export via BCP & Scripts

**Q1. What is BCP used for?**

<details>
<summary>Show answer</summary>
BCP is used to bulk copy data between SQL Server and a file.
</details>

**Q2. What is the difference between BCP out and BCP in?**

<details>
<summary>Show answer</summary>
BCP out exports data from the database to a file, and BCP in imports data from a file into the database.
</details>

**Q3. Why are SQL scripts useful for data migration?**

<details>
<summary>Show answer</summary>
They are repeatable, auditable, and easy to version control.
</details>

**Q4. What should you check before importing a flat file?**

<details>
<summary>Show answer</summary>
Delimiter format, column mapping, data types, and whether the file structure matches the table schema.
</details>

**Q5. Which method is usually better for long-term production migration scripts: wizard or script?**

<details>
<summary>Show answer</summary>
Script-based workflows are usually preferable because they are repeatable and easier to automate.
</details>

**Q6. Why is backup validation important before import/export?**

<details>
<summary>Show answer</summary>
Because a failed migration can damage or overwrite data if not tested carefully.
</details>

---

## Quick revision

- BCP = bulk transfer between SQL Server and file
- Scripts = repeatable database operations
- Validate mapping and file format before import
- Back up before major migrations
