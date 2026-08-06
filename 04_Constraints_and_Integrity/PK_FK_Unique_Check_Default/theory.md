# PK, FK, Unique, Check, Default Constraints

## Overview
Database constraints enforce rules on stored data so that values remain valid, consistent, and aligned with business rules.

These constraints are part of the relational database model and are used to protect data quality.

---

## 1. Primary Key (PK)

A primary key uniquely identifies each row in a table.

```sql
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100)
);
```

A primary key:
- must be unique,
- cannot be null,
- usually identifies a single row.

---

## 2. Foreign Key (FK)

A foreign key references the primary key of another table.

```sql
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
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

This ensures a student belongs to a valid department.

---

## 3. Unique Constraint

A unique constraint prevents duplicate values in a column or a group of columns.

```sql
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Email VARCHAR(100) UNIQUE
);
```

---

## 4. Check Constraint

A check constraint enforces a logical condition.

```sql
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    Price DECIMAL(10,2) CHECK (Price > 0),
    Stock INT CHECK (Stock >= 0)
);
```

---

## 5. Default Constraint

A default value is assigned when the user does not provide one explicitly.

```sql
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    City VARCHAR(100) DEFAULT 'Cairo',
    IsActive BIT DEFAULT 1
);
```

```sql
INSERT INTO Customer (CustomerID)
VALUES (1);
```

The default city will be `Cairo` if not specified.

---

## 6. Why constraints matter

Constraints help avoid:
- duplicate records,
- missing or invalid values,
- broken relationships,
- data consistency problems.

---

## 7. Example combined design

```sql
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL,
    Age INT CHECK (Age BETWEEN 0 AND 120),
    City VARCHAR(100) DEFAULT 'Cairo',
    CONSTRAINT FK_Student_Department
        FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);
```

---

## 8. Summary

- PK: identifies each row uniquely
- FK: ties one table to another
- UNIQUE: prevents duplicate values
- CHECK: enforces valid conditions
- DEFAULT: supplies a value when none is given

> 💡 **Core idea**
> Constraints turn business rules into enforceable database rules.

---

> 🔗 **See also**
> - [../Referential_Integrity_Actions/theory.md](../Referential_Integrity_Actions/theory.md)
> - [../../01_Foundations/03_Relational_Data_Model/theory.md](../../01_Foundations/03_Relational_Data_Model/theory.md)
