-- Hands-on practice: Referential Integrity Actions (Cascade, Restrict, Set Null)

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL
);

CREATE TABLE OrderHeader (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
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
-- The related order row is removed automatically because of ON DELETE CASCADE.
