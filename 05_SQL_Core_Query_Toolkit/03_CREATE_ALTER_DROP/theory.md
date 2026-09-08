# Schema Management & DDL: CREATE, ALTER, DROP, Schemas & Identity Management

## Overview
Data Definition Language (DDL) commands (`CREATE`, `ALTER`, `DROP`) define and alter the structural blueprint of database entities. Beyond tables and databases, DDL manages **Schemas** (logical containers and security boundaries) and auto-incrementing **Identity** properties.

---

## 1. Schema Management & Organization

A **Schema** is a logical container within a database that groups related objects (tables, views, stored procedures) and acts as a security boundary.

```text
┌─────────────────────────────────────────────────────────────┐
│                    DATABASE INSTANCE                        │
│                                                             │
│  ┌────────────────────────┐ ┌──────────────────────────┐    │
│  │     Schema: dbo        │ │      Schema: sales       │    │
│  │ ┌────────────────────┐ │ │ ┌──────────────────────┐ │    │
│  │ │ Table: Student     │ │ │ │ Table: Orders        │ │    │
│  │ └────────────────────┘ │ │ └──────────────────────┘ │    │
│  └────────────────────────┘ └──────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
```

### Schema Statements: T-SQL vs PostgreSQL

#### SQL Server (T-SQL)
```sql
-- 1. Create a new schema
CREATE SCHEMA sales AUTHORIZATION dbo;
GO

-- 2. Create a table inside the sales schema
CREATE TABLE sales.Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(18, 2)
);
GO

-- 3. Transfer an existing table from 'dbo' to 'sales'
ALTER SCHEMA sales TRANSFER dbo.Student;
GO
```

#### PostgreSQL Syntax
```sql
-- 1. Create schema
CREATE SCHEMA sales AUTHORIZATION postgres;

-- 2. Create table in schema
CREATE TABLE sales.Orders (
    OrderID INT PRIMARY KEY,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(18, 2)
);

-- 3. Change table schema in PostgreSQL
ALTER TABLE public.Student SET SCHEMA sales;
```
> ℹ️ **PostgreSQL Note**: To move a table between schemas, SQL Server uses `ALTER SCHEMA target_schema TRANSFER source_schema.table`, while PostgreSQL uses `ALTER TABLE source_schema.table SET SCHEMA target_schema`.

---

## 2. Table DDL: CREATE, ALTER, DROP

### A. Creating Tables (`CREATE TABLE`)

#### SQL Server (T-SQL)
```sql
CREATE TABLE dbo.Department (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    CreatedDate DATETIME DEFAULT GETDATE()
);
```

#### PostgreSQL
```sql
CREATE TABLE public.Department (
    DepartmentID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

### B. Altering Columns (`ALTER TABLE ... ALTER COLUMN`)

Modifying an existing column's data type or nullability requirement:

#### SQL Server (T-SQL)
```sql
-- Add new column
ALTER TABLE dbo.Department ADD Budget DECIMAL(18,2);

-- Modify column definition in SQL Server
ALTER TABLE dbo.Department 
ALTER COLUMN DepartmentName VARCHAR(150) NOT NULL;
```

#### PostgreSQL
```sql
-- Add new column
ALTER TABLE Department ADD COLUMN Budget DECIMAL(18,2);

-- Modify column data type in PostgreSQL
ALTER TABLE Department 
ALTER COLUMN DepartmentName TYPE VARCHAR(150);

-- Modify nullability in PostgreSQL
ALTER TABLE Department 
ALTER COLUMN DepartmentName SET NOT NULL;
```
> ℹ️ **PostgreSQL Note**: SQL Server modifies type and nullability in a single `ALTER COLUMN col TYPE_DEF` clause. PostgreSQL requires separate `ALTER COLUMN col TYPE new_type` and `ALTER COLUMN col SET NOT NULL` statements.

---

### C. Dropping Objects (`DROP TABLE / DROP VIEW`)

#### SQL Server (T-SQL)
```sql
-- SQL Server 2016+ Conditional Drop
DROP TABLE IF EXISTS dbo.Department;
```

#### PostgreSQL
```sql
-- PostgreSQL Conditional Drop
DROP TABLE IF EXISTS Department CASCADE;
```
> ℹ️ **PostgreSQL Note**: PostgreSQL supports `CASCADE` on `DROP TABLE` to automatically drop dependent foreign key constraints. In SQL Server, dependent constraints must be dropped explicitly first before dropping the parent table.

---

## 3. DDL Feature Comparison Matrix

| DDL Operation | SQL Server (T-SQL) | PostgreSQL |
| :--- | :--- | :--- |
| **Auto-Increment ID** | `IDENTITY(seed, incr)` | `GENERATED ALWAYS AS IDENTITY` |
| **Current Date Default** | `DEFAULT GETDATE()` | `DEFAULT CURRENT_TIMESTAMP` |
| **Move Table Schema** | `ALTER SCHEMA s TRANSFER tbl` | `ALTER TABLE tbl SET SCHEMA s` |
| **Alter Column Type** | `ALTER COLUMN col TYPE_DEF` | `ALTER COLUMN col TYPE new_type` |
| **Set Column NOT NULL** | `ALTER COLUMN col TYPE NOT NULL` | `ALTER COLUMN col SET NOT NULL` |
| **Drop Table Cascade** | Explicit FK removal required | `DROP TABLE tbl CASCADE` |

---

> 🔗 **See also**
> - [../04_INSERT_UPDATE_DELETE_MERGE/theory.md](../04_INSERT_UPDATE_DELETE_MERGE/theory.md)
> - [../../04_Constraints_and_Integrity/PK_FK_Unique_Check_Default/theory.md](../../04_Constraints_and_Integrity/PK_FK_Unique_Check_Default/theory.md)
