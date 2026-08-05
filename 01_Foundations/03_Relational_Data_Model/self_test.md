# Self-Test — The Relational Data Model

> Status: ✅ Ready for practice.

**Q1. What is a relation in the relational model?**

<details>
<summary>Show answer</summary>
A relation is a table containing rows and columns.
</details>

**Q2. What is a tuple?**

<details>
<summary>Show answer</summary>
A tuple is a single row in a table.
</details>

**Q3. What is a primary key?**

<details>
<summary>Show answer</summary>
A primary key uniquely identifies each row in a table and cannot be null.
</details>

**Q4. What is a foreign key?**

<details>
<summary>Show answer</summary>
A foreign key is a column or set of columns in one table that references the primary key of another table.
</details>

**Q5. What is entity integrity?**

<details>
<summary>Show answer</summary>
Entity integrity means every row has a unique identifier and the primary key is not null.
</details>

**Q6. What is referential integrity?**

<details>
<summary>Show answer</summary>
Referential integrity ensures that foreign key values match valid values in the referenced table, or are null if allowed.
</details>

**Q7. What does the UNIQUE constraint do?**

<details>
<summary>Show answer</summary>
It ensures values in a column or set of columns are not duplicated.
</details>

**Q8. Why do we use CHECK constraints?**

<details>
<summary>Show answer</summary>
To enforce valid business rules, such as Age >= 0 or Salary > 0.
</details>

**Q9. What is a one-to-many relationship?**

<details>
<summary>Show answer</summary>
One record in one table relates to multiple records in another table.
</details>

**Q10. How is a many-to-many relationship usually solved in relational design?**

<details>
<summary>Show answer</summary>
By creating a junction table that breaks the many-to-many relationship into two one-to-many relationships.
</details>

---

## Quick revision

- Relation = table
- Tuple = row
- Attribute = column
- Primary key = unique identifier
- Foreign key = link to another table
- Constraints protect validity and integrity
- Relational model organizes data clearly and consistently

