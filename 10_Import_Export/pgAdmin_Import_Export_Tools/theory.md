# Import/Export via pgAdmin GUI Tools

## Overview
pgAdmin 4 includes dedicated, interactive GUI tools for importing and exporting table data (CSV/TXT), as well as backing up and restoring entire databases or schemas. This is the fastest way to perform data transfers visually without typing command-line scripts.

---

## 1. Typical Use Cases

Use pgAdmin Import/Export GUI tools when:
- importing CSV data into an existing PostgreSQL table,
- exporting query result sets or tables to flat CSV files,
- generating database backups (`.backup` or `.sql` files),
- testing ad-hoc data loads in development environments.

---

## 2. Table Data Import/Export Tool Path in pgAdmin

1. In the Object Browser panel, expand **Databases > Schemas > public > Tables**.
2. Right-click the target table and select **Import/Export Data...**.
3. In the dialog box, configure:
   - **Options**: Toggle between **Import** or **Export**.
   - **Filename**: Select the path for your `.csv` or `.txt` file.
   - **Format**: Select `csv`, `text`, or `binary`.
   - **Encoding**: Choose file encoding (default `UTF8`).
   - **Header**: Toggle `Yes` if the file includes a column header row.
   - **Delimiter**: Choose comma `,`, tab, or semicolon.
4. On the **Columns** tab, select which columns to include or exclude.
5. Click **OK** to execute.

---

## 3. Database Backup & Restore in pgAdmin

### Backup Database
1. Right-click a database in the Browser panel and choose **Backup...**.
2. Set the destination filename and format (`Custom`, `Directory`, `Tar`, or `Plain` text).
3. Click **Backup**. pgAdmin runs `pg_dump` in the background.

### Restore Database
1. Right-click a target database and choose **Restore...**.
2. Select the backup file path and format.
3. Click **Restore**. pgAdmin runs `pg_restore` or `psql` in the background.

---

## 4. Equivalent PostgreSQL SQL Commands

Behind the scenes, pgAdmin's GUI dialogs translate your inputs into PostgreSQL `COPY` statements:

```sql
-- Equivalent server SQL command for CSV import
COPY public.student (student_id, student_name, age)
FROM '/path/to/student_data.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');
```

---

## 5. Best Practices

- Test import files on a development database before loading into production tables.
- Match column ordering in the **Columns** tab if the CSV file columns differ from the table structure.
- Ensure appropriate data type casting (e.g. valid date formats, numeric strings).
- Use GUI tools for ad-hoc user tasks, and script `COPY` / `pg_dump` for automated scheduled jobs.

---

## 6. Summary

pgAdmin's Import/Export and Backup/Restore tools provide visual, user-friendly access to PostgreSQL's native `COPY` and `pg_dump` utilities.

> 💡 **Core idea**
> GUI tools in pgAdmin simplify ad-hoc data transfer, while backing up databases visually with standard PostgreSQL utilities.

---

> 🔗 **See also**
> - [../COPY_and_Scripts/theory.md](../COPY_and_Scripts/theory.md)
> - [../../12_pgAdmin_Admin_and_Setup/Database_Configuration/theory.md](../../12_pgAdmin_Admin_and_Setup/Database_Configuration/theory.md)
