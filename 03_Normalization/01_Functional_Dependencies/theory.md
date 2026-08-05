# Functional Dependencies

## Overview
Normalization is the process of organizing a database so that it reduces redundancy, avoids anomalies, and preserves data integrity. It is tightly related to functional dependencies, because a dependency tells us which attributes are logically determined by others.

This lesson introduces the logic behind normalization and why it is essential in good database design.

---

## 1. What Is a Functional Dependency?

> 💡 **Definition**
> A functional dependency (FD) exists when one attribute or set of attributes determines another attribute.

Notation:

```text
A -> B
```

This means:

- if two rows have the same value of A,
- then they must also have the same value of B.

### Example
```text
StudentID -> StudentName
```

If a student ID is known, then the student name is uniquely determined.

---

## 2. Examples of Functional Dependencies

### Example 1
```text
StudentID -> StudentName, DepartmentID
```

### Example 2
```text
DepartmentID -> DepartmentName
```

### Example 3
```text
(StudentID, CourseID) -> Grade
```

This tells us that a given student and course determine the grade for that student in that course.

---

## 3. Trivial and Non-Trivial Dependencies

### Trivial dependency
A dependency is trivial if the dependent attribute is already part of the determinant.

Example:
```text
A -> A
```

or

```text
AB -> A
```

### Non-trivial dependency
A dependency is non-trivial if the dependent attribute is not part of the determinant.

Example:
```text
StudentID -> StudentName
```

---

## 4. Why Functional Dependencies Matter

Functional dependencies tell us:

- which attributes are linked,
- which fields are redundant,
- which tables should be split,
- which forms of normalization should be applied.

They help us decide whether a table is structured well or whether it stores repeating information in the wrong place.

---

## 5. Update, Insert, and Delete Anomalies

Poorly designed tables often have anomalies.

### Update anomaly
Changing one fact requires changing multiple rows.

### Insert anomaly
You cannot insert some data without also adding unrelated data.

### Delete anomaly
Deleting one row may unintentionally remove other important information.

---

## 6. Normalization Goals

Normalization aims to:

- reduce redundancy,
- remove anomalies,
- preserve logical consistency,
- improve data integrity,
- organize the schema in a cleaner way.

---

## 7. What Is Normalization?

Normalization is the process of organizing a table or database into progressively better forms.

The main target is to eliminate unnecessary duplication and ensure each attribute depends on the correct key.

Typically, we move from:

- 1NF
- 2NF
- 3NF
- BCNF

and beyond in advanced design.

---

## 8. Example of a Problematic Table

```text
Enrollment
(StudentID, StudentName, DepartmentID, DepartmentName, CourseID, CourseName, Grade)
```

This table has repeated data:

- student name repeats for many courses,
- department name repeats,
- course name repeats.

The functional dependencies may include:

```text
StudentID -> StudentName, DepartmentID
DepartmentID -> DepartmentName
CourseID -> CourseName
(StudentID, CourseID) -> Grade
```

This suggests the table should be split into smaller tables.

---

## 9. Functional Dependency and Key Relationship

A key is a set of attributes that uniquely identifies a row.

Example:

```text
(StudentID, CourseID) -> Grade
```

Here, `(StudentID, CourseID)` is the key of the enrollment record.

Functional dependencies are central to determining candidate keys and understanding whether a table is in a good normal form.

---

## 10. Diagram Illustration

If you have a normalization diagram or dependency chart, save it here:

`images/functional_dependencies_diagram.png`

Then use it in the file as:

```markdown
![Functional dependency diagram](images/functional_dependencies_diagram.png)
```

---

## 11. SSMS and T-SQL Mapping

In SSMS, normalization is not a wizard-driven task as such. Instead, it is a design process:

1. Identify entities and attributes.
2. Discover dependencies.
3. Define primary keys.
4. Split repeating or dependent data into separate tables.
5. Check constraints and referential integrity.

The equivalent SQL implementation is usually done by creating tables with sensible keys and foreign keys.

---

## 12. Equivalent T-SQL Example

```sql
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
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
    Grade VARCHAR(10),
    PRIMARY KEY (StudentID, CourseID),
    CONSTRAINT FK_Enrollment_Student
        FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID),
    CONSTRAINT FK_Enrollment_Course
        FOREIGN KEY (CourseID)
        REFERENCES Course(CourseID)
);
```

This design follows dependency-based thinking: a student belongs to a department, a course has a name, and a grade belongs to a student-course pair.

---

## 13. Exam-Friendly Summary

- Functional dependency = one attribute determines another
- `A -> B` means B depends on A
- FDs guide key selection and normalization
- Redundancy and anomalies appear when data is not normalized
- Normalization reduces duplication and improves data integrity

> 💡 **Core idea**
> Functional dependencies explain why certain data belongs together and why some tables should be split into smaller, cleaner structures.

---

> 🔗 **See also**
> - [../02_Normal_Forms_1NF_to_BCNF/theory.md](../02_Normal_Forms_1NF_to_BCNF/theory.md)
> - [../../02_Conceptual_and_Logical_Design/03_ER_to_Relational_Mapping/theory.md](../../02_Conceptual_and_Logical_Design/03_ER_to_Relational_Mapping/theory.md)
> - [../../00_Roadmap_and_StyleGuide/roadmap.md](../../00_Roadmap_and_StyleGuide/roadmap.md)
