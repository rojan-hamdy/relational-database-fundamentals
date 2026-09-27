-- Hands-on Practice: Referential Integrity Actions in PostgreSQL (CASCADE, RESTRICT, SET NULL, NO ACTION)
-- Purpose: observe how parent key changes affect child table records in PostgreSQL

DROP TABLE IF EXISTS OrderHeader;
DROP TABLE IF EXISTS Customer;

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);

CREATE TABLE OrderHeader (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    TotalAmount NUMERIC(10,2) NOT NULL,
    CONSTRAINT FK_OrderHeader_Customer FOREIGN KEY (CustomerID)
        REFERENCES Customer(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Customer (CustomerID, CustomerName)
VALUES (1, 'Sara'), (2, 'Ali');

INSERT INTO OrderHeader (OrderID, CustomerID, TotalAmount)
VALUES (1001, 1, 150.00), (1002, 2, 300.00);

-- Test ON DELETE CASCADE
DELETE FROM Customer WHERE CustomerID = 1;
-- Related child rows in OrderHeader are automatically removed.

SELECT * FROM OrderHeader;

-- Test ON DELETE RESTRICT
ALTER TABLE OrderHeader DROP CONSTRAINT FK_OrderHeader_Customer;

ALTER TABLE OrderHeader ADD CONSTRAINT FK_OrderHeader_Customer_Restrict
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
    ON DELETE RESTRICT;

-- Attempting to delete Customer 2 will be blocked immediately by PostgreSQL:
-- DELETE FROM Customer WHERE CustomerID = 2; -- ERROR: update or delete on table "customer" violates foreign key constraint
