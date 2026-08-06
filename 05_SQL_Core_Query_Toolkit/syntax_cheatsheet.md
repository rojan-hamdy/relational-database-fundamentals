# 🧾 SQL Syntax Cheat Sheet (Core Toolkit)

> Purpose: one-page quick reference for core T-SQL querying, structure, set operations, subqueries, and table manipulation.

---

## 1. SELECT, TOP, CASE & IIF
```sql
SELECT TOP (5) WITH TIES 
    StudentID, 
    StudentName, 
    IIF(Score >= 60, 'Pass', 'Fail') AS Status,
    CASE 
        WHEN Score >= 90 THEN 'A'
        WHEN Score >= 80 THEN 'B'
        ELSE 'C'
    END AS Grade
FROM dbo.Student
WHERE StudentName LIKE 'A%'
ORDER BY Score DESC;
```

---

## 2. Logical Query Processing Order
```text
1. FROM ──► 2. ON ──► 3. JOIN ──► 4. WHERE ──► 5. GROUP BY ──►
6. HAVING ──► 7. SELECT ──► 8. DISTINCT ──► 9. ORDER BY ──► 10. TOP / OFFSET
```

---

## 3. JOIN Syntax
```sql
SELECT s.StudentName, d.DepartmentName
FROM dbo.Student AS s
INNER JOIN dbo.Department AS d
    ON s.DepartmentID = d.DepartmentID;
```

---

## 4. CREATE, SCHEMA & IDENTITY
```sql
-- Schema creation
CREATE SCHEMA sales AUTHORIZATION dbo;

-- Table with IDENTITY and Constraints
CREATE TABLE sales.Customer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE
);

-- Identity Management & Inspection
SET IDENTITY_INSERT sales.Customer ON;
DBCC CHECKIDENT ('sales.Customer', RESEED, 100);
SELECT SCOPE_IDENTITY() AS NewID;
```

---

## 5. INSERT, SELECT INTO & TRUNCATE
```sql
-- Insert literals
INSERT INTO sales.Customer (CustomerName) VALUES ('Alice');

-- Insert from Query
INSERT INTO sales.CustomerArchive (CustomerID, CustomerName)
SELECT CustomerID, CustomerName FROM sales.Customer;

-- Create Table on the fly
SELECT CustomerID, CustomerName INTO #TempCustomer FROM sales.Customer;

-- Fast Page Deallocation (Clear Table & Reset Identity)
TRUNCATE TABLE sales.CustomerStaging;
```

---

## 6. SET OPERATORS (UNION, INTERSECT, EXCEPT)
```sql
-- Combine & deduplicate
SELECT City FROM Customer
UNION
SELECT City FROM Supplier;

-- Fast combine (preserve duplicates)
SELECT City FROM Customer
UNION ALL
SELECT City FROM Supplier;

-- Shared rows only
SELECT City FROM Customer
INTERSECT
SELECT City FROM Supplier;

-- Rows in Customer NOT in Supplier
SELECT City FROM Customer
EXCEPT
SELECT City FROM Supplier;
```

---

## 7. SUBQUERIES (ALL, ANY, EXISTS)
```sql
-- Scalar subquery
SELECT Name FROM Employee WHERE Salary > (SELECT AVG(Salary) FROM Employee);

-- ANY / SOME (Greater than minimum)
SELECT Name FROM Employee WHERE Salary > ANY (SELECT Salary FROM Employee WHERE Dept = 10);

-- ALL (Greater than maximum)
SELECT Name FROM Employee WHERE Salary > ALL (SELECT Salary FROM Employee WHERE Dept = 10);

-- EXISTS
SELECT DeptName FROM Department d WHERE EXISTS (SELECT 1 FROM Employee e WHERE e.Dept = d.Dept);
```

---

> 🔗 **See also**
> - [01_SELECT_WHERE_ORDER_BY/theory.md](01_SELECT_WHERE_ORDER_BY/theory.md)
> - [02_JOINS/theory.md](02_JOINS/theory.md)
> - [03_CREATE_ALTER_DROP/theory.md](03_CREATE_ALTER_DROP/theory.md)
> - [04_INSERT_UPDATE_DELETE_MERGE/theory.md](04_INSERT_UPDATE_DELETE_MERGE/theory.md)
> - [05_Set_Operators/theory.md](05_Set_Operators/theory.md)
> - [06_Subqueries/theory.md](06_Subqueries/theory.md)
