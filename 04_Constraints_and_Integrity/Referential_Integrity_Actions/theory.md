# Referential Integrity Actions (Cascade, Restrict, Set Null, Set Default)

## Overview
Referential integrity ensures that a child record cannot point to a parent record that no longer exists. When a parent record is deleted or updated, the database engine responds according to the referential action defined on the Foreign Key constraint.

---

## 1. Base Setup: Foreign Key Relationship

To demonstrate each action, we use a classic `Department` (Parent) and `Student` (Child) model.

### SQL Server (T-SQL) Syntax
```sql
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    DepartmentID INT NULL
);
```

### PostgreSQL Syntax
```sql
-- Identical structure (PostgreSQL compatible data types)
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    DepartmentID INT NULL
);
```
> ℹ️ **PostgreSQL Note**: Syntax is identical. In PostgreSQL, `INT GENERATED ALWAYS AS IDENTITY` is used for auto-incrementing IDs instead of SQL Server's `IDENTITY(1,1)`.

---

## 2. Shared Baseline Data

Before executing any `DELETE FROM Department WHERE DepartmentID = 1;`, assume all examples start with this initial state:

**Parent: `Department`**
| DepartmentID | DepartmentName |
| :--- | :--- |
| **1** | Computer Science |
| **2** | Mathematics |
| **999** | Unassigned |

**Child: `Student`**
| StudentID | StudentName | DepartmentID |
| :--- | :--- | :--- |
| **101** | Alice | **1** |
| **102** | Bob | **1** |
| **103** | Charlie | **2** |

---

## 3. NO ACTION / RESTRICT

The database engine **rejects** the delete or update statement if related child rows exist in the child table.

### T-SQL (SQL Server) Syntax
```sql
ALTER TABLE Student
ADD CONSTRAINT FK_Student_Department
    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
```

### PostgreSQL Syntax
```sql
-- Identical standard ANSI syntax:
ALTER TABLE Student
ADD CONSTRAINT FK_Student_Department
    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

-- PostgreSQL also supports the RESTRICT keyword explicitly:
-- ON DELETE RESTRICT
```
> ℹ️ **PostgreSQL Note**: SQL Server does **NOT** support `ON DELETE RESTRICT` syntax (raises a syntax error). PostgreSQL supports both `NO ACTION` and `RESTRICT`. In PostgreSQL, `RESTRICT` checks immediately, whereas `NO ACTION` can be deferred using `DEFERRABLE INITIALLY DEFERRED`.

### Execution Walkthrough
```sql
DELETE FROM Department WHERE DepartmentID = 1;
```

#### What Happens on Execution:
1. SQL Server / PostgreSQL detects that students `101` (Alice) and `102` (Bob) point to `DepartmentID = 1`.
2. The database **aborts the transaction** and returns an error:
   * **SQL Server**: `Msg 547, Level 16: The DELETE statement conflicted with the REFERENCE constraint "FK_Student_Department".`
   * **PostgreSQL**: `ERROR: update or delete on table "department" violates foreign key constraint "fk_student_department" on table "student"`.

#### Table State After Execution:
**No changes occur in either table** (the delete is completely blocked).

---

## 4. CASCADE

If the parent row is deleted or updated, the child rows are **automatically updated or deleted** alongside it.

### T-SQL (SQL Server) Syntax
```sql
ALTER TABLE Student
ADD CONSTRAINT FK_Student_Department
    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
```

### PostgreSQL Syntax
```sql
-- 100% Identical in PostgreSQL:
ALTER TABLE Student
ADD CONSTRAINT FK_Student_Department
    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
```
> ℹ️ **PostgreSQL Note**: Identical syntax. PostgreSQL easily handles multiple cascade paths across complex schemas, whereas SQL Server blocks multiple cascade paths with Error 1785.

### Execution Walkthrough
```sql
DELETE FROM Department WHERE DepartmentID = 1;
```

#### What Happens on Execution:
1. Department `1` ('Computer Science') is deleted.
2. The engine automatically finds and deletes students `101` and `102`.

#### Table State After Execution:

**Parent: `Department`**
| DepartmentID | DepartmentName |
| :--- | :--- |
| **2** | Mathematics |
| **999** | Unassigned |

**Child: `Student`**
| StudentID | StudentName | DepartmentID |
| :--- | :--- | :--- |
| **103** | Charlie | **2** |

*(Alice and Bob were automatically deleted).*

---

## 5. SET NULL

When the parent row is deleted, the foreign key column in all matching child rows is automatically **set to `NULL`**.

### Prerequisite
The `DepartmentID` column in the `Student` table **must allow `NULL` values** (`NOT NULL` is not permitted).

### T-SQL (SQL Server) Syntax
```sql
ALTER TABLE Student
ADD CONSTRAINT FK_Student_Department
    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)
    ON DELETE SET NULL
    ON UPDATE SET NULL;
```

### PostgreSQL Syntax
```sql
-- 100% Identical standard syntax:
ALTER TABLE Student
ADD CONSTRAINT FK_Student_Department
    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)
    ON DELETE SET NULL
    ON UPDATE SET NULL;

-- PostgreSQL 15+ optional column target syntax:
-- ON DELETE SET NULL (DepartmentID)
```
> ℹ️ **PostgreSQL Note**: Standard syntax is identical. PostgreSQL 15+ allows specifying exact column targets for composite keys (`ON DELETE SET NULL (col_name)`).

### Execution Walkthrough
```sql
DELETE FROM Department WHERE DepartmentID = 1;
```

#### What Happens on Execution:
1. Department `1` ('Computer Science') is deleted.
2. Students `101` and `102` remain in the table, but their `DepartmentID` is changed to `NULL`.

#### Table State After Execution:

**Parent: `Department`**
| DepartmentID | DepartmentName |
| :--- | :--- |
| **2** | Mathematics |
| **999** | Unassigned |

**Child: `Student`**
| StudentID | StudentName | DepartmentID |
| :--- | :--- | :--- |
| **101** | Alice | **`NULL`** |
| **102** | Bob | **`NULL`** |
| **103** | Charlie | **2** |

---

## 6. SET DEFAULT

When the parent row is deleted, the foreign key column in all matching child rows is automatically **set to its predefined `DEFAULT` value**.

### Prerequisites
1. The `DepartmentID` column in the `Student` table **must have a `DEFAULT` constraint** defined (e.g., `DEFAULT 999`).
2. The default value (`999`) **must exist** as a valid primary key in the parent `Department` table.

### T-SQL (SQL Server) Syntax
```sql
-- Step 1: Add DEFAULT constraint to child table
ALTER TABLE Student
ADD CONSTRAINT DF_Student_DepartmentID DEFAULT 999 FOR DepartmentID;

-- Step 2: Define FK with SET DEFAULT
ALTER TABLE Student
ADD CONSTRAINT FK_Student_Department
    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)
    ON DELETE SET DEFAULT
    ON UPDATE SET DEFAULT;
```

### PostgreSQL Syntax
```sql
-- Step 1: Set DEFAULT value on column
ALTER TABLE Student
ALTER COLUMN DepartmentID SET DEFAULT 999;

-- Step 2: Define FK with SET DEFAULT (Identical FK clause)
ALTER TABLE Student
ADD CONSTRAINT FK_Student_Department
    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)
    ON DELETE SET DEFAULT
    ON UPDATE SET DEFAULT;
```
> ℹ️ **PostgreSQL Note**: The `ON DELETE SET DEFAULT` clause itself is 100% identical. Only the `ALTER TABLE` column default syntax differs slightly between T-SQL (`ADD CONSTRAINT ... FOR col`) and PostgreSQL (`ALTER COLUMN col SET DEFAULT ...`).

### Execution Walkthrough
```sql
DELETE FROM Department WHERE DepartmentID = 1;
```

#### What Happens on Execution:
1. Department `1` ('Computer Science') is deleted.
2. Students `101` and `102` have their `DepartmentID` updated to `999` ('Unassigned').

#### Table State After Execution:

**Parent: `Department`**
| DepartmentID | DepartmentName |
| :--- | :--- |
| **2** | Mathematics |
| **999** | Unassigned |

**Child: `Student`**
| StudentID | StudentName | DepartmentID |
| :--- | :--- | :--- |
| **101** | Alice | **999** |
| **102** | Bob | **999** |
| **103** | Charlie | **2** |

---

## 7. Comparison & Decision Matrix

| Action | SQL Server Syntax | PostgreSQL Syntax | Child Row Behavior on Parent Delete |
| :--- | :--- | :--- | :--- |
| **`NO ACTION`** | `ON DELETE NO ACTION` | `ON DELETE NO ACTION` | Blocked & raises error |
| **`RESTRICT`** | *(Not supported)* | `ON DELETE RESTRICT` | Blocked & raises error immediately |
| **`CASCADE`** | `ON DELETE CASCADE` | `ON DELETE CASCADE` | Child rows are deleted |
| **`SET NULL`** | `ON DELETE SET NULL` | `ON DELETE SET NULL` | Child FK set to `NULL` |
| **`SET DEFAULT`** | `ON DELETE SET DEFAULT` | `ON DELETE SET DEFAULT` | Child FK set to `DEFAULT` |

---

## 8. Summary

> 💡 **Core Takeaway**
> Foreign key referential actions protect relational data integrity. Because both engines adhere to ANSI SQL standards, `ON DELETE` syntax (`CASCADE`, `SET NULL`, `SET DEFAULT`, `NO ACTION`) is virtually identical between SQL Server and PostgreSQL.

---

> 🔗 **See also**
> - [../PK_FK_Unique_Check_Default/theory.md](../PK_FK_Unique_Check_Default/theory.md)
> - [../../01_Foundations/03_Relational_Data_Model/theory.md](../../01_Foundations/03_Relational_Data_Model/theory.md)
