-- Hands-on practice: PK, FK, Unique, Check, Default Constraints

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(100) NOT NULL UNIQUE,
    Budget DECIMAL(12,2) NOT NULL DEFAULT 0
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,
    Salary DECIMAL(12,2) NOT NULL CHECK (Salary >= 0),
    HireDate DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Employee_Department FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);

INSERT INTO Department (DepartmentID, DepartmentName, Budget)
VALUES (1, 'HR', 120000.00), (2, 'IT', 200000.00);

INSERT INTO Employee (EmployeeID, FirstName, LastName, DepartmentID, Salary)
VALUES (1, 'Nadia', 'Hassan', 1, 60000.00),
       (2, 'Omar', 'Salem', 2, 82000.00);
