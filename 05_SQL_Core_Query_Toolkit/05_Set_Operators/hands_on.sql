-- Hands-on Practice: Set Operators (UNION, UNION ALL, INTERSECT, EXCEPT)

-- 1. Setup Staging Tables
CREATE TABLE dbo.OnlineCustomer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50)
);

CREATE TABLE dbo.RetailCustomer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50)
);

INSERT INTO dbo.OnlineCustomer VALUES
(1, 'Alice Smith', 'Cairo'),
(2, 'Bob Jones', 'Alexandria'),
(3, 'Charlie Brown', 'Giza');

INSERT INTO dbo.RetailCustomer VALUES
(10, 'Bob Jones', 'Alexandria'),
(20, 'David Miller', 'Cairo'),
(30, 'Eva Green', 'Luxor');

-- 2. Practice UNION (Distinct Cities across both customer channels)
SELECT City FROM dbo.OnlineCustomer
UNION
SELECT City FROM dbo.RetailCustomer;

-- 3. Practice UNION ALL (All Customer names preserving duplicates)
SELECT CustomerName, City, 'Online' AS Channel FROM dbo.OnlineCustomer
UNION ALL
SELECT CustomerName, City, 'Retail' AS Channel FROM dbo.RetailCustomer
ORDER BY CustomerName;

-- 4. Practice INTERSECT (Cities present in BOTH Online and Retail channels)
SELECT City FROM dbo.OnlineCustomer
INTERSECT
SELECT City FROM dbo.RetailCustomer;

-- 5. Practice EXCEPT (Cities with Online customers but NO Retail customers)
SELECT City FROM dbo.OnlineCustomer
EXCEPT
SELECT City FROM dbo.RetailCustomer;
