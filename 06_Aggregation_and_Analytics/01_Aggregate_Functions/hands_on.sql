-- Hands-on practice: Aggregate Functions

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    Region NVARCHAR(50) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL
);

INSERT INTO Sales (SaleID, Region, Amount)
VALUES
    (1, 'North', 1500.00),
    (2, 'South', 2200.00),
    (3, 'North', 1800.00),
    (4, 'East', 1100.00);

SELECT COUNT(*) AS TotalSalesRows,
       SUM(Amount) AS TotalSales,
       AVG(Amount) AS AvgSale,
       MIN(Amount) AS LowestSale,
       MAX(Amount) AS HighestSale
FROM Sales;
