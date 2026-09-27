# 🧾 PostgreSQL SQL Syntax Cheat Sheet (Core Toolkit)

> Purpose: one-page quick reference for core PostgreSQL querying, structure, set operations, subqueries, and table manipulation.

---

## 1. SELECT, LIMIT, CASE & Pattern Matching
```sql
SELECT 
    StudentID, 
    StudentName, 
    CASE WHEN Score >= 60 THEN 'Pass' ELSE 'Fail' END AS Status,
    CASE 
        WHEN Score >= 90 THEN 'A'
        WHEN Score >= 80 THEN 'B'
        ELSE 'C'
    END AS Grade
FROM public.Student
WHERE StudentName ILIKE 'A%'
ORDER BY Score DESC
FETCH FIRST 5 ROWS WITH TIES;
```

---

## 2. Logical Query Processing Order
```text
1. FROM ──► 2. ON ──► 3. JOIN ──► 4. WHERE ──► 5. GROUP BY ──►
6. HAVING ──► 7. SELECT ──► 8. DISTINCT ──► 9. ORDER BY ──► 10. LIMIT / OFFSET
```

---

## 3. JOIN Syntax
```sql
SELECT s.StudentName, d.DepartmentName
FROM public.Student AS s
INNER JOIN public.Department AS d
    ON s.DepartmentID = d.DepartmentID;
```

---

## 4. CREATE, SCHEMA & IDENTITY / SERIAL
```sql
-- Schema creation
CREATE SCHEMA sales;

-- Table with GENERATED ALWAYS AS IDENTITY and Constraints
CREATE TABLE sales.Customer (
    CustomerID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE
);

-- Alternative auto-increment: SERIAL data type
CREATE TABLE sales.Product (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL
);

-- Sequence Inspection in PostgreSQL
SELECT pg_get_serial_sequence('sales.product', 'productid');
SELECT currval('sales.product_productid_seq');
```

---

## 5. INSERT, CREATE TABLE AS SELECT & TRUNCATE
```sql
-- Insert literals
INSERT INTO sales.Customer (CustomerName) VALUES ('Alice');

-- Insert from Query
INSERT INTO sales.CustomerArchive (CustomerID, CustomerName)
SELECT CustomerID, CustomerName FROM sales.Customer;

-- Create Table on the fly (PostgreSQL equivalent of SELECT INTO)
CREATE TEMP TABLE TempCustomer AS 
SELECT CustomerID, CustomerName FROM sales.Customer;

-- Fast Table Truncate (Transactional in PostgreSQL)
TRUNCATE TABLE sales.CustomerStaging RESTART IDENTITY;
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

