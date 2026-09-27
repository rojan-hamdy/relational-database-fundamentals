# Import/Export via COPY, pg_dump & Scripts

## Overview
Importing and exporting data are essential operations when moving records between systems, flat files (CSV/TXT), and PostgreSQL database instances. In PostgreSQL, bulk loading is performed using the `COPY` command (server-side), `\copy` (client-side in `psql`), and command-line utilities like `pg_dump` and `pg_restore`.

---

## 1. Bulk Loading with `COPY` and `\copy`

The `COPY` command transfers data between a PostgreSQL table and a file on the file system.

### Server-Side `COPY` (requires superuser or `pg_read_server_files` / `pg_write_server_files` roles)
```sql
-- Export table data to CSV file on the database server
COPY public.student TO '/path/to/student_data.csv' WITH (FORMAT csv, HEADER);

-- Import CSV data into table from file on the database server
COPY public.student FROM '/path/to/student_data.csv' WITH (FORMAT csv, HEADER);
```

### Client-Side `\copy` (runs via psql from client machine)
```sql
-- Client-side export (does NOT require server-side file access)
\copy public.student TO 'C:/data/student_data.csv' WITH (FORMAT csv, HEADER)

-- Client-side import
\copy public.student FROM 'C:/data/student_data.csv' WITH (FORMAT csv, HEADER)
```

---

## 2. Command-Line Utilities: `pg_dump` and `pg_restore`

### Export Database Schema and Data (`pg_dump`)
```bash
# Dump database in custom format
pg_dump -U postgres -F c -d school_db -f "C:\backups\school_db.dump"

# Dump table data only in CSV/SQL script format
pg_dump -U postgres -t public.student --data-only -f "C:\backups\students_only.sql" school_db
```

### Import / Restore Database (`pg_restore` & `psql`)
```bash
# Restore custom-format dump to target database
pg_restore -U postgres -d school_db_new "C:\backups\school_db.dump"

# Execute SQL script backup
psql -U postgres -d school_db_new -f "C:\backups\students_only.sql"
```

---

## 3. When to Use `COPY` / `\copy`

Use `COPY` / `\copy` when:
- importing or exporting flat CSV or delimited text files,
- bulk loading high-volume datasets efficiently (much faster than individual `INSERT` statements),
- integrating with data processing pipelines or spreadsheet exports.

---

## 4. When to Use `pg_dump` / `pg_restore` or Scripts

Use `pg_dump` / `pg_restore` and scripts when:
- performing complete or partial database backups and migrations,
- transferring schemas, tables, constraints, sequences, and indexes together,
- orchestrating automated backup scripts and disaster recovery workflows.

---

## 5. Example Data Migration Workflow

```sql
-- 1. Create target table in PostgreSQL
CREATE TABLE public.student_import (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    age INT
);

-- 2. Populate via COPY statement
COPY public.student_import (student_id, student_name, age)
FROM '/tmp/students_data.csv'
WITH (FORMAT csv, HEADER, DELIMITER ',');
```

---

## 6. Important Considerations

- **Permissions**: `COPY` requires server file access privileges; use `\copy` or pgAdmin GUI for client-side files.
- **Header Rows**: Set `HEADER` option when CSV files include column headers.
- **Field Delimiters**: Specify `DELIMITER ','` or `DELIMITER ';'` as needed for your data source.
- **Encoding**: Match file encoding (e.g. `ENCODING 'UTF8'`) to prevent character translation errors.

---

## 7. Summary

`COPY`, `pg_dump`, `pg_restore`, and SQL scripts provide fast, scalable mechanisms for moving data into and out of PostgreSQL databases.

> 💡 **Core idea**
> Data movement in PostgreSQL relies on optimized bulk operations (`COPY`) and dump utilities (`pg_dump`), ensuring fast, reliable migrations.

---

> 🔗 **See also**
> - [../pgAdmin_Import_Export_Tools/theory.md](../pgAdmin_Import_Export_Tools/theory.md)
> - [../../12_pgAdmin_Admin_and_Setup/Database_Configuration/theory.md](../../12_pgAdmin_Admin_and_Setup/Database_Configuration/theory.md)
