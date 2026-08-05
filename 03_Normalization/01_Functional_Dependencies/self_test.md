# Self-Test — Functional Dependencies

**Q1. What is a functional dependency?**

<details>
<summary>Show answer</summary>
A functional dependency is a rule that says one attribute or set of attributes determines another attribute.
</details>

**Q2. What does the notation A -> B mean?**

<details>
<summary>Show answer</summary>
If two rows have the same A value, they must also have the same B value.
</details>

**Q3. Give an example of a functional dependency.**

<details>
<summary>Show answer</summary>
StudentID -> StudentName
</details>

**Q4. What is a trivial dependency?**

<details>
<summary>Show answer</summary>
A dependency where the dependent attribute is already part of the determinant, such as A -> A.
</details>

**Q5. Why are functional dependencies important in database design?**

<details>
<summary>Show answer</summary>
They show which attributes are logically tied together and help decide how to split tables during normalization.
</details>

**Q6. What is an update anomaly?**

<details>
<summary>Show answer</summary>
An update anomaly happens when changing one fact requires updating multiple rows to avoid inconsistency.
</details>

**Q7. What is an insert anomaly?**

<details>
<summary>Show answer</summary>
An insert anomaly occurs when required information cannot be added without also inserting unrelated data.
</details>

**Q8. What is a delete anomaly?**

<details>
<summary>Show answer</summary>
A delete anomaly happens when removing one row unintentionally deletes other meaningful information.
</details>

---

## Quick review

- FD = one attribute determines another
- Dependencies guide keys and table design
- Normalization reduces duplication and anomalies
- Good design is based on dependency logic

