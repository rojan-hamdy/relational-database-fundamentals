# Data Manipulation & Table Population: INSERT, UPDATE, DELETE, TRUNCATE, MERGE & SELECT INTO

## Overview
Modifying database content involves Data Manipulation Language (DML) statements (`INSERT`, `UPDATE`, `DELETE`, `MERGE`) as well as data-copying techniques (`INSERT INTO ... SELECT`, `SELECT INTO`) and fast table truncation (`TRUNCATE TABLE`).

---

## 1. INSERT & Populating Tables

### A. Inserting Literal Values

#### T-SQL & PostgreSQL Syntax (Identical)
```sql
INSERT INTO Student (StudentID, StudentName, Age)
VALUES (1, 'Alice', 21),
       (2, 'Bob', 22);
```

---

### B. Populating Existing Tables: `INSERT INTO ... SELECT`

Appends dynamic query results into an **already existing** table.

```sql
INSERT INTO ArchiveStudent (StudentID, StudentName, GraduationYear)
SELECT 
    StudentID, 
    StudentName, 
    2026 AS GraduationYear
FROM Student
WHERE Age >= 24;
```

---

## 2. Dynamic Table Creation: `SELECT INTO` vs `CREATE TABLE AS SELECT`

Creates a **new target table on the fly** and populates it with query results.

### SQL Server (T-SQL) Syntax: `SELECT INTO`
```sql
-- Creates permanent table 'HonorRoll' with columns & data copied from Student
SELECT StudentID, StudentName, Score
INTO dbo.HonorRoll
FROM dbo.Student
WHERE Score >= 90;
```

### PostgreSQL Syntax: `CREATE TABLE AS SELECT`
```sql
-- PostgreSQL uses CREATE TABLE ... AS SELECT ...
CREATE TABLE HonorRoll AS
SELECT StudentID, StudentName, Score
FROM Student
WHERE Score >= 90;
```
> ℹ️ **Engine Difference**: SQL Server uses `SELECT ... INTO target_table FROM source_table`. PostgreSQL uses `CREATE TABLE target_table AS SELECT ... FROM source_table`.

---

## 3. Deep Dive: `TRUNCATE TABLE` vs `DELETE`

`TRUNCATE TABLE` removes all rows instantly by deallocating data pages.

### Comparison Matrix

| Feature / Behavior | `TRUNCATE TABLE` | `DELETE FROM` |
| :--- | :--- | :--- |
| **Category** | DDL (Page Deallocation) | DML (Row-by-row deletion) |
| **Performance** | Extremely Fast (Milliseconds) | Slower (Proportional to row count) |
| **Identity Reset** | Resets `IDENTITY` counter to seed | Does **NOT** reset `IDENTITY` |
| **Foreign Key Safety** | Blocked if referenced by active FK | Allowed if child rows deleted |
| **PostgreSQL Cascading** | Supports `TRUNCATE tbl CASCADE` | Supports cascading deletes via FK |

```sql
-- Fast full table clearance (Can be rolled back inside transactions in both engines!)
BEGIN TRANSACTION;
    TRUNCATE TABLE Student;
ROLLBACK TRANSACTION;
```

---

## 4. Upserting Data: `MERGE` vs `ON CONFLICT`

Synchronizes a target table with a source dataset by combining `INSERT`, `UPDATE`, and `DELETE`.

### A. SQL Server (T-SQL) Syntax (`MERGE`)
```sql
MERGE INTO StudentTarget AS target
USING StudentSource AS source
    ON target.StudentID = source.StudentID
WHEN MATCHED THEN
    UPDATE SET
        target.StudentName = source.StudentName,
        target.Age = source.Age
WHEN NOT MATCHED BY TARGET THEN
    INSERT (StudentID, StudentName, Age)
    VALUES (source.StudentID, source.StudentName, source.Age);
```

### B. PostgreSQL Syntax (`ON CONFLICT` / `MERGE`)

#### PostgreSQL 15+ (`MERGE` Statement - Identical Standard Syntax)
PostgreSQL 15+ natively supports the standard `MERGE INTO ... USING ...` clause identical to SQL Server.

#### PostgreSQL Native UPSERT (`ON CONFLICT`)
```sql
-- Classic PostgreSQL UPSERT
INSERT INTO StudentTarget (StudentID, StudentName, Age)
VALUES (101, 'Alice Johnson', 22)
ON CONFLICT (StudentID) 
DO UPDATE SET
    StudentName = EXCLUDED.StudentName,
    Age = EXCLUDED.Age;
```

---

## 5. Summary Matrix

| Operation | SQL Server (T-SQL) | PostgreSQL | Notes |
| :--- | :--- | :--- | :--- |
| **Literal Insert** | `INSERT INTO tbl VALUES (...)` | `INSERT INTO tbl VALUES (...)` | Identical syntax |
| **Copy into existing table** | `INSERT INTO tbl SELECT ...` | `INSERT INTO tbl SELECT ...` | Identical syntax |
| **Create table from query** | `SELECT cols INTO new_tbl FROM ...` | `CREATE TABLE new_tbl AS SELECT ...` | Syntax difference |
| **Fast Table Clear** | `TRUNCATE TABLE tbl` | `TRUNCATE TABLE tbl [CASCADE]` | PostgreSQL supports `CASCADE` |
| **Upsert (Sync)** | `MERGE INTO target USING source...` | `ON CONFLICT DO UPDATE` or `MERGE` | PG 15+ supports `MERGE` |

---

> 🔗 **See also**
> - [../01_SELECT_WHERE_ORDER_BY/theory.md](../01_SELECT_WHERE_ORDER_BY/theory.md)
> - [../03_CREATE_ALTER_DROP/theory.md](../03_CREATE_ALTER_DROP/theory.md)
> - [../../04_Constraints_and_Integrity/PK_FK_Unique_Check_Default/theory.md](../../04_Constraints_and_Integrity/PK_FK_Unique_Check_Default/theory.md)
