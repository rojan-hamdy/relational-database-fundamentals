# SELECT, WHERE, ORDER BY

## Overview
The most common SQL statement is `SELECT`. It retrieves data from one or more tables. The `WHERE` clause limits the rows returned, and `ORDER BY` sorts the output.

A standard SQL query usually follows this structure:

```sql
SELECT column_list
FROM table_name
WHERE condition
ORDER BY column_name;
```

---

## 1. SELECT

```sql
SELECT StudentID, StudentName
FROM dbo.Student;
```

This returns only the specified columns.

To show every column:

```sql
SELECT *
FROM dbo.Student;
```

> ⚠️ `SELECT *` is convenient for quick exploration, but in real systems it can be inefficient and may return unnecessary data.

---

## 2. WHERE

`WHERE` filters rows and keeps only those that satisfy a condition.

```sql
SELECT StudentID, StudentName, Age
FROM dbo.Student
WHERE Age >= 20;
```

Common conditions:

```sql
WHERE Age > 18
WHERE StudentName = 'Alice'
WHERE City IN ('Cairo', 'Alexandria')
WHERE Age BETWEEN 18 AND 25
WHERE StudentName LIKE 'A%'
```

Examples:

```sql
SELECT *
FROM dbo.Student
WHERE StudentName LIKE 'A%';

SELECT *
FROM dbo.Student
WHERE DepartmentID = 10;
```

---

## 3. ORDER BY

`ORDER BY` sorts the result set.

```sql
SELECT StudentID, StudentName
FROM dbo.Student
ORDER BY StudentName ASC;
```

Descending order:

```sql
SELECT StudentID, StudentName
FROM dbo.Student
ORDER BY StudentName DESC;
```

You can also sort by multiple columns:

```sql
SELECT StudentID, StudentName, Age
FROM dbo.Student
ORDER BY Age DESC, StudentName ASC;
```

---

## 4. Putting It Together

```sql
SELECT StudentID, StudentName, Age
FROM dbo.Student
WHERE Age >= 18
ORDER BY Age DESC, StudentName ASC;
```

This is one of the most common SQL patterns used in reporting and data retrieval.

---

## 5. Example Table

```sql
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    Age INT,
    DepartmentID INT
);
```

```sql
INSERT INTO Student (StudentID, StudentName, Age, DepartmentID)
VALUES (1, 'Alice', 22, 10),
       (2, 'Bob', 19, 20),
       (3, 'Charlie', 24, 10),
       (4, 'Dana', 18, 30);
```

```sql
SELECT StudentName, Age
FROM Student
WHERE Age >= 20
ORDER BY Age DESC;
```

---

## 6. Key Takeaways

- `SELECT` chooses which columns to retrieve
- `WHERE` filters rows by condition
- `ORDER BY` sorts the final results
- The query flow is usually: `SELECT` → `FROM` → `WHERE` → `ORDER BY`

> 💡 **Core idea**
> Data retrieval in SQL is a combination of choosing columns, narrowing rows, and sorting the output for readability.

---

> 🔗 **See also**
> - [../02_JOINS/theory.md](../02_JOINS/theory.md)
> - [../syntax_cheatsheet.md](../syntax_cheatsheet.md)
