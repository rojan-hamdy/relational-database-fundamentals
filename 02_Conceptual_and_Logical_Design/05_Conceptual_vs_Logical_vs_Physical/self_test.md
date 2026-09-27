# Self-Test — Conceptual vs Logical vs Physical Design

**Q1. What is conceptual design focused on?**

<details>
<summary>Show answer</summary>
The business meaning of the data: entities, relationships, and rules.
</details>

**Q2. What is logical design focused on?**

<details>
<summary>Show answer</summary>
The relational structure: tables, columns, keys, constraints, and normalized relationships.
</details>

**Q3. What is physical design focused on?**

<details>
<summary>Show answer</summary>
How data is stored, indexed, and optimized in the database engine.
</details>

**Q4. What artifact is commonly used in conceptual design?**

<details>
<summary>Show answer</summary>
An ER or EER diagram.
</details>

**Q5. What artifact is commonly used in logical design?**

<details>
<summary>Show answer</summary>
A relational schema with primary and foreign keys.
</details>

**Q6. Why do indexes belong to the physical design stage?**

<details>
<summary>Show answer</summary>
Because indexes affect storage access paths and performance, not just the logical meaning of the data.
</details>

**Q7. Why should conceptual, logical, and physical design not be treated as the same thing?**

<details>
<summary>Show answer</summary>
Because each layer answers a different question and each has different concerns: business meaning, logical structure, and performance/storage.
</details>

**Q8. What is the final goal of the design process?**

<details>
<summary>Show answer</summary>
To produce a database that is both logically correct and physically efficient.
</details>

---

## Quick revision

- Conceptual = business meaning
- Logical = schema design
- Physical = storage and performance
- Good design connects all three levels

