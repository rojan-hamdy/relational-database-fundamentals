-- Hands-on practice: INSERT, UPDATE, DELETE, MERGE

CREATE TABLE ProductStage (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL
);

INSERT INTO ProductStage (ProductID, ProductName, UnitPrice)
VALUES (1, 'Laptop', 1200.00), (2, 'Mouse', 25.00), (3, 'Keyboard', 45.00);

INSERT INTO Product (ProductID, ProductName, UnitPrice)
VALUES (1, 'Laptop', 1050.00), (2, 'Mouse', 30.00);

UPDATE Product
SET UnitPrice = 1100.00
WHERE ProductID = 1;

DELETE FROM Product
WHERE ProductID = 2;

MERGE Product AS target
USING ProductStage AS source
ON target.ProductID = source.ProductID
WHEN MATCHED THEN
    UPDATE SET
        target.ProductName = source.ProductName,
        target.UnitPrice = source.UnitPrice
WHEN NOT MATCHED THEN
    INSERT (ProductID, ProductName, UnitPrice)
    VALUES (source.ProductID, source.ProductName, source.UnitPrice);
