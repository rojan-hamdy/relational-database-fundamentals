-- Hands-on practice: SSMS Database Configuration

CREATE DATABASE DemoConfigDB;
GO

USE DemoConfigDB;
GO

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    EmployeeName NVARCHAR(100) NOT NULL,
    Department NVARCHAR(50) NOT NULL
);

INSERT INTO Employee (EmployeeID, EmployeeName, Department)
VALUES (1, 'Nabil', 'IT'), (2, 'Huda', 'Finance');

SELECT * FROM Employee;
