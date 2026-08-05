# SQL Server Complete Guide

This repository is a complete learning path for SQL Server, database design, database administration, and security.

It combines:
- theory explanations,
- SQL practice files,
- self-test questions,
- SSMS wizard-based steps,
- equivalent T-SQL examples,
- and security/admin workflows.

The goal is to help a learner move from database fundamentals to practical SQL Server administration without needing to search across multiple scattered resources.

---

## What this repo covers

### 1. Foundations
- DDL, DML, DCL, TCL
- Database system architecture
- Relational data model

### 2. Conceptual and logical design
- ER model
- EER model
- ER-to-relational mapping
- EER-to-relational mapping
- Conceptual vs logical vs physical design

### 3. Normalization
- Functional dependencies
- 1NF to BCNF
- Denormalization tradeoffs

### 4. Constraints and integrity
- Primary keys, foreign keys, unique, check, default
- Referential integrity actions

### 5. SQL core query toolkit
- SELECT / WHERE / ORDER BY
- Joins
- CREATE / ALTER / DROP
- INSERT / UPDATE / DELETE / MERGE
- SQL syntax cheat sheet

### 6. Aggregation and analytics
- Aggregate functions
- GROUP BY / HAVING
- ROLLUP / CUBE / GROUPING SETS
- PIVOT / UNPIVOT
- Window functions and ranking
- Built-in SQL functions

### 7. Architecture and access control
- Centralized vs distributed database systems
- Authorization and authentication
- Database security backbone (10-step framework)

### 8. Data movement and administration
- Import and export
- BCP and scripts
- SSMS import/export wizard
- SSMS server configuration
- SSMS database configuration

### 9. NoSQL and modern alternatives
- NoSQL concepts and comparison with relational databases

### 10. Security practices in SQL Server
- authentication mode changes
- login creation
- user creation
- schema creation and schema ownership
- permission assignment
- reconnecting and validation

---

## Repository structure

```text
SQL-server-complete-guide/
├── 00_Roadmap_and_StyleGuide/        # supporting project notes and formatting conventions
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
├── 13_Certificates_and_External_Courses/
├── assets/
├── LICENSE
├── README.md
└── ...
```

---

## Recommended learning path

1. Start with the foundations
2. Learn design and modeling
3. Study normalization and integrity rules
4. Practice SQL query building
5. Move to aggregation and window functions
6. Understand security and authorization
7. Learn SSMS setup and configuration
8. Finish with import/export and NoSQL concepts

That order keeps the concepts logical and prevents confusion between design, querying, and administration.

---

## Lesson pattern used in the repo

Each major lesson usually contains:
- `theory.md` — concept explanation and examples
- `hands_on.sql` — practical exercises
- `self_test.md` — revision questions and answers
- `images/` — visual references for that lesson

This makes each topic self-contained and easy to study.

---

## Important note about the 00 folder

The `00_Roadmap_and_StyleGuide` folder is useful as a supporting project guide, but it is not the main learning path. For the learner, the important content is in the numbered modules above.

If you want a lighter path, treat the 00 folder as optional background material rather than the main entry point.

---

## Learning outcomes

By the end of this course, you should be able to:
- explain database fundamentals and SQL language groups,
- design relational schemas and map ER models to tables,
- normalize data and enforce constraints,
- write advanced SQL queries and analytics logic,
- secure data with proper login, user, schema, and permission design,
- configure SSMS for server and database setup,
- import/export data safely,
- understand NoSQL as a contrast to relational databases.

---

## Repo usage

Open the folder that matches the topic you want to study, then read:
1. `theory.md` for the concept,
2. `hands_on.sql` for practical examples,
3. `self_test.md` for revision.

This keeps the learning flow simple and consistent.

---

## Quick references

- [01_Foundations](01_Foundations)
- [02_Conceptual_and_Logical_Design](02_Conceptual_and_Logical_Design)
- [03_Normalization](03_Normalization)
- [04_Constraints_and_Integrity](04_Constraints_and_Integrity)
- [05_SQL_Core_Query_Toolkit](05_SQL_Core_Query_Toolkit)
- [06_Aggregation_and_Analytics](06_Aggregation_and_Analytics)
- [08_Authorization_and_Authentication](08_Authorization_and_Authentication)
- [09_Database_Security_Backbone](09_Database_Security_Backbone)
- [10_Import_Export](10_Import_Export)
- [11_NoSQL](11_NoSQL)
- [12_SSMS_Admin_and_Setup](12_SSMS_Admin_and_Setup)

---

## Support files

- [00_Roadmap_and_StyleGuide/roadmap.md](00_Roadmap_and_StyleGuide/roadmap.md)
- [00_Roadmap_and_StyleGuide/style_guide.md](00_Roadmap_and_StyleGuide/style_guide.md)
- [00_Roadmap_and_StyleGuide/glossary.md](00_Roadmap_and_StyleGuide/glossary.md)

These are helpful supporting references, but the actual learning content lives primarily in the main numbered sections of the repo.
