# 🎨 Style Guide

Applies to every `.md`, `.ipynb`, and `.pptx` file in this repo. Consistency here is what makes the repo feel "integrated" instead of a pile of separate notes.

## Heading Hierarchy
```
# Lesson Title              (one per file, matches folder name)
## Major Section
### Sub-point
#### Rarely used — prefer restructuring instead
```

## Callout Boxes (copy-paste these blocks)

> 💡 **Concept**
> Use for core definitions — the "what is this" explanation.

> ⚠️ **Common Mistake**
> Use for pitfalls, exam traps, or things that silently break queries.

> 🧪 **Try it yourself**
> Use to hand off to `hands_on.ipynb`/`.sql` with a specific task.

> 🔗 **See also**
> Use to cross-link instead of duplicating content (e.g., "See `05_SQL_Core_Query_Toolkit/02_JOINS` for JOIN syntax").

## Code Blocks
Always tag the language:
```sql
SELECT column_name
FROM table_name
WHERE condition;
```

## Color Palette (for diagrams / slides — soft, low-eye-strain)

| Purpose | Color | Hex |
|---|---|---|
| Primary / headers | Muted Teal | `#4C8577` |
| Secondary / entities | Soft Slate Blue | `#5D6D8C` |
| Accent / highlight | Warm Sand | `#D8A657` |
| Background (light mode) | Off-white | `#F7F5F0` |
| Background (dark mode) | Charcoal | `#242628` |
| Error / constraint violation | Muted Coral (not pure red) | `#C97064` |
| Success / valid | Sage Green (not pure green) | `#7A9E7E` |

Avoid: pure red (#FF0000), pure green (#00FF00), neon colors, low-contrast pastel-on-white text.

## Naming Conventions
- Folders: `NN_Title_Case_With_Underscores`
- Screenshots: `NN_step_short-description.png` (e.g., `03_step_choose-destination-table.png`)
- SQL files: `topic_action.sql` (e.g., `joins_inner-outer-examples.sql`)

## Lesson File Skeleton (every topic folder contains)
```
topic_folder/
├── theory.md         # concept, definitions, diagrams embedded
├── images/            # screenshots + diagrams for THIS lesson only
├── hands_on.ipynb     # or .sql — runnable practice
├── self_test.md       # quiz with collapsible answers
└── slides.pptx         # optional, only if a visual build-up helps
```

## Self-Test Answer Format (keeps quizzes skimmable)
```markdown
**Q1. What does DDL stand for?**

<details>
<summary>Show answer</summary>
Data Definition Language — defines/modifies schema objects (CREATE, ALTER, DROP).
</details>
```
