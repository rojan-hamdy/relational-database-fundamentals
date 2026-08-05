# Import/Export via BCP & Scripts

> Status: ✅ Built as the data movement lesson.

## Overview
Import and export are essential when data needs to move between systems, files, and SQL Server instances. BCP (Bulk Copy Program) and SQL scripts are common tools for this work.

---

## 1. BCP

BCP is a command-line utility used to bulk copy data between SQL Server and a file.

### Export example
```bash
bcp dbo.Student out "C:\data\student_data.txt" -c -T -S localhost
```

### Import example
```bash
bcp dbo.Student in "C:\data\student_data.txt" -c -T -S localhost
```

Where:
- `out`: export data from SQL Server to file
- `in`: import data from file into SQL Server
- `-c`: character data format
- `-T`: trusted connection
- `-S`: server name

---

## 2. SQL scripts

SQL scripts are text files containing T-SQL statements. They are used for repeatable database setup, imports, transformations, and migrations.

Example:
```sql
USE SchoolDB;
GO

SELECT *
FROM dbo.Student;
GO
```

---

## 3. When to use BCP

Use BCP when:
- large files must be imported or exported quickly,
- the transfer is best done in bulk,
- you want a command-line approach with scripting support.

---

## 4. When to use scripts

Use scripts when:
- you need repeatable automation,
- you want to create or alter database objects,
- you need to insert test data or run a migration sequence.

---

## 5. Example migration pattern

```sql
USE master;
GO

CREATE DATABASE ImportDemo;
GO

USE ImportDemo;
GO

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    Age INT
);
GO
```

Then import using BCP or SQL Server wizard tools.

---

## 6. Important considerations

- validate file format before import,
- back up data before large migration work,
- check field delimiters and column mapping,
- test on a development environment first.

---

## 7. Summary

BCP and scripts are powerful tools for moving large amounts of data efficiently. They are especially useful in migration, environment setup, and batch data loading workflows.

> 💡 **Core idea**
> Data movement is not just a one-time task; it is a repeatable operational practice that needs planning and validation.

---

> 🔗 **See also**
> - [../SSMS_Import_Export_Wizard/theory.md](../SSMS_Import_Export_Wizard/theory.md)
> - [../../12_SSMS_Admin_and_Setup/Database_Configuration/theory.md](../../12_SSMS_Admin_and_Setup/Database_Configuration/theory.md)
