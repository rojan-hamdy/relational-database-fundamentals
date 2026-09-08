-- Hands-on Practice: PostgreSQL Referential Integrity Actions (Cascade, Restrict, Set Null, Set Default)

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

DELETE FROM Customer WHERE CustomerID = 1;
-- In PostgreSQL, related child rows in OrderHeader are automatically removed because of ON DELETE CASCADE.

-- PostgreSQL specific demo: Testing ON DELETE RESTRICT
ALTER TABLE OrderHeader DROP CONSTRAINT FK_OrderHeader_Customer;

ALTER TABLE OrderHeader ADD CONSTRAINT FK_OrderHeader_Customer_Restrict
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
    ON DELETE RESTRICT;

-- Attempting to delete Customer 2 will be blocked immediately in PostgreSQL:
-- DELETE FROM Customer WHERE CustomerID = 2; -- ERROR: update or delete on table "customer" violates foreign key constraint
