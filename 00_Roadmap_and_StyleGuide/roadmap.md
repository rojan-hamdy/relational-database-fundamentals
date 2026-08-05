# 📚 Database & SQL Mastery Repo — Master Roadmap

This is the blueprint for the repo before we create a single lesson file. Everything below is designed to avoid redundancy, keep a consistent structure, and scale as you add your PDFs, screenshots, and certificates.

---

## 1. Guiding Principles

1. **One concept, one home.** Every topic (e.g., "Normalization") lives in exactly one folder. If SQL syntax for it is needed elsewhere, we *link*, not *duplicate*.
2. **Three content layers per lesson:**
   - `theory.md` → concept explanation (from your PDFs, rewritten/structured, not copy-pasted)
   - `hands_on.ipynb` or `.sql` → runnable/practice queries (SSMS or psql/pgAdmin)
   - `self_test.md` → quiz + answer key (collapsible answers)
3. **Visuals live beside the lesson**, not in one giant `images/` dump — easier to maintain, easier to find.
4. **SSMS/GUI steps are always paired with the equivalent T-SQL code** ("Wizard way" vs "Code way").
5. **Eye-comfort styling** → soft dark-mode-friendly Markdown theme (muted headers, callout boxes, no neon), applied consistently via a shared style guide file.

---

## 2. Top-Level Folder Structure

```
DB-SQL-Mastery/
│
├── 00_Roadmap_and_StyleGuide/
│   ├── roadmap.md
│   ├── style_guide.md          # colors, heading levels, callout box syntax
│   └── glossary.md             # every term defined once, linked from everywhere
│
├── 01_Foundations/
│   ├── 01_DDL_DML_DCL_TCL/
│   ├── 02_Database_System_Architecture/   # from L03 PDF
│   └── 03_Relational_Data_Model/          # from L02 PDF
│
├── 02_Conceptual_and_Logical_Design/
│   ├── 01_ER_Model/                       # L05-Part1
│   ├── 02_EER_Model/                      # L05-Part2
│   ├── 03_ER_to_Relational_Mapping/       # L06-Part1
│   ├── 04_EER_to_Relational_Mapping/      # L06-Part2
│   └── 05_Conceptual_vs_Logical_vs_Physical/
│
├── 03_Normalization/
│   ├── 01_Functional_Dependencies/        # L08
│   ├── 02_Normal_Forms_1NF_to_BCNF/
│   └── 03_Denormalization_tradeoffs/
│
├── 04_Constraints_and_Integrity/
│   ├── PK_FK_Unique_Check_Default/
│   └── Referential_Integrity_Actions/     # cascade, restrict, set null
│
├── 05_SQL_Core_Query_Toolkit/             # your "separate part" request
│   ├── 01_SELECT_WHERE_ORDER_BY/
│   ├── 02_JOINS/
│   ├── 03_CREATE_ALTER_DROP/
│   ├── 04_INSERT_UPDATE_DELETE_MERGE/
│   └── syntax_cheatsheet.md
│
├── 06_Aggregation_and_Analytics/
│   ├── 01_Aggregate_Functions/
│   ├── 02_GROUP_BY_HAVING/
│   ├── 03_ROLLUP_CUBE_GROUPING_SETS/
│   ├── 04_PIVOT_UNPIVOT/
│   ├── 05_Window_Functions_and_Ranking/
│   └── 06_Built_in_Functions/             # string/date/math/system funcs
│
├── 07_Centralized_vs_Distributed_DB/
│
├── 08_Authorization_and_Authentication/
│
├── 09_Database_Security_Backbone/
│   └── 10_Steps/                          # you'll provide these — 1 file per step
│
├── 10_Import_Export/
│   ├── SSMS_Import_Export_Wizard/
│   └── BCP_and_Scripts/
│
├── 11_NoSQL/                              # L11
│
├── 12_SSMS_Admin_and_Setup/               # "steps to navigate any change in setup"
│   ├── Server_Configuration/
│   ├── Database_Configuration/
│   └── each file: Wizard steps (screenshots) + T-SQL equivalent
│
├── 13_Certificates_and_External_Courses/  # your existing certs, indexed
│
└── assets/
    └── _shared/                            # only truly reusable diagrams/icons
```

Each lesson folder (e.g. `01_ER_Model/`) will internally follow the **same skeleton**:
```
01_ER_Model/
├── theory.md
├── images/              (screenshots/diagrams specific to this lesson)
├── hands_on.ipynb
├── self_test.md
└── slides.pptx          (optional, only where a visual walkthrough helps)
```

---

## 3. Lesson Build Order (sequenced to avoid rework)

| Phase | Lessons | Why this order |
|---|---|---|
| **Phase 0** | Style guide + Glossary + Repo skeleton | Prevents redundant formatting decisions later |
| **Phase 1** | DDL/DML/DCL/TCL definitions | Foundational vocabulary used everywhere else |
| **Phase 2** | DB System Architecture + Relational Model | Sets up "what a database even is" before design |
| **Phase 3** | SQL Core Query Toolkit (SELECT, JOIN, WHERE...) | You'll need these to write examples in every later lesson |
| **Phase 4** | ER/EER Modeling + Mapping to Relational | Design layer |
| **Phase 5** | Normalization (FDs → 1NF...BCNF) | Depends on relational model + mapping knowledge |
| **Phase 6** | Constraints & Integrity | Naturally follows normalization |
| **Phase 7** | Aggregation & Analytics (GROUP BY → ROLLUP/CUBE → PIVOT → Window functions) | Needs Core SQL Toolkit done first |
| **Phase 8** | Centralized vs Distributed DB | Conceptual, standalone |
| **Phase 9** | AuthN/AuthZ + Security Backbone (your 10 steps) | Needs DCL from Phase 1 |
| **Phase 10** | Import/Export | Practical, standalone |
| **Phase 11** | NoSQL | Good closing contrast lesson |
| **Phase 12** | SSMS Admin/Setup how-tos | Built incrementally as you encounter each setting |
| **Phase 13** | Certificates index | Housekeeping, do anytime |

---

## 4. File Format Rules (when to use what)

| Format | Use for |
|---|---|
| `.md` | All theory, definitions, comparisons, syntax cheat sheets, self-tests |
| `.ipynb` | Runnable SQL demos with explanations interleaved (great for query-by-query walkthroughs) |
| `.pptx` | Only for visually heavy topics: ER/EER diagrams, normalization step-by-step, security architecture — where slide-by-slide build-up helps more than a static image |
| Screenshots (`.png`) | Every SSMS wizard step — named `01_step_open_wizard.png`, `02_step_choose_source.png`, etc. |

---

## 5. Style Guide Preview (eye-comfort, will live in `style_guide.md`)

- Headings: `#` Lesson title → `##` major section → `###` sub-point (never skip a level)
- Callout boxes:
  - `> 💡 **Concept**` for definitions
  - `> ⚠️ **Common Mistake**`
  - `> 🧪 **Try it yourself**`
- Code blocks always tagged \`\`\`sql
- Muted palette for any diagrams: soft blue/teal/gray instead of pure red/green/neon (I'll generate diagrams using this palette by default)

---

## 6. What I need from you, per lesson, going forward

For each lesson, when you're ready to build it, just give me:
1. The relevant PDF(s) (e.g., "L05-Part1 ER Model")
2. Any SSMS screenshots you already have for that topic (optional — I can also tell you exactly which screen to screenshot)
3. Anything specific you want emphasized (exam focus, project use, etc.)

I'll then produce `theory.md` + `hands_on.ipynb`/`.sql` + `self_test.md` (+ `.pptx` if visual) for that folder, matching the style guide.

---

## 7. Immediate Next Steps

1. ✅ Confirm/adjust this folder structure and phase order
2. Build **Phase 0**: style guide, glossary skeleton, and the empty repo skeleton with all folders (I can generate this now as a downloadable zip)
3. Build **Phase 1, Lesson 1**: DDL vs DML vs DCL vs TCL — definitions + function of each (you asked to start here — I can write this right now)

