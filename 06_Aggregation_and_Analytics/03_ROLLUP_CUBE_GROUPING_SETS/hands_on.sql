-- Hands-on practice: ROLLUP, CUBE, GROUPING SETS

CREATE TABLE Sales (
    Region NVARCHAR(50) NOT NULL,
    Product NVARCHAR(50) NOT NULL,
    Revenue DECIMAL(12,2) NOT NULL
);

INSERT INTO Sales (Region, Product, Revenue)
VALUES
    ('North', 'Laptop', 5000),
    ('North', 'Phone', 3000),
    ('South', 'Laptop', 4500),
    ('South', 'Phone', 2500);

SELECT Region, Product, SUM(Revenue) AS TotalRevenue
FROM Sales
GROUP BY ROLLUP (Region, Product);

SELECT Region, Product, SUM(Revenue) AS TotalRevenue
FROM Sales
GROUP BY CUBE (Region, Product);
