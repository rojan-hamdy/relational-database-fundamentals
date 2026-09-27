# DDL, DML, DCL, TCL — Definitions & Function of Each


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
| DDL | Define or change database objects | CREATE, ALTER, DROP, TRUNCATE | Create a table or modify a column |
| DML | Manage data inside objects | INSERT, UPDATE, DELETE, SELECT, MERGE | Add a new customer or update an order |
| DCL | Control access and permissions | GRANT, REVOKE | Allow a user to read a table |
| TCL | Manage transactions | BEGIN, COMMIT, ROLLBACK, SAVEPOINT | Ensure a purchase is either fully saved or fully undone |

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
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT
);

ALTER TABLE students
ADD COLUMN email VARCHAR(100);

DROP TABLE students;
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
INSERT INTO students (student_id, first_name, last_name, age)
VALUES (1, 'Alice', 'Johnson', 20);

UPDATE students
SET age = 21
WHERE student_id = 1;

DELETE FROM students
WHERE student_id = 1;

SELECT *
FROM students;
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
GRANT SELECT, INSERT ON students TO app_user;
REVOKE INSERT ON students FROM app_user;
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
BEGIN; -- or START TRANSACTION;

UPDATE accounts
SET balance = balance - 100
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 100
WHERE account_id = 2;

COMMIT;
```

If something goes wrong:

```sql
BEGIN;

UPDATE accounts
SET balance = balance - 100
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 100
WHERE account_id = 2;

ROLLBACK;
```

### Important TCL concepts
- COMMIT: Save the transaction permanently.
- ROLLBACK: Undo the transaction.
- SAVE TRANSACTION: Save a checkpoint within a transaction to which you can later roll back (ROLLBACK TO savepoint_name).

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
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    total_amount NUMERIC(10,2)
);

GRANT SELECT, INSERT ON orders TO sales_user;

BEGIN;

INSERT INTO orders (order_id, customer_id, total_amount)
VALUES (1, 101, 500.00);

COMMIT;
```

---

## 7. pgAdmin 4: Wizard/GUI View

In pgAdmin 4 (the official administration client for PostgreSQL), you can manage these actions through the interface.

### DDL in pgAdmin
1. Open pgAdmin 4 and connect to your server.
2. Expand the target database.
3. Expand Schemas > public (or your target schema).
4. Right-click Tables and select Create > Table...
5. Enter the table name, navigate to the Columns tab to add columns and data types, then click Save.

This generates and executes the CREATE TABLE DDL query behind the scenes.

### DML in pgAdmin
1. Expand Schemas > public > Tables.
2. Right-click the table.
3. Choose View/Edit Data > All Rows (or First 100 Rows).
4. Insert, edit, or delete rows directly within the Data Grid.
5. Click the Save Data Changes button (or press F6).

This is the GUI equivalent of `INSERT`, `UPDATE`, and `DELETE`.

### DCL in pgAdmin
1. Expand Login/Group Roles under the server tree to view roles.
2. Right-click any table or database object in the Object Explorer and select Properties.
3. Navigate to the Privileges tab.
4. Select a role, assign or uncheck specific privileges (SELECT, INSERT, UPDATE, etc.), and click Save.
This is the GUI equivalent of `GRANT` and `REVOKE`.

### TCL in pgAdmin
Transactions are handled by writing SQL inside the Query Tool (BEGIN;, COMMIT;, ROLLBACK;) rather than through a dedicated GUI wizard, as transactional workflows rely on application code and execution logic.

---

## 8. Equivalent PostgreSQL Examples

```sql
-- DDL
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT
);

ALTER TABLE students
ADD COLUMN email VARCHAR(100);

DROP TABLE students;

-- DML
INSERT INTO students (student_id, first_name, last_name, age)
VALUES (1, 'Alice', 'Johnson', 20);

UPDATE students
SET age = 21
WHERE student_id = 1;

DELETE FROM students
WHERE student_id = 1;

SELECT *
FROM students;

-- DCL
GRANT SELECT, INSERT ON students TO app_user;
REVOKE INSERT ON students FROM app_user;

-- TCL
BEGIN;

INSERT INTO students (student_id, first_name, last_name, age)
VALUES (2, 'Bob', 'Smith', 22);

UPDATE students
SET age = 23
WHERE student_id = 2;

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
