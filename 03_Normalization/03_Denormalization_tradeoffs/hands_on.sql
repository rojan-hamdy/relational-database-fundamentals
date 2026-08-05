-- Hands-on practice: Denormalization Tradeoffs
-- Goal: compare normalized and read-optimized designs

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    CategoryID INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL
);

CREATE TABLE SalesFact (
    SaleID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    ProductName NVARCHAR(100) NOT NULL,
    CategoryName NVARCHAR(50) NOT NULL,
    SaleDate DATE NOT NULL,
    Quantity INT NOT NULL,
    TotalAmount DECIMAL(12,2) NOT NULL
);

-- Denormalized tables are easier for reporting but may duplicate data.
-- A normalized design is cleaner for writes and consistency.
