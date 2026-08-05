-- Hands-on practice: JOINs (Inner, Outer, Cross, Self)

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(100) NOT NULL
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    EmployeeName NVARCHAR(100) NOT NULL,
    DepartmentID INT NULL,
    ManagerID INT NULL,
    CONSTRAINT FK_Employee_Department FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);

INSERT INTO Department (DepartmentID, DepartmentName)
VALUES (1, 'Sales'), (2, 'HR'), (3, 'Support');

INSERT INTO Employee (EmployeeID, EmployeeName, DepartmentID, ManagerID)
VALUES (1, 'Amina', 1, NULL), (2, 'Bilal', 1, 1), (3, 'Nora', NULL, 1);

SELECT e.EmployeeName, d.DepartmentName
FROM Employee e
INNER JOIN Department d ON e.DepartmentID = d.DepartmentID;

SELECT e.EmployeeName, m.EmployeeName AS ManagerName
FROM Employee e
LEFT JOIN Employee m ON e.ManagerID = m.EmployeeID;

SELECT d.DepartmentName, e.EmployeeName
FROM Department d
CROSS JOIN Employee e;
