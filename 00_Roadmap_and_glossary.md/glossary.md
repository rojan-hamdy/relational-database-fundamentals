# 📖 Glossary

This glossary is the single source of truth for key database terms in the repo. Each term links directly to the lesson that explains it most clearly.

---

## A
- **ALL / ANY (SOME)** — Comparison operators used with multi-row subqueries (`> ALL`, `> ANY`). See [Subqueries](../05_SQL_Core_Query_Toolkit/06_Subqueries/theory.md).
- **Attribute** — a property of an entity or table. See [ER Model](../02_Conceptual_and_Logical_Design/01_ER_Model/theory.md) and [Relational Data Model](../01_Foundations/03_Relational_Data_Model/theory.md).
- **Authentication** — the process of verifying a user or system identity. See [Authorization and Authentication](../08_Authorization_and_Authentication/theory.md).
- **Authorization** — the process of granting or denying access rights after identity is verified. See [Authorization and Authentication](../08_Authorization_and_Authentication/theory.md).

## C
- **Cardinality** — the number of instances allowed in a relationship between entities. See [ER Model](../02_Conceptual_and_Logical_Design/01_ER_Model/theory.md).
- **CASE** — Expression used for inline conditional logic inside queries. See [SELECT, WHERE, ORDER BY](../05_SQL_Core_Query_Toolkit/01_SELECT_WHERE_ORDER_BY/theory.md).
- **Constraint** — a rule that enforces valid data in a table. See [PK, FK, Unique, Check, Default](../04_Constraints_and_Integrity/PK_FK_Unique_Check_Default/theory.md).
- **COPY / \copy** — High-speed bulk data import and export commands in PostgreSQL. See [COPY and Scripts](../10_Import_Export/COPY_and_Scripts/theory.md).
- **CREATE TABLE AS SELECT** — Statement creating a new table on the fly from query results (PostgreSQL equivalent of SELECT INTO). See [INSERT, UPDATE, DELETE, MERGE](../05_SQL_Core_Query_Toolkit/04_INSERT_UPDATE_DELETE_MERGE/theory.md).

## D
- **DDL (Data Definition Language)** — commands used to define schema objects such as tables and databases. See [DDL, DML, DCL, TCL](../01_Foundations/01_DDL_DML_DCL_TCL/theory.md).
- **DML (Data Manipulation Language)** — commands used to change row data. See [DDL, DML, DCL, TCL](../01_Foundations/01_DDL_DML_DCL_TCL/theory.md).
- **DCL (Data Control Language)** — commands used to control permissions and access. See [DDL, DML, DCL, TCL](../01_Foundations/01_DDL_DML_DCL_TCL/theory.md).
- **TCL (Transaction Control Language)** — commands used to manage transactions such as COMMIT and ROLLBACK. See [DDL, DML, DCL, TCL](../01_Foundations/01_DDL_DML_DCL_TCL/theory.md).
- **Denormalization** — the intentional reintroduction of redundancy for performance or reporting needs. See [Denormalization Tradeoffs](../03_Normalization/03_Denormalization_tradeoffs/theory.md).
- **Distributed Database** — a database spread across multiple servers or locations. See [Centralized vs Distributed DB](../07_Centralized_vs_Distributed_DB/theory.md).

## E
- **EER (Enhanced Entity-Relationship)** — an extended ER model that includes specialization and inheritance concepts. See [EER Model](../02_Conceptual_and_Logical_Design/02_EER_Model/theory.md).
- **Entity** — a real-world object or concept represented in the database. See [ER Model](../02_Conceptual_and_Logical_Design/01_ER_Model/theory.md).
- **EXCEPT** — Set operator returning distinct rows from the first query absent in the second. See [Set Operators](../05_SQL_Core_Query_Toolkit/05_Set_Operators/theory.md).

## F
- **FETCH FIRST WITH TIES** — Restricts row output while including all rows tied with the cutoff boundary. See [SELECT, WHERE, ORDER BY](../05_SQL_Core_Query_Toolkit/01_SELECT_WHERE_ORDER_BY/theory.md).
- **Functional Dependency** — a relationship where one attribute determines another. See [Functional Dependencies](../03_Normalization/01_Functional_Dependencies/theory.md).
- **Foreign Key** — a column or set of columns that reference another table's primary key. See [PK, FK, Unique, Check, Default](../04_Constraints_and_Integrity/PK_FK_Unique_Check_Default/theory.md).

## G
- **GENERATED ALWAYS AS IDENTITY** — Standard SQL syntax for auto-incrementing integer columns in PostgreSQL. See [CREATE, ALTER, DROP](../05_SQL_Core_Query_Toolkit/03_CREATE_ALTER_DROP/theory.md).
- **gen_random_uuid()** — Native PostgreSQL function generating random UUIDs. See [Built-in Functions](../06_Aggregation_and_Analytics/06_Built_in_Functions/theory.md).

## I
- **INTERSECT** — Set operator returning distinct rows common to both query results. See [Set Operators](../05_SQL_Core_Query_Toolkit/05_Set_Operators/theory.md).

## L
- **LIKE / ILIKE** — Wildcard pattern matching operators (`ILIKE` for case-insensitive matching). See [SELECT, WHERE, ORDER BY](../05_SQL_Core_Query_Toolkit/01_SELECT_WHERE_ORDER_BY/theory.md).
- **Logical Query Processing** — The order of execution evaluated by PostgreSQL (`FROM` → `WHERE` → `SELECT` → `ORDER BY` → `LIMIT`). See [SELECT, WHERE, ORDER BY](../05_SQL_Core_Query_Toolkit/01_SELECT_WHERE_ORDER_BY/theory.md).

## N
- **Normalization** — the process of organizing data to reduce redundancy and improve integrity. See [Normal Forms (1NF to BCNF)](../03_Normalization/02_Normal_Forms_1NF_to_BCNF/theory.md).
- **NoSQL** — a category of non-relational data stores designed for different scalability and modeling patterns. See [NoSQL](../11_NoSQL/theory.md).

## P
- **pg_dump / pg_restore** — Command-line utilities for backing up and restoring PostgreSQL databases. See [COPY and Scripts](../10_Import_Export/COPY_and_Scripts/theory.md).
- **Primary Key** — a key used to uniquely identify each row in a table. See [PK, FK, Unique, Check, Default](../04_Constraints_and_Integrity/PK_FK_Unique_Check_Default/theory.md).

## R
- **Referential Integrity** — the rule that relationships between tables remain valid and consistent. See [Referential Integrity Actions](../04_Constraints_and_Integrity/Referential_Integrity_Actions/theory.md).
- **Relation (Table)** — a set of records stored in a structured tabular form. See [Relational Data Model](../01_Foundations/03_Relational_Data_Model/theory.md).
- **Role** — Unified user/login account and group entity in PostgreSQL. See [pgAdmin Server Configuration](../12_pgAdmin_Admin_and_Setup/Server_Configuration/theory.md).

## S
- **Schema** — A logical container and namespace within a database. See [CREATE, ALTER, DROP](../05_SQL_Core_Query_Toolkit/03_CREATE_ALTER_DROP/theory.md).
- **SERIAL** — PostgreSQL data type creating auto-incrementing integer sequences. See [CREATE, ALTER, DROP](../05_SQL_Core_Query_Toolkit/03_CREATE_ALTER_DROP/theory.md).

## T
- **TRUNCATE TABLE** — Fast statement clearing all table rows, with full transaction rollback support in PostgreSQL. See [INSERT, UPDATE, DELETE, MERGE](../05_SQL_Core_Query_Toolkit/04_INSERT_UPDATE_DELETE_MERGE/theory.md).

## U
- **UNION / UNION ALL** — Set operators combining result sets with or without duplicate removal. See [Set Operators](../05_SQL_Core_Query_Toolkit/05_Set_Operators/theory.md).

## W
- **Window Function** — a function that performs calculations across a set of related rows. See [Window Functions and Ranking](../06_Aggregation_and_Analytics/05_Window_Functions_and_Ranking/theory.md).
