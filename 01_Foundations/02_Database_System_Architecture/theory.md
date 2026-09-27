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
> The structure of the database: tables, columns, constraints, relationships, and rules. In PostgreSQL, "schema" also refers to a namespace inside a database (e.g. the default `public` schema) that groups related tables.

> 💡 **Instance**
> A specific state or snapshot of the database at a given moment, including the currently stored data. In PostgreSQL, "instance" (or "cluster") more precisely refers to a single running `postgres` server process managing one or more databases.

> 💡 **Metadata**
> Data about the data: column names, data types, constraints, table definitions, and relationship rules. In PostgreSQL this lives in the `information_schema` and the `pg_catalog` system catalogs.

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
- This is often implemented through views (`CREATE VIEW`).

### 3.2 Conceptual Level
This is the logical representation of the whole database.

- It describes entities, relationships, constraints, and rules.
- It is independent of physical storage details.

### 3.3 Internal Level
This is the storage view.

- Defines how data is stored on disk.
- Includes files, indexes, record organization, pages (PostgreSQL uses 8 KB pages by default), and access paths.
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
- planner/optimizer (in PostgreSQL, the query planner, inspectable via `EXPLAIN`),
- execution engine.

### 4.2 Storage Manager
Responsible for actual data handling.

It manages:
- files,
- pages,
- tables (including PostgreSQL's heap storage and TOAST for large values),
- indexes,
- buffers (the shared buffer cache),
- transactions.

### 4.3 Transaction Manager
Controls transactions so that operations are atomic, consistent, isolated, and durable (ACID). PostgreSQL implements this using MVCC (Multi-Version Concurrency Control).

### 4.4 Recovery Manager
Ensures the database can be restored after crashes or failures. PostgreSQL uses Write-Ahead Logging (WAL) for crash recovery.

### 4.5 Concurrency Control Manager
Coordinates simultaneous access by multiple users to prevent inconsistent or invalid results, primarily via PostgreSQL's MVCC model rather than heavy locking.

### 4.6 Authorization and Security Manager
Checks whether a user (role) has permission to access or modify data, via PostgreSQL roles and privileges (`GRANT`/`REVOKE`).

---

## 5. Client-Server Database Model

Most PostgreSQL systems use a client-server architecture.

- Client: application, `psql`, or pgAdmin interface
- Server: PostgreSQL server process (`postgres`)
- Database files: stored on the server (the data directory)
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
- backup and restore mechanisms (`pg_dump` / `pg_restore`),
- performance tuning and indexing.

---

## 7. Database System and PostgreSQL Context

In PostgreSQL, a database is created inside a server instance (cluster).

A database instance (cluster) includes:

- server configuration (`postgresql.conf`, `pg_hba.conf`),
- databases,
- roles (used for both logins and users),
- security settings,
- services and connectivity.

In pgAdmin, you usually work with:

- Server
- Databases
- Schemas
- Tables
- Views
- Login/Group Roles
- Tablespaces
- Scheduled/maintenance jobs (via pgAgent, if installed)
- Backups

---

## 8. pgAdmin: Wizard/GUI Steps

### Create a new database in pgAdmin
1. Open pgAdmin.
2. Connect to your PostgreSQL server.
3. In the Object Explorer (Browser panel), right-click on **Databases**.
4. Select **Create > Database...**.
5. Enter the database name.
6. Choose the owner, encoding, and other settings on the relevant tabs.
7. Click **Save**.

This creates the database and its logical structure behind the scenes.

### Create a table in pgAdmin
1. Expand the database, then expand **Schemas > public** (or the relevant schema).
2. Right-click **Tables**.
3. Choose **Create > Table...**.
4. On the **Columns** tab, add column names, data types, and nullability.
5. On the **Constraints** tab, set the primary key and other constraints.
6. Click **Save**.

This is the GUI equivalent of a `CREATE TABLE` statement.

---

## 9. Equivalent PostgreSQL (psql) Examples

```sql
-- Create a database (run from psql connected to the 'postgres' database,
-- or via pgAdmin's Create Database dialog)
CREATE DATABASE "SchoolDB";

-- Connect to the new database
-- In psql:
\c SchoolDB
-- In pgAdmin, simply click on the database in the Browser panel.

-- Create a table
CREATE TABLE Students (
    StudentID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Age INT CHECK (Age >= 0),
    Email VARCHAR(100) UNIQUE
);

-- Insert rows
INSERT INTO Students (FirstName, LastName, Age, Email)
VALUES
    ('Alice', 'Johnson', 20, 'alice@example.com'),
    ('Bob', 'Smith', 22, 'bob@example.com');

-- Query rows
SELECT *
FROM Students;

-- Basic backup concept in PostgreSQL (run from a terminal, not inside psql)
-- pg_dump -U postgres -F c -d SchoolDB -f /path/to/SchoolDB.backup
```

> Note: `StudentID` uses `SERIAL` (PostgreSQL's auto-incrementing integer) instead of manually assigning IDs, since `INT PRIMARY KEY` alone has no auto-increment behavior in PostgreSQL the way `IDENTITY` does in T-SQL. Backups are typically taken with the `pg_dump` command-line utility (or pgAdmin's **Backup...** option on a database), rather than a `BACKUP DATABASE` SQL statement.

---

## 10. Exam-Friendly Summary

- Database = collection of related data
- DBMS = software used to manage the database
- Schema = structure of the database (and, in PostgreSQL, also a namespace within it)
- Instance = current database state (and, in PostgreSQL, the running server/cluster)
- Three levels: external, conceptual, internal
- DBMS includes query processing, storage management, transactions, recovery, security
- PostgreSQL follows a client-server database architecture

> 💡 **Core idea**
> The architecture of a database system separates logical design from physical storage, making the system more powerful, secure, and scalable.

---

> 🔗 **See also**
> - [../01_DDL_DML_DCL_TCL/theory.md](../01_DDL_DML_DCL_TCL/theory.md)
> - [../03_Relational_Data_Model/theory.md](../03_Relational_Data_Model/theory.md)
