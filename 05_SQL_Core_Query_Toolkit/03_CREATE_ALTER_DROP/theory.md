# CREATE, ALTER, DROP

> Status: ✅ Built as the schema-definition lesson.

## Overview
`CREATE`, `ALTER`, and `DROP` belong to the DDL group of SQL commands. They define and modify the structure of database objects such as tables, views, schemas, and databases.

---

## 1. CREATE

Use `CREATE` to build a new object.

```sql
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    Age INT
);
```

Create a view:

```sql
CREATE VIEW v_StudentSummary AS
SELECT StudentID, StudentName, Age
FROM dbo.Student;
```

Create a database:

```sql
CREATE DATABASE SchoolDB;
```

---

## 2. ALTER

Use `ALTER` to change an existing object.

```sql
ALTER TABLE Student
ADD Email VARCHAR(150);
```

You may also change a database setting:

```sql
ALTER DATABASE SchoolDB
SET RECOVERY SIMPLE;
```

---

## 3. DROP

Use `DROP` to remove an object permanently.

```sql
DROP TABLE Student;
```

```sql
DROP VIEW v_StudentSummary;
```

```sql
DROP DATABASE SchoolDB;
```

> ⚠️ `DROP` is destructive. Use it carefully, especially in production environments.

---

## 4. Why These Commands Matter

These commands define the database shell. Without them, there would be no tables, indexes, views, or schema structure.

They are part of the foundation of database modeling and administration.

---

## 5. Typical Workflow

```sql
CREATE DATABASE DemoDB;
GO

USE DemoDB;
GO

CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT
);
GO

ALTER TABLE Course
ADD DepartmentName VARCHAR(50);
GO

DROP TABLE Course;
GO
```

---

## 6. Key Takeaways

- `CREATE`: define a new object
- `ALTER`: modify an existing object
- `DROP`: remove an object
- These commands change structure, not data rows

> 💡 **Core idea**
> DDL commands are responsible for the database blueprint, while DML commands work with the actual data inside that blueprint.

---

> 🔗 **See also**
> - [../04_INSERT_UPDATE_DELETE_MERGE/theory.md](../04_INSERT_UPDATE_DELETE_MERGE/theory.md)
> - [../syntax_cheatsheet.md](../syntax_cheatsheet.md)
