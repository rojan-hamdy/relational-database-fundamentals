# Self-Test — Import/Export via pgAdmin GUI Tools

**Q1. What are pgAdmin's Import/Export Data tools used for?**

<details>
<summary>Show answer</summary>
They provide a visual interface to import or export data between PostgreSQL tables and external flat files (such as CSV or text).
</details>

**Q2. Where do you open the Import/Export tool in pgAdmin?**

<details>
<summary>Show answer</summary>
Right-click a table in the Object Browser panel → select Import/Export Data...
</details>

**Q3. Why is column mapping important in the pgAdmin Import dialog?**

<details>
<summary>Show answer</summary>
Because columns in the CSV file must match the target table column names, ordering, and data types.
</details>

**Q4. How does pgAdmin execute table imports and exports under the hood?**

<details>
<summary>Show answer</summary>
It translates GUI dialog choices into PostgreSQL `COPY` statements.
</details>

**Q5. What tool in pgAdmin is used to backup an entire database?**

<details>
<summary>Show answer</summary>
Right-click database → select Backup... (runs `pg_dump` in the background).
</details>

**Q6. When should you use pgAdmin GUI tools versus command-line utilities?**

<details>
<summary>Show answer</summary>
Use pgAdmin GUI tools for ad-hoc user tasks, and command-line scripts (`COPY`, `pg_dump`) for automated production tasks.
</details>

---

## Quick revision

- pgAdmin GUI = interactive import/export and backup/restore
- Under the hood = pgAdmin executes `COPY` and `pg_dump`
- Column mapping & delimiter settings are key for CSV import
- Scripts are better for automated pipelines
