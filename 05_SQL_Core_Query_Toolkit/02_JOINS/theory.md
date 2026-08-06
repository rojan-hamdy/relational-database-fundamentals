# JOINs (Inner, Outer, Cross, Self)

## Overview
A join is used to combine rows from two or more tables based on a related column. This is one of the most important concepts in relational database design and query writing.

---

## 1. Why Joins Matter

Data is normally split across tables to reduce redundancy and improve structure. For example:

- Student table stores student details
- Department table stores department names
- A relationship connects the two using `DepartmentID`

Joins let us work with that connected data as one result set.

---

## 2. INNER JOIN

Returns rows that match in both tables.

```sql
SELECT s.StudentName, d.DepartmentName
FROM dbo.Student AS s
INNER JOIN dbo.Department AS d
    ON s.DepartmentID = d.DepartmentID;
```

This is the most common join type.

---

## 3. LEFT JOIN

Returns all rows from the left table and matching rows from the right table.

```sql
SELECT s.StudentName, d.DepartmentName
FROM dbo.Student AS s
LEFT JOIN dbo.Department AS d
    ON s.DepartmentID = d.DepartmentID;
```

If a student has no matching department, the department value is `NULL`.

---

## 4. RIGHT JOIN

Returns all rows from the right table and matching rows from the left table.

```sql
SELECT s.StudentName, d.DepartmentName
FROM dbo.Student AS s
RIGHT JOIN dbo.Department AS d
    ON s.DepartmentID = d.DepartmentID;
```

---

## 5. FULL OUTER JOIN

Returns all rows from both tables, whether they match or not.

```sql
SELECT s.StudentName, d.DepartmentName
FROM dbo.Student AS s
FULL OUTER JOIN dbo.Department AS d
    ON s.DepartmentID = d.DepartmentID;
```

---

## 6. CROSS JOIN

Returns all combinations of rows from both tables.

```sql
SELECT s.StudentName, d.DepartmentName
FROM dbo.Student AS s
CROSS JOIN dbo.Department AS d;
```

> ⚠️ Use this carefully; result sets can grow very quickly.

---

## 7. Example Setup

```sql
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    DepartmentID INT
);
```

```sql
INSERT INTO Department (DepartmentID, DepartmentName)
VALUES (10, 'Computer Science'),
       (20, 'Mathematics');

INSERT INTO Student (StudentID, StudentName, DepartmentID)
VALUES (1, 'Alice', 10),
       (2, 'Bob', 20),
       (3, 'Charlie', 30);
```

```sql
SELECT s.StudentName, d.DepartmentName
FROM Student AS s
LEFT JOIN Department AS d
    ON s.DepartmentID = d.DepartmentID;
```

---

## 8. Key Takeaways

- `INNER JOIN`: only matching rows
- `LEFT JOIN`: all left rows, matched right ones if available
- `RIGHT JOIN`: all right rows
- `FULL OUTER JOIN`: all rows from both sides
- `CROSS JOIN`: Cartesian product

> 💡 **Core idea**
> Joins allow the database to combine related data across different tables while respecting the keys that connect them.

---

> 🔗 **See also**
> - [../01_SELECT_WHERE_ORDER_BY/theory.md](../01_SELECT_WHERE_ORDER_BY/theory.md)
> - [../syntax_cheatsheet.md](../syntax_cheatsheet.md)
