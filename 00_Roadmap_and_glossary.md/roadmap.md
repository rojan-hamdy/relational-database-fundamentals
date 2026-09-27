# Roadmap

This file describes the learning flow of the repository.

---

## 1. Active learning path

1. Foundations
   - DDL, DML, DCL, TCL in PostgreSQL
   - database system architecture (PostgreSQL process/memory model)
   - relational data model

2. Conceptual and logical design
   - ER model
   - EER model
   - ER/EER-to-relational mapping
   - conceptual vs logical vs physical design

3. Normalization
   - functional dependencies
   - 1NF to BCNF
   - denormalization tradeoffs

4. Constraints and integrity
   - PK, FK, UNIQUE, CHECK, DEFAULT in PostgreSQL
   - referential integrity actions (CASCADE, RESTRICT, SET NULL)

5. SQL core query toolkit
   - SELECT, WHERE, ORDER BY (order of execution, LIKE/ILIKE, LIMIT/OFFSET, CASE, COALESCE)
   - joins
   - CREATE, ALTER, DROP (schemas hierarchy, SERIAL / GENERATED ALWAYS AS IDENTITY)
   - INSERT, UPDATE, DELETE, MERGE / UPSERT (TRUNCATE deep dive, CREATE TABLE AS SELECT, INSERT SELECT)
   - Set Operators (UNION, UNION ALL, INTERSECT, EXCEPT)
   - Subqueries (ALL, ANY/SOME, EXISTS)

6. Aggregation and analytics
   - aggregates (COUNT, SUM, AVG, MAX, MIN, STRING_AGG)
   - GROUP BY and HAVING
   - ROLLUP, CUBE, GROUPING SETS
   - PIVOT / crosstab
   - window functions & ranking
   - built-in functions

7. Architecture and access control
   - centralized vs distributed DB
   - authorization and authentication (pg_hba.conf, roles)
   - database security backbone

8. Data movement and administration
   - import/export (`COPY`, `\copy`, `pg_dump`, `pg_restore`)
   - pgAdmin GUI tools

9. NoSQL
   - comparison with relational design & JSONB in PostgreSQL

10. pgAdmin administration
   - server configuration (postgresql.conf)
   - database configuration & tablespaces
   - role, user, schema, and permission setup

---

## 2. Folder structure in use

```text
00_Roadmap_and_glossary.md/
01_Foundations/
02_Conceptual_and_Logical_Design/
03_Normalization/
04_Constraints_and_Integrity/
05_SQL_Core_Query_Toolkit/
06_Aggregation_and_Analytics/
07_Centralized_vs_Distributed_DB/
08_Authorization_and_Authentication/
09_Database_Security_Backbone/
10_Import_Export/
11_NoSQL/
12_pgAdmin_Admin_and_Setup/
assets/
LICENSE
README.md
```

---

## 3. Study order

The recommended order is:

1. Start with the foundations.
2. Move through design and modeling.
3. Learn normalization and constraints.
4. Practice SQL query writing (PostgreSQL).
5. Learn aggregation and analytics.
6. Study authorization, authentication, and database security.
7. Learn server and database administration in pgAdmin.
8. Finish with import/export and NoSQL.

This keeps the learning flow aligned with real database work.

