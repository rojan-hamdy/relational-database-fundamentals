-- Hands-on Practice: PostgreSQL Syntax for INSERT, UPDATE, DELETE, TRUNCATE, MERGE & CREATE TABLE AS SELECT

-- 1. Setup Staging and Target Tables
CREATE TABLE ProductStage (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    UnitPrice NUMERIC(10,2) NOT NULL
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    UnitPrice NUMERIC(10,2) NOT NULL
);

INSERT INTO ProductStage (ProductID, ProductName, UnitPrice)
VALUES (1, 'Laptop', 1200.00), (2, 'Mouse', 25.00), (3, 'Keyboard', 45.00);

INSERT INTO Product (ProductID, ProductName, UnitPrice)
VALUES (1, 'Laptop', 1050.00), (2, 'Mouse', 30.00);

-- 2. Practice INSERT INTO ... SELECT
CREATE TABLE CheapProducts (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    UnitPrice NUMERIC(10,2)
);

INSERT INTO CheapProducts (ProductID, ProductName, UnitPrice)
SELECT ProductID, ProductName, UnitPrice
FROM ProductStage
WHERE UnitPrice < 50.00;

-- 3. Practice CREATE TABLE AS SELECT (PostgreSQL equivalent of T-SQL SELECT INTO)
-- Create permanent table on the fly
CREATE TABLE ProductBackup AS
SELECT ProductID, ProductName, UnitPrice
FROM ProductStage;

-- Create temporary table on the fly
CREATE TEMP TABLE TempProducts AS
SELECT ProductID, ProductName
FROM ProductStage
WHERE UnitPrice > 1000.00;

-- 4. Practice TRUNCATE TABLE Rollback Demo
BEGIN TRANSACTION;
    -- Truncate staging table
    TRUNCATE TABLE ProductStage;
    
    -- Verify table is empty
    SELECT COUNT(*) AS RowsAfterTruncate FROM ProductStage; -- 0
    
-- Rollback transaction to restore data
ROLLBACK TRANSACTION;

-- Verify data is restored!
SELECT COUNT(*) AS RowsAfterRollback FROM ProductStage; -- 3

-- 5. Practice MERGE / UPSERT (PostgreSQL 15+ MERGE)
MERGE INTO Product AS target
USING ProductStage AS source
    ON target.ProductID = source.ProductID
WHEN MATCHED THEN
    UPDATE SET
        ProductName = source.ProductName,
        UnitPrice = source.UnitPrice
WHEN NOT MATCHED THEN
    INSERT (ProductID, ProductName, UnitPrice)
    VALUES (source.ProductID, source.ProductName, source.UnitPrice);

-- Alternative: PostgreSQL Native UPSERT (ON CONFLICT)
INSERT INTO Product (ProductID, ProductName, UnitPrice)
SELECT ProductID, ProductName, UnitPrice FROM ProductStage
ON CONFLICT (ProductID) 
DO UPDATE SET
    ProductName = EXCLUDED.ProductName,
    UnitPrice = EXCLUDED.UnitPrice;
