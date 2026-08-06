# Data Manipulation & Table Population: INSERT, UPDATE, DELETE, TRUNCATE, MERGE & SELECT INTO

## Overview
Modifying database content involves Data Manipulation Language (DML) statements (`INSERT`, `UPDATE`, `DELETE`, `MERGE`) as well as data-copying techniques (`INSERT INTO ... SELECT`, `SELECT INTO`) and fast table truncation (`TRUNCATE TABLE`).

---

## 1. INSERT (Inserting Literal Values)

Use `INSERT INTO` to add one or more new rows by supplying explicit literal values.

```sql
-- Single row insert
INSERT INTO dbo.Student (StudentID, StudentName, Age)
VALUES (1, 'Alice', 21);

-- Multi-row insert
INSERT INTO dbo.Student (StudentID, StudentName, Age)
VALUES (2, 'Bob', 22),
       (3, 'Charlie', 24);
```

---

## 2. Populating Existing Tables: `INSERT INTO ... SELECT`

When you want to insert rows generated dynamically by a query into an **already existing** table, use `INSERT INTO ... SELECT`:

```sql
-- Target table must already exist
INSERT INTO dbo.ArchiveStudent (StudentID, StudentName, GraduationYear)
SELECT 
    StudentID, 
    StudentName, 
    YEAR(GETDATE()) AS GraduationYear
FROM dbo.Student
WHERE Age >= 24;
```

### Key Considerations:
- Target table must be created prior to executing the statement.
- The number, order, and data types of columns in the `SELECT` list must match the target table specification.

---

## 3. Creating Tables on the Fly: `SELECT INTO`

`SELECT INTO` creates a **new table** dynamically based on the structure and result set of a `SELECT` query.

```sql
-- Creates a permanent table 'HonorRoll' with columns & data copied from Student
SELECT StudentID, StudentName, Score
INTO dbo.HonorRoll
FROM dbo.Student
WHERE Score >= 90;

-- Creates a local temporary table '#TempActiveStudents'
SELECT StudentID, StudentName
INTO #TempActiveStudents
FROM dbo.Student
WHERE IsActive = 1;
```

### What `SELECT INTO` Copies vs What It Misses:
| Copied / Inherited | NOT Copied (Lost) |
|---|---|
| Column names & aliases | Primary Keys & Foreign Keys |
| Data types & nullability | Indexes (Clustered / Non-Clustered) |
| `IDENTITY` property | Check & Default Constraints |
| Row data matching query | Triggers & Table Permissions |

> 💡 **Tip**: To create an empty table with the exact schema of an existing table without copying any rows:
> ```sql
> SELECT * INTO dbo.EmptyCopyTable FROM dbo.Student WHERE 1 = 0;
> ```

---

## 4. UPDATE

`UPDATE` modifies values in existing table rows.

```sql
UPDATE dbo.Student
SET Age = 23,
    StudentName = 'Alice Johnson'
WHERE StudentID = 1;
```

---

## 5. DELETE

`DELETE` removes specific rows matching a `WHERE` condition.

```sql
-- Delete specific rows
DELETE FROM dbo.Student
WHERE StudentID = 3;

-- Delete all rows (Row-by-row removal)
DELETE FROM dbo.Student;
```

---

## 6. Deep Dive: `TRUNCATE TABLE` vs `DELETE`

`TRUNCATE TABLE` removes **all rows** from a table instantly by deallocating the data pages. Although it achieves a similar result to `DELETE FROM table;`, its execution mechanism, performance, and side effects are completely different.

### Architectural Comparison: `TRUNCATE` vs `DELETE`

| Feature / Behavior | `TRUNCATE TABLE` | `DELETE FROM` |
|---|---|---|
| **SQL Category** | DDL (Data Definition Language) | DML (Data Manipulation Language) |
| **Operation Level** | Deallocates data pages | Deletes rows individually |
| **Transaction Logging** | **Minimally Logged** (logs page deallocations) | **Fully Logged** (logs every row deletion) |
| **Speed & Performance** | Extremely fast (milliseconds even on 100M rows) | Slower; generates extensive log entries |
| **Identity Reset** | Resets `IDENTITY` counter back to seed value | Does **NOT** reset `IDENTITY` counter |
| **Locks Acquired** | Table-level Schema Modification lock (`SCH_M`) | Row-level / Page-level locks (`X` locks) |
| **Foreign Key Restrictions** | ❌ **Cannot** run if table is referenced by ANY FK | ✅ Works if FK rows are deleted/cascaded |
| **Indexed View Restrictions** | ❌ Cannot truncate table participating in Indexed Views | ✅ Allowed |
| **Permissions Required** | `ALTER` permission on target table | `DELETE` permission on target table |
| **Can be Rolled Back?** | ✅ **YES** inside an explicit transaction (`BEGIN TRAN`) | ✅ **YES** inside an explicit transaction |

### Code Comparison & Rollback Example:
```sql
-- TRUNCATE syntax
TRUNCATE TABLE dbo.StudentLog;

-- TRUNCATE CAN BE ROLLED BACK inside a transaction!
BEGIN TRANSACTION;
    TRUNCATE TABLE dbo.AuditStaging;
    
    -- Verification shows 0 rows
    SELECT COUNT(*) FROM dbo.AuditStaging; 
ROLLBACK TRANSACTION;

-- Rows are restored after rollback!
SELECT COUNT(*) FROM dbo.AuditStaging;
```

---

## 7. MERGE (UPSERT Operations)

`MERGE` combines `INSERT`, `UPDATE`, and `DELETE` into a single atomic operation based on joining a target table with a source dataset.

```sql
MERGE INTO dbo.StudentTarget AS target
USING dbo.StudentSource AS source
    ON target.StudentID = source.StudentID
WHEN MATCHED THEN
    UPDATE SET
        target.StudentName = source.StudentName,
        target.Age = source.Age
WHEN NOT MATCHED BY TARGET THEN
    INSERT (StudentID, StudentName, Age)
    VALUES (source.StudentID, source.StudentName, source.Age)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
```

---

## 8. Summary Comparison of Data Manipulation Tools

| Action | Command | Creates Target Table? | Logged | Identity Reset |
|---|---|---|---|---|
| Insert literal rows | `INSERT INTO ... VALUES` | No | Fully | No |
| Append query results | `INSERT INTO ... SELECT` | No | Fully | No |
| Dynamic table creation | `SELECT INTO` | **Yes** | Minimally | Preserved |
| Update row values | `UPDATE` | No | Fully | N/A |
| Conditional row deletion | `DELETE WHERE` | No | Fully | No |
| Clear table (slow) | `DELETE` | No | Fully | No |
| Clear table (instant) | `TRUNCATE TABLE` | No | Minimally | **Yes** |
| Upsert / Sync tables | `MERGE` | No | Fully | No |

---

> 🔗 **See also**
> - [../01_SELECT_WHERE_ORDER_BY/theory.md](../01_SELECT_WHERE_ORDER_BY/theory.md)
> - [../03_CREATE_ALTER_DROP/theory.md](../03_CREATE_ALTER_DROP/theory.md)
> - [../../04_Constraints_and_Integrity/PK_FK_Unique_Check_Default/theory.md](../../04_Constraints_and_Integrity/PK_FK_Unique_Check_Default/theory.md)
> - [../syntax_cheatsheet.md](../syntax_cheatsheet.md)
