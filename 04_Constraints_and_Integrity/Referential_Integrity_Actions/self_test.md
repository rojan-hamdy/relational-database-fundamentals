# Self-Test — Referential Integrity Actions (Cascade, Restrict, Set Null)

**Q1. What is referential integrity?**

<details>
<summary>Show answer</summary>
It ensures that relationships between tables remain valid and consistent.
</details>

**Q2. What does CASCADE do?**

<details>
<summary>Show answer</summary>
It propagates the parent change to child rows automatically.
</details>

**Q3. What does SET NULL do?**

<details>
<summary>Show answer</summary>
It removes the relationship by setting the child foreign key to NULL.
</details>

**Q4. What does NO ACTION do?**

<details>
<summary>Show answer</summary>
It prevents the delete or update if dependent child rows still exist.
</details>

**Q5. Why are referential actions important?**

<details>
<summary>Show answer</summary>
They define how the database preserves consistency when parent records are deleted or modified.
</details>

**Q6. Which action is best if a department deletion should remove all of its students?**

<details>
<summary>Show answer</summary>
ON DELETE CASCADE.
</details>

---

## Quick revision

- CASCADE = propagate changes
- SET NULL = clear the relationship
- SET DEFAULT = use a default value
- NO ACTION = block banned change
