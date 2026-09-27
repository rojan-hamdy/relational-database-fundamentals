# Relational Database Fundamentals & PostgreSQL Guide

This repository is the complete curriculum for Database Management Systems (DBMS), relational database design, SQL querying, and database administration using **PostgreSQL** and **pgAdmin**.

It includes:
- theory notes on core database fundamentals,
- hands-on PostgreSQL (`.sql`) examples,
- self-test review exercises,
- pgAdmin setup and workflow guides,
- security, authentication, and role permission examples,
- and practical database administration steps.

The active learning content is organized in the numbered modules below. The support files in the `00_Roadmap_and_glossary` folder serve as reference material.

---

## Active repo structure

```text
Relational-Database-Fundamentals/
├── 00_Roadmap_and_glossary/
├── 01_Foundations/
├── 02_Conceptual_and_Logical_Design/
├── 03_Normalization/
├── 04_Constraints_and_Integrity/
├── 05_SQL_Core_Query_Toolkit/
├── 06_Aggregation_and_Analytics/
├── 07_Centralized_vs_Distributed_DB/
├── 08_Authorization_and_Authentication/
├── 09_Database_Security_Backbone/
├── 10_Import_Export/
├── 11_NoSQL/
├── 12_pgAdmin_Admin_and_Setup/
├── assets/
├── LICENSE
├── README.md
└── ...
```

---

## Main learning modules

### 01_Foundations
- DDL, DML, DCL, TCL in PostgreSQL
- Database system architecture (PostgreSQL process/memory model)
- Relational data model principles

### 02_Conceptual_and_Logical_Design
- ER model
- EER model
- Mapping ER/EER to relational schemas
- Conceptual vs logical vs physical design

### 03_Normalization
- Functional dependencies
- Normal forms (1NF to 5NF, BCNF)
- Denormalization tradeoffs

### 04_Constraints_and_Integrity
- PK, FK, UNIQUE, CHECK, DEFAULT in PostgreSQL
- Referential integrity actions (CASCADE, SET NULL, RESTRICT, NO ACTION)

### 05_SQL_Core_Query_Toolkit
- SELECT, WHERE, ORDER BY (execution order, LIKE/ILIKE, LIMIT/OFFSET, CASE, COALESCE, gen_random_uuid())
- JOINs (INNER, LEFT, RIGHT, FULL, CROSS)
- CREATE, ALTER, DROP (schemas hierarchy, SERIAL / GENERATED ALWAYS AS IDENTITY)
- INSERT, UPDATE, DELETE, UPSERT / ON CONFLICT (TRUNCATE deep dive, INSERT INTO ... SELECT)
- Set Operators (UNION, UNION ALL, INTERSECT, EXCEPT)
- Subqueries (scalar, correlated, ALL, ANY/SOME, EXISTS)
- PostgreSQL SQL syntax cheatsheet

### 06_Aggregation_and_Analytics
- Aggregates (COUNT, SUM, AVG, MAX, MIN, STRING_AGG)
- GROUP BY and HAVING
- ROLLUP, CUBE, GROUPING SETS
- Cross-tabulation / PIVOT patterns (crosstab)
- Window functions and ranking (ROW_NUMBER, RANK, DENSE_RANK, NTILE, LAG, LEAD)
- Built-in functions (string, date/time, math)

### 07_Centralized_vs_Distributed_DB
- Centralized vs distributed database architecture
- PostgreSQL replication & sharding overview

### 08_Authorization_and_Authentication
- PostgreSQL authentication (pg_hba.conf) and authorization concepts
- Roles, users, grants, and schema-level permissions

### 09_Database_Security_Backbone
- 10-step database security framework

### 10_Import_Export
- `pg_dump`, `pg_restore`, and `COPY` commands
- pgAdmin Import/Export GUI tools

### 11_NoSQL
- Relational vs NoSQL overview (JSONB in PostgreSQL vs Document DBs)

### 12_pgAdmin_Admin_and_Setup
- PostgreSQL server & instance configuration (postgresql.conf)
- Database creation & configuration
- Roles, users, schemas, and privilege management flow

---

## Recommended learning order

1. Foundations
2. Design and modeling
3. Normalization and integrity
4. SQL query building (PostgreSQL)
5. Aggregation and analytics
6. Security and authorization
7. pgAdmin administration
8. Import/export and NoSQL

This sequence keeps the course logical and avoids jumping between theory, design, and administration too early.

---

## Lesson pattern

Each major topic is structured around:
- `theory.md` for the concept,
- `hands_on.sql` for practice,
- `self_test.md` for review,
- `images/` for visuals specific to that lesson.

---

## Quick access

- [01_Foundations](01_Foundations)
- [02_Conceptual_and_Logical_Design](02_Conceptual_and_Logical_Design)
- [03_Normalization](03_Normalization)
- [04_Constraints_and_Integrity](04_Constraints_and_Integrity)
- [05_SQL_Core_Query_Toolkit](05_SQL_Core_Query_Toolkit)
- [06_Aggregation_and_Analytics](06_Aggregation_and_Analytics)
- [07_Centralized_vs_Distributed_DB](07_Centralized_vs_Distributed_DB)
- [08_Authorization_and_Authentication](08_Authorization_and_Authentication)
- [09_Database_Security_Backbone](09_Database_Security_Backbone)
- [10_Import_Export](10_Import_Export)
- [11_NoSQL](11_NoSQL)
- [12_pgAdmin_Admin_and_Setup](12_pgAdmin_Admin_and_Setup)

