# 🧾 SQL Syntax Cheat Sheet (Core Toolkit)

> Purpose: one-page memory aid for the most important SQL statements in the toolkit.

## SELECT
```sql
SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column1 ASC;
```

## JOIN
```sql
SELECT s.col1, d.col2
FROM TableA AS s
INNER JOIN TableB AS d
    ON s.key = d.key;
```

## CREATE / ALTER / DROP
```sql
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100)
);

ALTER TABLE Student
ADD Age INT;

DROP TABLE Student;
```

## INSERT / UPDATE / DELETE
```sql
INSERT INTO Student (StudentID, StudentName, Age)
VALUES (1, 'Alice', 20);

UPDATE Student
SET Age = 21
WHERE StudentID = 1;

DELETE FROM Student
WHERE StudentID = 1;
```

## MERGE
```sql
MERGE INTO TargetTable AS target
USING SourceTable AS source
    ON target.ID = source.ID
WHEN MATCHED THEN
    UPDATE SET target.Name = source.Name
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ID, Name)
    VALUES (source.ID, source.Name)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
```

## Common Query Flow
```sql
SELECT columns
FROM tables
WHERE conditions
GROUP BY columns
HAVING conditions
ORDER BY columns;
```

> 🔗 **See also**
> - [01_SELECT_WHERE_ORDER_BY/theory.md](01_SELECT_WHERE_ORDER_BY/theory.md)
> - [02_JOINS/theory.md](02_JOINS/theory.md)
> - [03_CREATE_ALTER_DROP/theory.md](03_CREATE_ALTER_DROP/theory.md)
> - [04_INSERT_UPDATE_DELETE_MERGE/theory.md](04_INSERT_UPDATE_DELETE_MERGE/theory.md)
