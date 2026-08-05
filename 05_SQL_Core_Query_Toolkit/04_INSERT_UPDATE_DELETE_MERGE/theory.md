# INSERT, UPDATE, DELETE, MERGE

## Overview
These commands change the data inside existing tables. They belong to DML and are among the most frequently used SQL operations in database applications.

---

## 1. INSERT

Use `INSERT` to add new rows.

```sql
INSERT INTO Student (StudentID, StudentName, Age)
VALUES (1, 'Alice', 21);
```

Insert multiple rows:

```sql
INSERT INTO Student (StudentID, StudentName, Age)
VALUES (2, 'Bob', 22),
       (3, 'Charlie', 24);
```

---

## 2. UPDATE

Use `UPDATE` to modify existing rows.

```sql
UPDATE Student
SET Age = 23
WHERE StudentID = 1;
```

Update multiple columns:

```sql
UPDATE Student
SET Age = 25,
    StudentName = 'Alice Johnson'
WHERE StudentID = 1;
```

---

## 3. DELETE

Use `DELETE` to remove rows.

```sql
DELETE FROM Student
WHERE StudentID = 3;
```

Delete all rows:

```sql
DELETE FROM Student;
```

> ⚠️ Use `WHERE` carefully; without it, all rows may be removed.

---

## 4. MERGE

Use `MERGE` to combine insert, update, and delete logic in a single statement.

```sql
MERGE INTO StudentTarget AS target
USING StudentSource AS source
    ON target.StudentID = source.StudentID
WHEN MATCHED THEN
    UPDATE SET
        target.StudentName = source.StudentName,
        target.Age = source.Age
WHEN NOT MATCHED BY TARGET THEN
    INSERT (StudentID, StudentName, Age)
    VALUES (source.StudentID, source.StudentName, source.Age)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
```

This is especially useful when synchronizing staging tables with production tables.

---

## 5. Example Workflow

```sql
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    Age INT
);

INSERT INTO Student (StudentID, StudentName, Age)
VALUES (1, 'Alice', 20), (2, 'Bob', 22);

UPDATE Student
SET Age = 21
WHERE StudentID = 1;

DELETE FROM Student
WHERE StudentID = 2;
```

---

## 6. Key Takeaways

- `INSERT`: add new rows
- `UPDATE`: change existing rows
- `DELETE`: remove rows
- `MERGE`: synchronize tables in one operation

> 💡 **Core idea**
> DML commands manipulate the actual records in the database, while DDL commands define the structure that contains those records.

---

> 🔗 **See also**
> - [../03_CREATE_ALTER_DROP/theory.md](../03_CREATE_ALTER_DROP/theory.md)
> - [../syntax_cheatsheet.md](../syntax_cheatsheet.md)
