# The Relational Data Model

> Status: ✅ Built as the relational design foundation lesson.

## Overview
The relational data model is the foundation of modern database design. It organizes data into tables, where each table represents a relation and each row represents a record.

This model is based on mathematical set theory and is strongly aligned with SQL. It gives us a clean way to describe entities, attributes, relationships, and constraints.

---

## 1. Core Relational Concepts

### 1.1 Relation
A relation is a table with rows and columns.

- Each row = tuple
- Each column = attribute
- Table name = relation name

### 1.2 Attribute
An attribute is a data field such as StudentID, FirstName, or Age.

### 1.3 Tuple
A tuple is one complete row in a table.

### 1.4 Domain
A domain is the set of valid values for an attribute.

Example:
- Age domain: integers between 0 and 120
- Email domain: valid textual values following email format

---

## 2. Tables and Keys

### 2.1 Primary Key
A primary key uniquely identifies each row in a table.

Example:
```sql
StudentID INT PRIMARY KEY
```

### 2.2 Candidate Key
A candidate key is any attribute or combination of attributes that could serve as the primary key.

### 2.3 Foreign Key
A foreign key is an attribute in one table that references the primary key in another table.

Example:
```sql
DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID)
```

### 2.4 Composite Key
A composite key is a key made of multiple columns together.

Example:
```sql
PRIMARY KEY (StudentID, CourseID)
```

---

## 3. Entity Integrity and Referential Integrity

> 💡 **Entity Integrity**
> Every row in a table must have a unique identifier, and the primary key cannot be null.

> 💡 **Referential Integrity**
> A foreign key value must either match a valid primary key value or be null if allowed.

These rules protect logical consistency in the database.

> ⚠️ **Common Mistake**
> Allowing a foreign key to point to a non-existent row breaks referential integrity and creates orphan records.

---

## 4. Relational Constraints

Constraints are rules that protect data quality and relationships.

### 4.1 NOT NULL
Prevents nulls for a required column.

```sql
FirstName VARCHAR(50) NOT NULL
```

### 4.2 UNIQUE
Ensures no duplicate values in a column or column group.

```sql
Email VARCHAR(100) UNIQUE
```

### 4.3 CHECK
Ensures values satisfy a condition.

```sql
Age INT CHECK (Age >= 0)
```

### 4.4 DEFAULT
Assigns a default value when no explicit value is supplied.

```sql
Status VARCHAR(20) DEFAULT 'Active'
```

### 4.5 FOREIGN KEY
Ensures that relationships between tables are valid.

---

## 5. Relational Database Design Principles

A relational database is designed around these principles:

- each entity becomes a table,
- each attribute becomes a column,
- each relationship becomes a foreign key,
- each row is unique,
- every value belongs to a valid domain.

This allows information to be stored consistently and queried using SQL in a structured way.

---

## 6. Relationship Types

### One-to-One
One row in table A matches one row in table B.

### One-to-Many
One row in table A matches multiple rows in table B.

Example:
- One department has many students.

### Many-to-Many
Many rows in one table relate to many rows in another table.

This is usually resolved with a junction table.

Example:
- Students can enroll in many courses.
- Courses can have many students.

---

## 7. Example Relational Model

```text
Department
- DepartmentID (PK)
- DepartmentName
- Location

Student
- StudentID (PK)
- FirstName
- LastName
- DepartmentID (FK -> Department.DepartmentID)
- Age
```

This is a classic one-to-many relationship:

- one department has many students
- each student belongs to one department

---

## 8. Relational Algebra Ideas

Relational databases are built on relational algebra concepts such as:

- SELECT: choose rows
- PROJECT: choose columns
- JOIN: combine related tables
- UNION: combine rows from compatible tables
- DIFFERENCE: return rows present in one table but not another

These ideas map directly to SQL operations.

---

## 9. SSMS: Wizard/GUI View

### Create a table with constraints in SSMS
1. Open SSMS.
2. Connect to a database.
3. Expand the database.
4. Right-click Tables.
5. Choose New > Table.
6. Enter column names and data types.
7. Set the primary key.
8. Add foreign keys and check constraints.
9. Save the table.

This GUI action generates the relational definition behind the scenes.

---

## 10. Equivalent T-SQL Examples

```sql
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentID INT,
    Age INT CHECK (Age >= 0),
    Email VARCHAR(100) UNIQUE,
    CONSTRAINT fk_students_department
        FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);
```

```sql
INSERT INTO Departments (DepartmentID, DepartmentName, Location)
VALUES (1, 'Computer Science', 'Building A');

INSERT INTO Students (StudentID, FirstName, LastName, DepartmentID, Age, Email)
VALUES (101, 'Alice', 'Johnson', 1, 20, 'alice@example.com');

SELECT s.StudentID, s.FirstName, s.LastName, d.DepartmentName
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID;
```

---

## 11. Exam-Friendly Summary

- A relation is a table.
- A tuple is a row.
- An attribute is a column.
- A primary key uniquely identifies a row.
- A foreign key links rows across tables.
- Constraints preserve data quality and integrity.
- The relational model supports logical relationships using tables and keys.

> 💡 **Core idea**
> The relational model organizes data in tables with clear keys and constraints, which makes it consistent, queryable, and scalable.

---

> 🔗 **See also**
> - [../02_Database_System_Architecture/theory.md](../02_Database_System_Architecture/theory.md)
> - [../../04_Constraints_and_Integrity/PK_FK_Unique_Check_Default/theory.md](../../04_Constraints_and_Integrity/PK_FK_Unique_Check_Default/theory.md)
> - [../../00_Roadmap_and_StyleGuide/roadmap.md](../../00_Roadmap_and_StyleGuide/roadmap.md)
