-- Hands-on practice: GROUP BY & HAVING

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    Region NVARCHAR(50) NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL
);

INSERT INTO Orders (OrderID, CustomerName, Region, TotalAmount)
VALUES
    (1, 'A', 'North', 200.00),
    (2, 'B', 'North', 400.00),
    (3, 'C', 'South', 150.00),
    (4, 'D', 'South', 500.00),
    (5, 'E', 'East', 600.00);

SELECT Region, COUNT(*) AS OrderCount, SUM(TotalAmount) AS TotalRevenue
FROM Orders
GROUP BY Region
HAVING SUM(TotalAmount) > 500;
