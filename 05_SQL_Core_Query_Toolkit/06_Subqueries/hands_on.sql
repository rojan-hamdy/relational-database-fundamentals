-- Hands-on Practice: Subqueries (Scalar, Correlated, ALL, ANY/SOME)

-- 1. Setup Sample Tables
CREATE TABLE dbo.Employee (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10, 2)
);

INSERT INTO dbo.Employee VALUES
(1, 'Alice', 10, 6000),
(2, 'Bob', 10, 8000),
(3, 'Charlie', 20, 4500),
(4, 'David', 20, 9000),
(5, 'Eva', 30, 7500);

-- 2. Scalar Subquery Practice (Employees earning above overall average)
SELECT EmployeeName, Salary
FROM dbo.Employee
WHERE Salary > (SELECT AVG(Salary) FROM dbo.Employee);

-- 3. Correlated Subquery Practice (Employees earning above THEIR department average)
SELECT e.EmployeeName, e.DepartmentID, e.Salary
FROM dbo.Employee AS e
WHERE e.Salary > (
    SELECT AVG(d.Salary) 
    FROM dbo.Employee AS d 
    WHERE d.DepartmentID = e.DepartmentID
);

-- 4. ALL Operator Practice (Salary greater than ALL salaries in Dept 10 -> > 8000)
SELECT EmployeeName, Salary
FROM dbo.Employee
WHERE Salary > ALL (
    SELECT Salary 
    FROM dbo.Employee 
    WHERE DepartmentID = 10
);

-- 5. ANY / SOME Operator Practice (Salary greater than AT LEAST ONE salary in Dept 10 -> > 6000)
SELECT EmployeeName, Salary
FROM dbo.Employee
WHERE Salary > ANY (
    SELECT Salary 
    FROM dbo.Employee 
    WHERE DepartmentID = 10
);

-- 6. EXISTS Practice (Find departments that have employees earning > 7000)
SELECT DISTINCT DepartmentID
FROM dbo.Employee AS outer_emp
WHERE EXISTS (
    SELECT 1 
    FROM dbo.Employee AS inner_emp 
    WHERE inner_emp.DepartmentID = outer_emp.DepartmentID 
      AND inner_emp.Salary > 7000
);
