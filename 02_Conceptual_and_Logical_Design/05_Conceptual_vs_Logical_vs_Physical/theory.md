# Conceptual vs Logical vs Physical Design

> Status: ✅ Built as the design-level transition lesson.

## Overview
A database is often designed in stages. Each stage answers a different question:

- Conceptual design: What are the entities and relationships?
- Logical design: How do we represent them in a normalized relational structure?
- Physical design: How do we store and optimize the data on disk and in the DBMS?

These three layers are not the same thing, and understanding the difference is essential for good database design.

---

## 1. Conceptual Design

> 💡 **Definition**
> Conceptual design describes the business view of the data without worrying about implementation details.

### Focus
- business entities
- relationships between them
- attributes of interest
- business rules

### Typical artifacts
- ER diagrams
- EER diagrams
- entity lists
- relationship descriptions

### Example
A university might define entities like:
- Student
- Course
- Department
- Instructor

And relationships like:
- Student enrolls in Course
- Department offers Course
- Instructor teaches Course

---

## 2. Logical Design

> 💡 **Definition**
> Logical design transforms the conceptual model into a relational structure using tables, keys, constraints, and normalization rules.

### Focus
- tables
- columns
- primary keys
- foreign keys
- constraints
- normalization

### Example logical mapping
```text
Student(StudentID PK, FirstName, LastName, DepartmentID FK)
Course(CourseID PK, CourseName)
Enrollment(StudentID FK, CourseID FK)
```

This stage is implementation-aware but still independent of physical storage details.

---

## 3. Physical Design

> 💡 **Definition**
> Physical design decides how data is physically stored, indexed, partitioned, and optimized inside the database system.

### Focus
- storage files and filegroups
- indexes
- clustered vs nonclustered indexes
- partitioning
- performance optimization
- hardware and access paths

### Example physical concerns
- Should `StudentID` be clustered primary key?
- Should there be an index on `LastName`?
- Should the table be partitioned by date?

---

## 4. Comparison Table

| Design stage | Question answered | Typical output |
|---|---|---|
| Conceptual | What data do we need? | ER/EER diagram |
| Logical | How should the data be structured? | relational schema, keys, constraints |
| Physical | How will it be stored and optimized? | indexes, files, storage layout |

---

## 5. Why the Three Stages Matter

If design is done only at the conceptual level, the database may be logically unclear.

If design is done only at the logical level, performance and storage issues may be missed.

If design is done only physically, the business meaning can become distorted.

The best system design keeps these layers aligned.

---

## 6. Example of Interconnection

### Conceptual
A student enrolls in many courses.

### Logical
Create:
- `Student`
- `Course`
- `Enrollment` with composite primary key and foreign keys

### Physical
Create indexes on `CourseID`, `StudentID`, and maybe a clustered index on the primary key.

---

## 7. Image Path for Stored Visuals

If you want to add a custom conceptual-to-logical-to-physical diagram, save it here:

`images/05_design_levels.png`

Then reference it like this:

```markdown
![Conceptual, logical, physical model](images/05_design_levels.png)
```

You can also represent the three levels as a Mermaid diagram or a simple architecture flowchart.

---

## 8. SSMS and SQL Mapping

In SSMS, the visible implementation steps can be:

1. Create the database
2. Define tables and keys
3. Add constraints and relationships
4. Create indexes for performance
5. Review storage and file settings

This reflects the progression from logical design to physical tuning.

---

## 9. Equivalent T-SQL Example

```sql
CREATE DATABASE UniversityDB;
GO

USE UniversityDB;
GO

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentID INT,
    CONSTRAINT FK_Student_Department
        FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);

CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL
);

CREATE TABLE Enrollment (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    CONSTRAINT FK_Enrollment_Student
        FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID),
    CONSTRAINT FK_Enrollment_Course
        FOREIGN KEY (CourseID)
        REFERENCES Course(CourseID)
);

CREATE INDEX IX_Student_DepartmentID
ON Student (DepartmentID);
```

---

## 10. Exam-Friendly Summary

- Conceptual = business view
- Logical = relational structure
- Physical = storage and optimization
- Good databases align all three layers
- ER/EER outputs feed logical design, which feeds physical implementation

> 💡 **Core idea**
> Conceptual design explains the business model, logical design makes it relational, and physical design makes it efficient in the database engine.

---

> 🔗 **See also**
> - [../01_ER_Model/theory.md](../01_ER_Model/theory.md)
> - [../02_EER_Model/theory.md](../02_EER_Model/theory.md)
> - [../03_ER_to_Relational_Mapping/theory.md](../03_ER_to_Relational_Mapping/theory.md)
> - [../../00_Roadmap_and_StyleGuide/roadmap.md](../../00_Roadmap_and_StyleGuide/roadmap.md)
