# PK, FK, Unique, Check, Default Constraints & Identity Management

## Overview
Database constraints enforce rules on stored data so that values remain valid, consistent, and aligned with business rules.

These constraints work together with column properties like `IDENTITY` to manage unique identifier generation and ensure domain and referential integrity across tables.

---

## 1. Primary Key (PK) & IDENTITY

A primary key uniquely identifies each row in a table. Primary keys must be `UNIQUE` and `NOT NULL`.

```sql
CREATE TABLE dbo.Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100)
);
```

### Auto-Incrementing Primary Keys with `IDENTITY`
Rather than supplying key values manually, SQL Server tables frequently use surrogate keys backed by the `IDENTITY(seed, increment)` column property:

```sql
CREATE TABLE dbo.Student (
    -- Auto-increments starting at 1, increasing by 1
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL
);
```

---

## 2. Managing IDENTITY: `SET IDENTITY_INSERT` & `DBCC CHECKIDENT`

### Explicit Key Insertion (`SET IDENTITY_INSERT`)
To insert a specific explicit value into an `IDENTITY` column (e.g. during data migrations or recovering deleted key ranges):

```sql
-- Enable manual identity inserts for target table
SET IDENTITY_INSERT dbo.Student ON;

INSERT INTO dbo.Student (StudentID, StudentName)
VALUES (999, 'Migrated Student');

-- Always turn OFF after use
SET IDENTITY_INSERT dbo.Student OFF;
```

### Checking & Reseeding Identity (`DBCC CHECKIDENT`)
If data is truncated, cleared, or manually seeded, you can inspect or adjust the current identity counter:

```sql
-- Check current identity value
DBCC CHECKIDENT ('dbo.Student', NORESEED);

-- Reseed identity counter to restart from 500
DBCC CHECKIDENT ('dbo.Student', RESEED, 500);
```

### Identity Functions Reference
| Function | Scope & Session | Description / Best Practice |
|---|---|---|
| `SCOPE_IDENTITY()` | Current Scope / Current Session | **Recommended**. Returns last identity created in current procedure/query scope. |
| `@@IDENTITY` | Any Scope / Current Session | Returns last identity generated anywhere in current session (affected by triggers). |
| `IDENT_CURRENT('table')` | Any Scope / Any Session | Returns last identity generated for a specific table across ALL active connections. |
| `IDENT_SEED('table')` | N/A | Returns configured initial seed value of the table's identity column. |
| `IDENT_INCR('table')` | N/A | Returns configured increment step value of the table's identity column. |

---

## 3. Foreign Key (FK)

A foreign key references the primary key (or unique key) of another table, guaranteeing referential integrity.

```sql
CREATE TABLE dbo.Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

CREATE TABLE dbo.Student (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    CONSTRAINT FK_Student_Department
        FOREIGN KEY (DepartmentID)
        REFERENCES dbo.Department(DepartmentID)
);
```

---

## 4. Unique Constraint

A unique constraint prevents duplicate values in a column or group of columns while allowing a single `NULL` value (in SQL Server).

```sql
CREATE TABLE dbo.Employee (
    EmployeeID INT PRIMARY KEY,
    Email VARCHAR(100) UNIQUE
);
```

---

## 5. Check Constraint

A check constraint enforces a logical boolean expression on inserted/updated row data.

```sql
CREATE TABLE dbo.Product (
    ProductID INT PRIMARY KEY,
    Price DECIMAL(10,2) CHECK (Price > 0),
    Stock INT CHECK (Stock >= 0)
);
```

---

## 6. Default Constraint

A default value is assigned automatically when a query omits explicit values for that column.

```sql
CREATE TABLE dbo.Customer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    City VARCHAR(100) DEFAULT 'Cairo',
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE()
);
```

---

## 7. Example Combined Schema Design

```sql
CREATE TABLE dbo.Department (
    DepartmentID INT IDENTITY(10, 10) PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE dbo.Student (
    StudentID INT IDENTITY(1, 1) PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL,
    Age INT CHECK (Age BETWEEN 0 AND 120),
    City VARCHAR(100) DEFAULT 'Cairo',
    CONSTRAINT FK_Student_Department
        FOREIGN KEY (DepartmentID)
        REFERENCES dbo.Department(DepartmentID)
);
```

---

## 8. Key Takeaways

- **PK**: Identifies each row uniquely (`NOT NULL` + `UNIQUE`).
- **IDENTITY**: Auto-incrementing surrogate keys (`IDENTITY(seed, increment)`).
- **IDENTITY Management**: `SET IDENTITY_INSERT` for explicit key loading; `DBCC CHECKIDENT` for reseeding; `SCOPE_IDENTITY()` for safe key retrieval.
- **FK**: Guarantees referential integrity between child and parent tables.
- **UNIQUE**: Prevents duplicate column values.
- **CHECK**: Enforces valid range/boolean business rules.
- **DEFAULT**: Supplies automatic fallback values.

---

> 🔗 **See also**
> - [../Referential_Integrity_Actions/theory.md](../Referential_Integrity_Actions/theory.md)
> - [../../05_SQL_Core_Query_Toolkit/03_CREATE_ALTER_DROP/theory.md](../../05_SQL_Core_Query_Toolkit/03_CREATE_ALTER_DROP/theory.md)
> - [../../01_Foundations/03_Relational_Data_Model/theory.md](../../01_Foundations/03_Relational_Data_Model/theory.md)
