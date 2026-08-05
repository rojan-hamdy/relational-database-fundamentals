# 📚 DB-SQL-Mastery

An integrated, self-built repository covering database design, SQL, administration (SSMS), and security — from theory to hands-on practice to self-testing.

> Start here: [`00_Roadmap_and_StyleGuide/roadmap.md`](00_Roadmap_and_StyleGuide/roadmap.md) for the full build plan, and [`style_guide.md`](00_Roadmap_and_StyleGuide/style_guide.md) for formatting conventions used throughout.

## Structure

| Folder | Covers |
|---|---|
| `00_Roadmap_and_StyleGuide` | Roadmap, style guide, glossary |
| `01_Foundations` | DDL/DML/DCL/TCL, DB architecture, relational model |
| `02_Conceptual_and_Logical_Design` | ER, EER, mapping to relational, design levels |
| `03_Normalization` | Functional dependencies, normal forms, denormalization |
| `04_Constraints_and_Integrity` | PK/FK/Unique/Check, referential integrity actions |
| `05_SQL_Core_Query_Toolkit` | SELECT, JOIN, CREATE/ALTER/DROP, INSERT/UPDATE/DELETE/MERGE, syntax cheat sheet |
| `06_Aggregation_and_Analytics` | Aggregates, GROUP BY, ROLLUP/CUBE/GROUPING SETS, PIVOT/UNPIVOT, window functions, built-ins |
| `07_Centralized_vs_Distributed_DB` | Architecture comparison |
| `08_Authorization_and_Authentication` | AuthN/AuthZ concepts and SQL implementation |
| `09_Database_Security_Backbone` | Your 10-step security framework |
| `10_Import_Export` | SSMS wizard + BCP/scripts |
| `11_NoSQL` | NoSQL fundamentals |
| `12_SSMS_Admin_and_Setup` | Server/DB configuration — wizard steps + T-SQL equivalents |
| `13_Certificates_and_External_Courses` | Index of completed certificates |
| `assets/_shared` | Only truly reusable diagrams/icons (lesson-specific visuals stay in each lesson's `images/`) |

## Lesson Anatomy
Every topic folder follows the same skeleton:
```
topic_folder/
├── theory.md         # concept + diagrams
├── images/            # screenshots/diagrams for this lesson
├── hands_on.sql / .ipynb
├── self_test.md       # quiz with collapsible answers
└── slides.pptx         # optional, visual-heavy topics only
```

## Status Legend
- ✅ Complete
- 🟡 In progress
- 🚧 Kept only for intentionally future content

## How We Build Each Lesson
1. You provide the source PDF/notes (+ any SSMS screenshots) for a topic
2. I write `theory.md` following the style guide, embedding/describing diagrams
3. I write `hands_on.sql`/`.ipynb` with runnable, commented examples
4. I write `self_test.md` with quiz questions
5. Glossary and cross-links get updated
