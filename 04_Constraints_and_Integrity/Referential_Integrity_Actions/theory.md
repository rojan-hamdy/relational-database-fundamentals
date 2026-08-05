# Referential Integrity Actions (Cascade, Restrict, Set Null)

> Status: ✅ Built as the relationship-action lesson.

## Overview
Referential integrity ensures that a child record cannot point to a parent record that no longer exists. The database can respond to parent changes using specific actions.

---

## 1. Foreign key relationship

```sql
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    DepartmentID INT,
    CONSTRAINT FK_Student_Department
        FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);
```

---

## 2. ON DELETE and ON UPDATE

These clauses define the behavior when the parent row is deleted or updated.

### Common behaviors
- `NO ACTION` or `RESTRICT`: block change
- `CASCADE`: propagate to child records
- `SET NULL`: set child values to NULL
- `SET DEFAULT`: set child values to a default value

---

## 3. NO ACTION / RESTRICT

The database rejects the delete or update if related child rows remain.

```sql
CONSTRAINT FK_Student_Department
    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
```

---

## 4. CASCADE

If the parent is deleted or updated, the child rows follow automatically.

```sql
CONSTRAINT FK_Student_Department
    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
```

This is often used when parent and child records should remain synchronized.

---

## 5. SET NULL

Child values become `NULL` when the parent is changed.

```sql
CONSTRAINT FK_Student_Department
    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)
    ON DELETE SET NULL
    ON UPDATE SET NULL
```

This requires the child foreign key column to accept `NULL`.

---

## 6. SET DEFAULT

Child values become the default value.

```sql
CONSTRAINT FK_Student_Department
    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)
    ON DELETE SET DEFAULT
    ON UPDATE SET DEFAULT
```

---

## 7. Choosing the right action

Use `CASCADE` when deleting a department should delete its students.
Use `SET NULL` when the child relationship can be temporarily void.
Use `NO ACTION` when strict business rules should block deletion.

---

## 8. Summary

Referential integrity actions define how the database keeps relationships valid after parent changes.

> 💡 **Core idea**
> The action chosen protects data consistency while honoring business intent.

---

> 🔗 **See also**
> - [../PK_FK_Unique_Check_Default/theory.md](../PK_FK_Unique_Check_Default/theory.md)
> - [../../01_Foundations/03_Relational_Data_Model/theory.md](../../01_Foundations/03_Relational_Data_Model/theory.md)
