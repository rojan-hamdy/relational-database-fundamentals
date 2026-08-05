# Self-Test — Normal Forms (1NF to BCNF)

**Q1. What is normalization?**

<details>
<summary>Show answer</summary>
Normalization is the process of organizing tables to reduce redundancy and improve data integrity.
</details>

**Q2. What is 1NF?**

<details>
<summary>Show answer</summary>
A table is in 1NF when each column contains atomic values and no repeating groups exist.
</details>

**Q3. What is 2NF?**

<details>
<summary>Show answer</summary>
2NF means the table is in 1NF and all non-key attributes depend on the full primary key.
</details>

**Q4. What is 3NF?**

<details>
<summary>Show answer</summary>
3NF means the table is in 2NF and no non-key attribute depends on another non-key attribute.
</details>

**Q5. What is BCNF?**

<details>
<summary>Show answer</summary>
BCNF is a stricter form of 3NF where every determinant is a candidate key.
</details>

**Q6. Why is normalization useful?**

<details>
<summary>Show answer</summary>
It reduces duplication, prevents anomalies, and improves consistency and maintainability.
</details>

---

## Quick revision

- 1NF: atomic values, no repeating groups
- 2NF: no partial dependency on composite keys
- 3NF: no transitive dependency
- BCNF: stronger than 3NF for key-based dependencies
