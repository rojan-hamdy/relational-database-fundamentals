# NoSQL


## Overview
NoSQL refers to a broad family of database systems designed to handle data that does not fit naturally into the rigid relational model. These systems are often used when data is large, semi-structured, rapidly changing, or highly distributed.

NoSQL does not mean “no SQL” in the strict sense; it means “not only SQL.” Many systems support SQL-like query features, but they are designed around different data models and trade-offs.

---

## 1. Why NoSQL Exists

Relational databases work very well for structured, normalized data with strong integrity rules. However, some applications need:

- very high scalability,
- flexible schemas,
- unstructured or semi-structured data,
- fast writes at large volume,
- distributed data across many machines,
- low-latency access patterns.

This is where NoSQL systems become valuable.

---

## 2. Main NoSQL Data Models

### Document databases
Store data as documents, usually JSON-like structures.

Example:
```json
{
  "_id": "101",
  "name": "Alice",
  "department": "CS",
  "courses": ["DB", "AI"]
}
```

Examples:
- MongoDB
- CouchDB

### Key-value stores
Store pairs of keys and values.

Example:
```text
user:101 -> {name: "Alice", age: 21}
```

Examples:
- Redis
- DynamoDB

### Column-family stores
Store data in columns grouped by row families rather than traditional relational rows.

Examples:
- Cassandra
- HBase

### Graph databases
Store entities and relationships as nodes and edges.

Examples:
- Neo4j
- Amazon Neptune

---

## 3. Comparison with Relational Databases

| Feature | Relational DB | NoSQL |
|---|---|---|
| Schema | Fixed | Flexible or schema-less |
| Structure | Tables and rows | Documents, keys, columns, graphs |
| Transactions | Strong ACID | Often BASE, more flexible |
| Scaling | Vertical or moderate scaling | Horizontal scaling common |
| Best for | Structured data | Big data, flexible data, high scale |

---

## 4. ACID vs BASE

### ACID (relational)
- Atomicity
- Consistency
- Isolation
- Durability

Relational systems emphasize strong consistency and correctness.

### BASE (NoSQL)
- Basically Available
- Soft state
- Eventual consistency

NoSQL often favors availability and scalability over immediate consistency.

> 💡 **Important idea**
> NoSQL is not “better” in all cases. It is a different design trade-off. Relational systems are usually best when integrity and consistency are paramount.

---

## 5. Typical Use Cases for NoSQL

NoSQL is often used in:

- social networks,
- e-commerce catalogs,
- recommendation engines,
- IoT telemetry,
- event logging,
- content management,
- high-volume user activity tracking,
- distributed applications.

---

## 6. Schema Flexibility

A major difference is flexibility.

### Relational table
```sql
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT
);
```

### Document example
```json
{
  "studentId": 101,
  "name": "Alice",
  "age": 21,
  "interests": ["AI", "Databases"],
  "address": { "city": "Cairo", "country": "Egypt" }
}
```

This structure can evolve without redesigning the entire schema.

---

## 7. When to Choose NoSQL

Choose NoSQL when:

- the data is highly variable,
- you expect rapid growth,
- you need horizontal scaling,
- you are working with large datasets,
- the application prioritizes high throughput.

Choose relational SQL when:

- you need strong consistency,
- your data is highly structured,
- you depend on complex joins,
- integrity constraints are critical.

---

## 8. Diagram Illustration

If you have a NoSQL diagram or architecture image, place it here:

`images/nosql_architecture.png`

and reference it like this:

```markdown
![NoSQL architecture](images/nosql_architecture.png)
```

---

## 9. SSMS and SQL Mapping

NoSQL is not generally managed through SQL Server Management Studio in the same way as relational databases. Instead, the equivalent use is usually done from a NoSQL database client or command-line tool.

For SQL Server users, the comparison is mostly conceptual:

- relational: model with tables and foreign keys
- NoSQL: model with documents, keys, or graphs

---

## 10. Example SQL Server Comparison

```sql
-- Relational model
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT
);
```

Equivalent document model concept (JSON-like):

```json
{
  "studentId": 101,
  "name": "Alice",
  "age": 21,
  "courses": ["DB", "AI"]
}
```

---

## 11. Exam-Friendly Summary

- NoSQL = non-relational or “not only SQL” data systems
- Designed for flexibility, scale, and distributed access
- Common models: document, key-value, column-family, graph
- ACID vs BASE is the main trade-off
- Use relational databases for strongly structured and consistent systems
- Use NoSQL for flexible, high-scale, semi-structured workloads

> 💡 **Core idea**
> NoSQL is a different database paradigm built around scale, flexibility, and performance rather than relational normalization and strict consistency.

---

> 🔗 **See also**
> - [../01_Foundations/03_Relational_Data_Model/theory.md](../01_Foundations/03_Relational_Data_Model/theory.md)
> - [../03_Normalization/01_Functional_Dependencies/theory.md](../03_Normalization/01_Functional_Dependencies/theory.md)
> - [../00_Roadmap_and_StyleGuide/roadmap.md](../00_Roadmap_and_StyleGuide/roadmap.md)
