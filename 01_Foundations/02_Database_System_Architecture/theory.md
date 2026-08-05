# Database System Concepts and Architecture


## Overview
A database system is more than just a collection of tables. It is an integrated system that includes:

- the database itself,
- the database management system (DBMS),
- the application layer that accesses it,
- users and administrators,
- storage and security mechanisms.

The goal of database architecture is to separate concerns so that users work with data logically, while the system manages storage, concurrency, recovery, and performance behind the scenes.

---

## 1. Core Definitions

> 💡 **Database**
> A structured collection of related data designed to serve a specific purpose.

> 💡 **DBMS**
> A software system that allows users to create, retrieve, update, and manage data efficiently and securely.

> 💡 **Schema**
> The structure of the database: tables, columns, constraints, relationships, and rules.

> 💡 **Instance**
> A specific state or snapshot of the database at a given moment, including the currently stored data.

> 💡 **Metadata**
> Data about the data: column names, data types, constraints, table definitions, and relationship rules.

---

## 2. Why We Need a Database System

A database system solves common problems that file-based storage cannot handle well:

- data consistency,
- data integrity,
- multi-user access,
- controlled sharing,
- backup and recovery,
- efficient querying and indexing,
- security and authorization.

Without a DBMS, applications would need to manage raw files manually, which is slow, error-prone, and unsafe.

---

## 3. Database Architecture Levels

A common conceptual model separates the database into three levels:

### 3.1 External Level
This is how each user or application views the data.

- A user may only see selected tables or columns.
- Different users may see different views of the same database.
- This is often implemented through views.

### 3.2 Conceptual Level
This is the logical representation of the whole database.

- It describes entities, relationships, constraints, and rules.
- It is independent of physical storage details.

### 3.3 Internal Level
This is the storage view.

- Defines how data is stored on disk.
- Includes files, indexes, record organization, pages, and access paths.
- This is handled by the DBMS and is not typically visible to end users.

> 🔗 **Important idea**
> The architecture separates user logic from physical storage logic. This makes systems more flexible and maintainable.

---

## 4. Main Components of a DBMS

A DBMS has several important components:

### 4.1 Query Processor
Responsible for interpreting SQL statements and planning how to execute them.

It includes:
- parser,
- optimizer,
- execution engine.

### 4.2 Storage Manager
Responsible for actual data handling.

It manages:
- files,
- pages,
- tables,
- indexes,
- buffers,
- transactions.

### 4.3 Transaction Manager
Controls transactions so that operations are atomic, consistent, isolated, and durable.

### 4.4 Recovery Manager
Ensures the database can be restored after crashes or failures.

### 4.5 Concurrency Control Manager
Coordinates simultaneous access by multiple users to prevent inconsistent or invalid results.

### 4.6 Authorization and Security Manager
Checks whether a user has permission to access or modify data.

---

## 5. Client-Server Database Model

Most SQL Server systems use a client-server architecture.

- Client: application or SSMS interface
- Server: SQL Server engine
- Database files: stored on the server
- Queries are sent from client to server
- Server executes the request and returns results

This design allows many users to connect to a single database engine while keeping centralized control.

---

## 6. Database System Functional View

A complete database system usually includes the following:

- data definition language (DDL) for schema creation,
- data manipulation language (DML) for row operations,
- query language for retrieval,
- transaction processing,
- metadata management,
- authorization and auditing,
- backup and restore mechanisms,
- performance tuning and indexing.

---

## 7. Database System and SQL Server Context

In SQL Server, a database is typically created inside an instance.

A database instance includes:

- server configuration,
- databases,
- logins and users,
- security settings,
- services and connectivity.

In SSMS, you usually work with:

- Server instance
- Databases
- Tables
- Views
- Security
- Jobs
- Backups

---

## 8. SSMS: Wizard/GUI Steps

### Create a new database in SSMS
1. Open SQL Server Management Studio.
2. Connect to your SQL Server instance.
3. In Object Explorer, right-click on Databases.
4. Select New Database.
5. Enter the database name.
6. Choose file locations and initial sizes.
7. Click OK.

This creates the database files and the logical structure behind the scenes.

### Create a table in SSMS
1. Expand the database.
2. Right-click Tables.
3. Choose New > Table.
4. Add column names, data types, and nullability.
5. Set primary key and constraints.
6. Save the table.

This is the GUI equivalent of a CREATE TABLE statement.

---

## 9. Equivalent T-SQL Examples

```sql
-- Create a database
CREATE DATABASE SchoolDB;
GO

USE SchoolDB;
GO

-- Create a table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Age INT CHECK (Age >= 0),
    Email VARCHAR(100) UNIQUE
);
GO

-- Insert rows
INSERT INTO Students (StudentID, FirstName, LastName, Age, Email)
VALUES
    (1, 'Alice', 'Johnson', 20, 'alice@example.com'),
    (2, 'Bob', 'Smith', 22, 'bob@example.com');
GO

-- Query rows
SELECT *
FROM Students;
GO

-- Basic backup concept in SQL Server
BACKUP DATABASE SchoolDB
TO DISK = 'C:\SQLBackups\SchoolDB.bak';
GO
```

---

## 10. Exam-Friendly Summary

- Database = collection of related data
- DBMS = software used to manage the database
- Schema = structure of the database
- Instance = current database state
- Three levels: external, conceptual, internal
- DBMS includes query processing, storage management, transactions, recovery, security
- SQL Server follows a client-server database architecture

> 💡 **Core idea**
> The architecture of a database system separates logical design from physical storage, making the system more powerful, secure, and scalable.

---

> 🔗 **See also**
> - [../01_DDL_DML_DCL_TCL/theory.md](../01_DDL_DML_DCL_TCL/theory.md)
> - [../03_Relational_Data_Model/theory.md](../03_Relational_Data_Model/theory.md)
> - [../../00_Roadmap_and_StyleGuide/roadmap.md](../../00_Roadmap_and_StyleGuide/roadmap.md)
