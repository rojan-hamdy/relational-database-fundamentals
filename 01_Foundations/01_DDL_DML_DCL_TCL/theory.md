# DDL, DML, DCL, TCL — Definitions & Function of Each

> Status: ✅ Built as the foundational lesson for the repo.

## Overview
SQL is not one single language with one purpose. It is divided into different command groups, each responsible for a different layer of database work.

The four most important groups are:

- DDL = Data Definition Language
- DML = Data Manipulation Language
- DCL = Data Control Language
- TCL = Transaction Control Language

These groups work together like a database lifecycle:

1. DDL defines the structure.
2. DML inserts, changes, and removes data.
3. DCL controls who can access or modify that structure.
4. TCL ensures data changes are committed or rolled back correctly.

---

## 1. Quick Comparison

| Category | Main purpose | Typical commands | Example use |
|---|---|---|---|
| DDL | Define or change database objects | CREATE, ALTER, DROP | Create a table or modify a column |
| DML | Manage data inside objects | INSERT, UPDATE, DELETE, SELECT, MERGE | Add a new customer or update an order |
| DCL | Control access and permissions | GRANT, REVOKE, DENY | Allow a user to read a table |
| TCL | Manage transactions | COMMIT, ROLLBACK, SAVE TRANSACTION | Ensure a purchase is either fully saved or fully undone |

---

## 2. DDL — Data Definition Language

> 💡 **Definition**
> DDL is used to define, change, or remove the structure of database objects such as tables, views, indexes, schemas, and databases.

### Function of DDL
DDL answers the question:

- What objects exist?
- What columns do they contain?
- What constraints apply?
- How is the structure organized?

### Common DDL Commands
```sql
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT
);

ALTER TABLE Students
ADD Email VARCHAR(100);

DROP TABLE Students;
```

### Why DDL matters
DDL is the foundation of database design. Without DDL, there would be no database structure, no tables, no constraints, and no defined relationships.

> ⚠️ **Common Mistake**
> DDL changes the schema, not the actual business data. If you change a table structure, you are changing the structure of the database, not the rows already stored in it.

---

## 3. DML — Data Manipulation Language

> 💡 **Definition**
> DML is used to manipulate the data stored inside database objects. It handles rows and records, not schema structure.

### Function of DML
DML answers the question:

- How do we add records?
- How do we update records?
- How do we delete records?
- How do we read records?

### Common DML Commands
```sql
INSERT INTO Students (StudentID, FirstName, LastName, Age)
VALUES (1, 'Alice', 'Johnson', 20);

UPDATE Students
SET Age = 21
WHERE StudentID = 1;

DELETE FROM Students
WHERE StudentID = 1;

SELECT *
FROM Students;
```

### DML is data-focused
DML works with rows, values, and conditions. It does not create tables or alter their schema; it works with the data already stored in them.

> 🧪 **Try it yourself**
> Create a table, insert a few rows, update one row, and then delete one row to see DML in action.

---

## 4. DCL — Data Control Language

> 💡 **Definition**
> DCL is used to control access to database objects and data. It defines which users or roles are allowed to do what.

### Function of DCL
DCL answers the question:

- Who can access the database?
- Who can read, insert, update, or delete?
- Who can manage database objects?

### Common DCL Commands
```sql
GRANT SELECT, INSERT ON Students TO AppUser;
REVOKE INSERT ON Students FROM AppUser;
```

### Typical DCL tasks
- Grant permissions to a user or role
- Revoke permissions
- Restrict access to sensitive data

> ⚠️ **Common Mistake**
> Granting too many permissions is a security issue. Least privilege is the safest design principle.

---

## 5. TCL — Transaction Control Language

> 💡 **Definition**
> TCL is used to manage transactions. A transaction is a logical unit of work that must succeed or fail as a complete unit.

### Function of TCL
TCL answers the question:

- Should the changes be saved permanently?
- Should the changes be canceled?
- Can we temporarily keep changes before deciding?

### Common TCL Commands
```sql
BEGIN TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 100
WHERE AccountID = 1;

UPDATE Accounts
SET Balance = Balance + 100
WHERE AccountID = 2;

COMMIT;
```

If something goes wrong:

```sql
BEGIN TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 100
WHERE AccountID = 1;

UPDATE Accounts
SET Balance = Balance + 100
WHERE AccountID = 2;

ROLLBACK;
```

### Important TCL concepts
- COMMIT: Save the transaction permanently.
- ROLLBACK: Undo the transaction.
- SAVE TRANSACTION: Save a checkpoint within a transaction.

> 💡 **Why this matters**
> Transactions protect data integrity. In banking, payroll, inventory, or order systems, you do not want partial updates.

---

## 6. Relationship Between DDL, DML, DCL, and TCL

These four categories work together in a normal database workflow:

```text
DDL creates structure
      ↓
DCL grants access
      ↓
DML inserts/updates/deletes data
      ↓
TCL ensures the work is committed or rolled back safely
```

Example workflow:

```sql
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    TotalAmount DECIMAL(10,2)
);

GRANT SELECT, INSERT ON Orders TO SalesUser;

INSERT INTO Orders (OrderID, CustomerID, TotalAmount)
VALUES (1, 101, 500.00);

COMMIT;
```

---

## 7. SSMS: Wizard/GUI View

In SQL Server Management Studio (SSMS), you can create and manage these commands through the GUI.

### DDL in SSMS
1. Open SSMS.
2. Connect to the SQL Server instance.
3. Expand the target database.
4. Right-click on Tables.
5. Select New > Table.
6. Add columns and data types.
7. Save the table.

This creates the table using DDL behind the scenes.

### DML in SSMS
1. Open a table in Object Explorer.
2. Right-click the table.
3. Choose Edit Top 200 Rows or Select Top 1000 Rows.
4. Insert, update, or delete rows from the grid.

This is the GUI equivalent of `INSERT`, `UPDATE`, and `DELETE`.

### DCL in SSMS
1. Expand Security.
2. Expand Logins or Users.
3. Set permissions on database objects or user roles.
4. Use the properties dialog to assign permissions.

This is the GUI equivalent of `GRANT` and `REVOKE`.

### TCL in SSMS
TCL is generally done through code rather than a direct wizard. In professional SQL work, transactions are typically written in T-SQL because they require logic and conditional checks.

---

## 8. Equivalent T-SQL Examples

```sql
-- DDL
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT
);

ALTER TABLE Students
ADD Email VARCHAR(100);

DROP TABLE Students;

-- DML
INSERT INTO Students (StudentID, FirstName, LastName, Age)
VALUES (1, 'Alice', 'Johnson', 20);

UPDATE Students
SET Age = 21
WHERE StudentID = 1;

DELETE FROM Students
WHERE StudentID = 1;

SELECT *
FROM Students;

-- DCL
GRANT SELECT, INSERT ON Students TO AppUser;
REVOKE INSERT ON Students FROM AppUser;

-- TCL
BEGIN TRANSACTION;

INSERT INTO Students (StudentID, FirstName, LastName, Age)
VALUES (2, 'Bob', 'Smith', 22);

UPDATE Students
SET Age = 23
WHERE StudentID = 2;

COMMIT;
```

---

## 9. Exam-Friendly Summary

- DDL = define schema
- DML = manipulate data
- DCL = secure access
- TCL = manage transactions

If you remember only one sentence:

> DDL builds the database structure, DML works with the data, DCL controls who can access it, and TCL controls whether changes are permanently saved.

---

> 🔗 **See also**
> - [../02_Database_System_Architecture/theory.md](../02_Database_System_Architecture/theory.md)
> - [../../05_SQL_Core_Query_Toolkit/syntax_cheatsheet.md](../../05_SQL_Core_Query_Toolkit/syntax_cheatsheet.md)
> - [../../00_Roadmap_and_StyleGuide/roadmap.md](../../00_Roadmap_and_StyleGuide/roadmap.md)
