# Self-Test — ER to Relational Mapping

> Status: ✅ Ready for practice.

**Q1. What happens to a strong entity during ER-to-relational mapping?**

<details>
<summary>Show answer</summary>
It becomes a table, with its attributes mapped to columns and its primary key preserved.
</details>

**Q2. What happens to a one-to-many relationship?**

<details>
<summary>Show answer</summary>
The primary key of the parent entity is added as a foreign key in the child table.
</details>

**Q3. How do you map a many-to-many relationship?**

<details>
<summary>Show answer</summary>
You create a junction/bridge table containing the keys of both related entities.
</details>

**Q4. What happens to a multivalued attribute?**

<details>
<summary>Show answer</summary>
It is usually mapped to a separate table because the attribute can have multiple values per entity.
</details>

**Q5. What is a weak entity?**

<details>
<summary>Show answer</summary>
A weak entity depends on another entity for identity and usually uses the parent key as part of its own key.
</details>

**Q6. Why do we add foreign keys?**

<details>
<summary>Show answer</summary>
To represent relationships between tables and enforce referential integrity.
</details>

**Q7. What is the purpose of a junction table?**

<details>
<summary>Show answer</summary>
To represent many-to-many relationships in a relational schema without violating normal design rules.
</details>

**Q8. What is the role of a primary key in the mapping process?**

<details>
<summary>Show answer</summary>
It uniquely identifies rows in each mapped table and helps establish relationships.
</details>

---

## Quick revision

- Strong entity = table
- One-to-many = foreign key in child table
- Many-to-many = junction table
- Weak entity = parent key + local key
- Mapping converts conceptual design into relational implementation

