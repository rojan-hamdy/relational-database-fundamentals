# Relational Database Fundmentals

This repository is the main learning path for SQL Server, relational database design, SQL querying, and database administration.

It includes:
- theory notes,
- hands-on SQL examples,
- self-test exercises,
- SSMS setup workflows,
- security and authentication examples,
- and practical database administration steps.

The active learning content is organized in the numbered modules below. The support files in the 00 folder are useful references, but they are not the main learning flow.

---

## Active repo structure

```text
SQL-server-complete-guide/
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
├── 12_SSMS_Admin_and_Setup/
├── assets/
├── LICENSE
├── README.md
└── ...
```

---

## Main learning modules

### 01_Foundations
- DDL, DML, DCL, TCL
- database architecture
- relational model

### 02_Conceptual_and_Logical_Design
- ER model
- EER model
- mapping to relational design
- conceptual vs logical vs physical design

### 03_Normalization
- functional dependencies
- normal forms
- denormalization tradeoffs

### 04_Constraints_and_Integrity
- PK, FK, UNIQUE, CHECK, DEFAULT
- referential integrity actions

### 05_SQL_Core_Query_Toolkit
- SELECT, WHERE, ORDER BY (order of execution, LIKE pattern matching, TOP WITH TIES, CASE, IIF, NEWID)
- JOINs
- CREATE, ALTER, DROP (schemas hierarchy & IDENTITY management)
- INSERT, UPDATE, DELETE, MERGE (TRUNCATE deep dive, SELECT INTO, INSERT SELECT)
- Set Operators (UNION, UNION ALL, INTERSECT, EXCEPT)
- Subqueries (scalar, correlated, ALL, ANY/SOME, EXISTS)
- SQL syntax cheatsheet

### 06_Aggregation_and_Analytics
- aggregates
- GROUP BY and HAVING
- ROLLUP, CUBE, GROUPING SETS
- PIVOT and UNPIVOT
- window functions and ranking
- built-in functions

### 07_Centralized_vs_Distributed_DB
- centralized vs distributed architecture

### 08_Authorization_and_Authentication
- authentication and authorization concepts
- practical permission examples

### 09_Database_Security_Backbone
- 10-step security framework

### 10_Import_Export
- BCP and scripts
- SSMS Import/Export wizard

### 11_NoSQL
- NoSQL overview and comparison

### 12_SSMS_Admin_and_Setup
- SQL Server authentication and instance settings
- database configuration
- login, user, schema, and permissions flow

---

## Recommended learning order

1. Foundations
2. Design and modeling
3. Normalization and integrity
4. SQL query building
5. Aggregation and analytics
6. Security and authorization
7. SSMS administration
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
- [12_SSMS_Admin_and_Setup](12_SSMS_Admin_and_Setup)
