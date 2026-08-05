# Self-Test — Denormalization Tradeoffs

**Q1. What is denormalization?**

<details>
<summary>Show answer</summary>
Denormalization is the intentional reintroduction of redundancy to improve read performance or simplify reporting.
</details>

**Q2. Why do analytics systems often denormalize data?**

<details>
<summary>Show answer</summary>
To reduce join cost and speed up common reporting queries.
</details>

**Q3. What is a benefit of denormalization?**

<details>
<summary>Show answer</summary>
Faster query performance for read-heavy workloads.
</details>

**Q4. What is a risk of denormalization?**

<details>
<summary>Show answer</summary>
Duplicate data can create update anomalies and increase inconsistency risk.
</details>

**Q5. When is normalization preferred over denormalization?**

<details>
<summary>Show answer</summary>
When the workload is write-heavy, consistency and integrity are more important than speed.
</details>

**Q6. What type of system is often denormalized on purpose?**

<details>
<summary>Show answer</summary>
Data warehouse and reporting systems.
</details>

---

## Quick revision

- Normalization = integrity and lower redundancy
- Denormalization = speed and simplified reads
- OLTP often prefers normalized designs
- OLAP often uses denormalized reporting structures
