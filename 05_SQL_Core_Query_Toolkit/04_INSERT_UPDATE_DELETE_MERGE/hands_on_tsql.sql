-- Hands-on Practice: T-SQL (SQL Server) Syntax for INSERT, UPDATE, DELETE, TRUNCATE, MERGE & SELECT INTO

-- 1. Setup Staging and Target Tables
CREATE TABLE dbo.ProductStage (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL
);

CREATE TABLE dbo.Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL
);

INSERT INTO dbo.ProductStage (ProductID, ProductName, UnitPrice)
VALUES (1, 'Laptop', 1200.00), (2, 'Mouse', 25.00), (3, 'Keyboard', 45.00);

INSERT INTO dbo.Product (ProductID, ProductName, UnitPrice)
VALUES (1, 'Laptop', 1050.00), (2, 'Mouse', 30.00);

-- 2. Practice INSERT INTO ... SELECT
CREATE TABLE dbo.CheapProducts (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    UnitPrice DECIMAL(10,2)
);

INSERT INTO dbo.CheapProducts (ProductID, ProductName, UnitPrice)
SELECT ProductID, ProductName, UnitPrice
FROM dbo.ProductStage
WHERE UnitPrice < 50.00;

-- 3. Practice SELECT INTO (Dynamic Table & Temporary Table)
-- Create permanent table on the fly
SELECT ProductID, ProductName, UnitPrice
INTO dbo.ProductBackup
FROM dbo.ProductStage;

-- Create local temporary table
SELECT ProductID, ProductName
INTO #TempProducts
FROM dbo.ProductStage
WHERE UnitPrice > 1000.00;

-- 4. Practice TRUNCATE TABLE Rollback Demo
BEGIN TRANSACTION;
    -- Truncate staging table
    TRUNCATE TABLE dbo.ProductStage;
    
    -- Verify table is empty
    SELECT COUNT(*) AS RowsAfterTruncate FROM dbo.ProductStage; -- 0
    
-- Rollback transaction to restore data
ROLLBACK TRANSACTION;

-- Verify data is restored!
SELECT COUNT(*) AS RowsAfterRollback FROM dbo.ProductStage; -- 3

-- 5. Practice MERGE (UPSERT)
MERGE INTO dbo.Product AS target
USING dbo.ProductStage AS source
    ON target.ProductID = source.ProductID
WHEN MATCHED THEN
    UPDATE SET
        target.ProductName = source.ProductName,
        target.UnitPrice = source.UnitPrice
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, UnitPrice)
    VALUES (source.ProductID, source.ProductName, source.UnitPrice);
