# GROUP BY & HAVING

## Overview
`GROUP BY` partitions rows into groups, and aggregate functions are then applied to each group. `HAVING` filters those grouped results after aggregation.

---

## 1. GROUP BY

```sql
SELECT DepartmentID, COUNT(*) AS NumberOfStudents
FROM dbo.Student
GROUP BY DepartmentID;
```

This groups students by department and counts how many appear in each group.

---

## 2. HAVING

`HAVING` filters result groups after aggregation.

```sql
SELECT DepartmentID, COUNT(*) AS NumberOfStudents
FROM dbo.Student
GROUP BY DepartmentID
HAVING COUNT(*) > 1;
```

This returns only departments with more than one student.

---

## 3. Example dataset

```sql
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    DepartmentID INT,
    Age INT
);

INSERT INTO Student (StudentID, StudentName, DepartmentID, Age)
VALUES (1, 'Alice', 10, 22),
       (2, 'Bob', 10, 25),
       (3, 'Charlie', 20, 19),
       (4, 'Dana', 30, 21);
```

```sql
SELECT DepartmentID, AVG(Age) AS AvgAge
FROM Student
GROUP BY DepartmentID;
```

```sql
SELECT DepartmentID, AVG(Age) AS AvgAge
FROM Student
GROUP BY DepartmentID
HAVING AVG(Age) >= 20;
```

---

## 4. Difference between WHERE and HAVING

- `WHERE` filters rows before grouping
- `HAVING` filters groups after aggregation

```sql
SELECT DepartmentID, COUNT(*) AS Total
FROM Student
WHERE Age >= 18
GROUP BY DepartmentID
HAVING COUNT(*) >= 2;
```

---

## 5. Key takeaways

- `GROUP BY` organizes rows into meaningful groups
- aggregate functions summarize those groups
- `HAVING` filters the grouped result set

> 💡 **Core idea**
> `GROUP BY` and `HAVING` are the standard way to answer questions like “How many students are in each department?” or “Which departments have more than 10 students?”

---

> 🔗 **See also**
> - [../01_Aggregate_Functions/theory.md](../01_Aggregate_Functions/theory.md)
> - [../03_ROLLUP_CUBE_GROUPING_SETS/theory.md](../03_ROLLUP_CUBE_GROUPING_SETS/theory.md)
