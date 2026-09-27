# Self-Test — Import/Export via COPY, pg_dump & Scripts

**Q1. What is the PostgreSQL COPY command used for?**

<details>
<summary>Show answer</summary>
`COPY` is used to bulk copy data between PostgreSQL tables and external files (such as CSV or text files).
</details>

**Q2. What is the difference between SQL COPY and psql \copy?**

<details>
<summary>Show answer</summary>
`COPY` is executed server-side (requiring server file permissions), while `\copy` is executed client-side via `psql` (reading/writing local client files).
</details>

**Q3. Which command-line utility is used to export database schemas and data in PostgreSQL?**

<details>
<summary>Show answer</summary>
`pg_dump`.
</details>

**Q4. What should you check before importing a flat CSV file?**

<details>
<summary>Show answer</summary>
Delimiter format (comma/tab), header row inclusion (`HEADER`), character encoding (`UTF8`), and schema matching.
</details>

**Q5. Which utility restores custom-format PostgreSQL dumps created by pg_dump?**

<details>
<summary>Show answer</summary>
`pg_restore`.
</details>

**Q6. Why is backup validation important before running bulk imports or migrations?**

<details>
<summary>Show answer</summary>
Because failed or misaligned bulk imports can corrupt existing data or cause integrity constraint violations.
</details>

---

## Quick revision

- `COPY` / `\copy` = high-speed bulk data import and export
- `pg_dump` = export database structure and data to dump or SQL file
- `pg_restore` = restore custom-format database backups
- Validate headers, delimiters, and encodings before bulk operations
