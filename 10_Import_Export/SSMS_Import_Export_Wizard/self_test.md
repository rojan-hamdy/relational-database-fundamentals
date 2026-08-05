# Self-Test — Import/Export via SSMS Wizard

> Status: ✅ Ready for practice.

**Q1. What is the SSMS Import and Export Wizard used for?**

<details>
<summary>Show answer</summary>
It helps move data between SQL Server and other sources such as flat files, Excel, or other database systems.
</details>

**Q2. Where do you normally open the wizard in SSMS?**

<details>
<summary>Show answer</summary>
Right-click a database → Tasks → Import Data or Export Data.
</details>

**Q3. Why is mapping important in the wizard?**

<details>
<summary>Show answer</summary>
Because source columns must match the correct destination columns and data types.
</details>

**Q4. When is the wizard especially useful?**

<details>
<summary>Show answer</summary>
For quick, guided data transfer tasks and proofs of concept.
</details>

**Q5. Why are scripts still valuable even when the wizard exists?**

<details>
<summary>Show answer</summary>
Scripts are better for repeatability, automation, and versioning.
</details>

**Q6. What are the two most important validation checks before running the wizard?**

<details>
<summary>Show answer</summary>
Check source/destination column mapping and ensure data types and file format are compatible.
</details>

---

## Quick revision

- Wizard = GUI-based motion of data
- Script = repeatable migration logic
- Validate mapping and format before running
- Use wizard for quick tasks and scripts for production workflows
