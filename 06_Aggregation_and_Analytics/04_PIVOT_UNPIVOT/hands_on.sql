-- Hands-on practice: PIVOT & UNPIVOT

CREATE TABLE SalesByMonth (
    MonthName NVARCHAR(20),
    Region NVARCHAR(20),
    Revenue DECIMAL(10,2)
);

INSERT INTO SalesByMonth (MonthName, Region, Revenue)
VALUES
    ('Jan', 'North', 1000),
    ('Jan', 'South', 950),
    ('Feb', 'North', 1200),
    ('Feb', 'South', 1100);

SELECT MonthName, North, South
FROM SalesByMonth
PIVOT (SUM(Revenue) FOR Region IN ([North], [South])) AS p;

SELECT MonthName, Region, Revenue
FROM (
    SELECT MonthName, North, South
    FROM SalesByMonth
    PIVOT (SUM(Revenue) FOR Region IN ([North], [South])) AS p
) src
UNPIVOT (Revenue FOR Region IN (North, South)) AS u;
