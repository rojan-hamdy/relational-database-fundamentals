# Self-Test — EER to Relational Mapping

> Status: ✅ Ready for practice.

**Q1. What is the typical relational mapping for a superclass/subclass relationship?**

<details>
<summary>Show answer</summary>
Create one table for the superclass and separate tables for each subclass, with the subclass key also acting as a foreign key to the superclass.
</details>

**Q2. Why is the subclass key also used as a foreign key in the superclass design?**

<details>
<summary>Show answer</summary>
Because every subclass instance must also exist as a superclass instance.
</details>

**Q3. What is the main difference between a single-table and a multiple-table mapping strategy?**

<details>
<summary>Show answer</summary>
Single-table stores all attributes in one table; multiple-table keeps common attributes in one table and subtype-specific attributes in separate tables.
</details>

**Q4. What problem does the multiple-table strategy help avoid?**

<details>
<summary>Show answer</summary>
It avoids excessive null values when many subtype-specific attributes are not relevant to every row.
</details>

**Q5. What is a category in EER mapping?**

<details>
<summary>Show answer</summary>
A category is a subclass formed from multiple unrelated superclasses or entity types.
</details>

**Q6. What does disjoint specialization mean?**

<details>
<summary>Show answer</summary>
Each superclass instance belongs to only one subclass.
</details>

**Q7. What does overlapping specialization mean?**

<details>
<summary>Show answer</summary>
A superclass instance may belong to more than one subclass at the same time.
</details>

**Q8. Why is EER mapping important before physical implementation?**

<details>
<summary>Show answer</summary>
Because it preserves the correct business hierarchy and relationship rules before building the physical tables.
</details>

---

## Quick revision

- Superclass = shared entity
- Subclass = specialized entity
- Mapping chooses between single-table vs multiple-table strategies
- Foreign keys preserve inheritance relationships
- EER mapping protects logical integrity before SQL implementation

