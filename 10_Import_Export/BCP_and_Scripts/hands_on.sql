-- Hands-on practice: Import/Export via BCP & Scripts

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    City NVARCHAR(50) NOT NULL
);

INSERT INTO Customer (CustomerID, CustomerName, City)
VALUES (1, 'Maya', 'Dubai'), (2, 'Samir', 'Riyadh');

SELECT * FROM Customer;

-- Example BCP commands for export/import:
-- bcp "SELECT * FROM dbo.Customer" queryout "C:\temp\customer_data.csv" -S localhost -d SampleDB -U sa -P "YourPassword" -c -t ,
-- bcp dbo.Customer in "C:\temp\customer_data.csv" -S localhost -d SampleDB -U sa -P "YourPassword" -c -t ,
