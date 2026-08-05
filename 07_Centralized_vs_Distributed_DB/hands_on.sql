-- Hands-on practice: Centralized vs Distributed Databases

-- Centralized design example
CREATE TABLE CentralOrder (
    OrderID INT PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL
);

INSERT INTO CentralOrder (OrderID, CustomerName, Amount)
VALUES (1, 'Ali', 125.00), (2, 'Sara', 275.00);

SELECT * FROM CentralOrder;

-- Conceptual distributed design note:
-- data can be partitioned by region or business unit across different servers or shards.
