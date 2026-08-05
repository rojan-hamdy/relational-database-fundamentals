# Normal Forms (1NF to BCNF)

> Status: ✅ Built as the relational normalization progression lesson.

## Overview
Normalization is the process of organizing a database into a structured form to reduce data redundancy and improve integrity. It follows a sequence of normal forms, each imposing stronger rules.

The main goal is to ensure that each fact is stored in one logical place, with clear dependencies between attributes and keys.

---

## 1. Why normalization matters

Without normalization:
- the same data may be repeated,
- updates become inconsistent,
- inserts and deletes may create anomalies,
- reporting becomes harder to trust.

Normalization reduces these problems.

---

## 2. First Normal Form (1NF)

A table is in 1NF when:
- each column contains atomic values,
- each row is unique,
- no repeating groups are present.

### Example of non-1NF
```text
StudentID | StudentName | Courses
1         | Alice       | DB, SQL, AI
```

### 1NF version
```text
StudentID | StudentName | Course
1         | Alice       | DB
1         | Alice       | SQL
1         | Alice       | AI
```

```sql
CREATE TABLE StudentCourse (
    StudentID INT,
    StudentName VARCHAR(100),
    Course VARCHAR(50)
);
```

---

## 3. Second Normal Form (2NF)

A table is in 2NF when:
- it is already in 1NF,
- all non-key attributes depend on the whole primary key.

This mainly matters for tables with composite keys.

### Example
```text
OrderID | ProductID | ProductName | Qty
```

`ProductName` depends only on `ProductID`, not on the full key `(OrderID, ProductID)`. That is a partial dependency, which violates 2NF.

### 2NF solution
Split into:
- OrderItems
- Products

---

## 4. Third Normal Form (3NF)

A table is in 3NF when:
- it is in 2NF,
- no non-key attribute depends on another non-key attribute.

This removes transitive dependencies.

### Example
```text
EmployeeID | DepartmentID | DepartmentName
```

`DepartmentName` depends on `DepartmentID`, not directly on `EmployeeID`. That is a transitive dependency.

### 3NF solution
Split:
- Employees
- Departments

---

## 5. Boyce-Codd Normal Form (BCNF)

BCNF is stronger than 3NF.

A relation is in BCNF when every determinant is a candidate key.

In practice, BCNF is often used in systems with multiple overlapping dependencies.

---

## 6. Normalization in SQL terms

```sql
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100)
);

CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100)
);

CREATE TABLE StudentCourse (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
```

This design is more normalized than storing repeated course names in a single row.

---

## 7. Common anomalies prevented by normalization

- insertion anomaly
- update anomaly
- deletion anomaly

### Example
If a student’s department name is stored in multiple rows, updating it in one row but not another leads to inconsistency.

---

## 8. When not to over-normalize

Normalization is valuable, but extremely large systems may use some denormalization for performance. Data warehouses often do this on purpose to speed up analytics queries.

---

## 9. Summary

1NF: atomic values, no repeating groups
2NF: no partial dependency on composite keys
3NF: no transitive dependency
BCNF: stronger version of 3NF for determinant/key rules

> 💡 **Core idea**
> Normalization is about reducing redundancy and improving data integrity without creating unnecessary complexity.

---

> 🔗 **See also**
> - [../01_Functional_Dependencies/theory.md](../01_Functional_Dependencies/theory.md)
> - [../03_Denormalization_tradeoffs/theory.md](../03_Denormalization_tradeoffs/theory.md)
