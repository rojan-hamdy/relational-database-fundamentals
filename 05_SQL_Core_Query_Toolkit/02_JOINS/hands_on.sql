-- ================================================================
-- Hands-on practice: JOINs (Inner, Outer, Cross, Self)
-- ================================================================

-- ----------------------------------------------------------------
-- 1. Setup
-- ----------------------------------------------------------------
CREATE TABLE Department (
    DepartmentID   INT PRIMARY KEY,
    DepartmentName NVARCHAR(100) NOT NULL
);

CREATE TABLE Employee (
    EmployeeID   INT PRIMARY KEY,
    EmployeeName NVARCHAR(100) NOT NULL,
    DepartmentID INT NULL,
    ManagerID    INT NULL,
    CONSTRAINT FK_Employee_Department FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);

INSERT INTO Department (DepartmentID, DepartmentName)
VALUES (1, 'Sales'), (2, 'HR'), (3, 'Support');

INSERT INTO Employee (EmployeeID, EmployeeName, DepartmentID, ManagerID)
VALUES (1, 'Amina', 1,    NULL),   -- top of the chain, no manager
       (2, 'Bilal', 1,    1),      -- managed by Amina
       (3, 'Nora',  NULL, 1);      -- no department, managed by Amina

-- Note on purpose: HR and Support have no employees at all, and
-- Nora has no DepartmentID -- this is what makes the difference
-- between join types visible below.


-- ----------------------------------------------------------------
-- 2. INNER JOIN -- only employees that have a matching department
-- ----------------------------------------------------------------
SELECT e.EmployeeName, d.DepartmentName
FROM Employee e
INNER JOIN Department d ON e.DepartmentID = d.DepartmentID;

-- Expected:
-- EmployeeName | DepartmentName
-- Amina        | Sales
-- Bilal        | Sales
-- (Nora is missing -- her DepartmentID is NULL, so she has no match)


-- ----------------------------------------------------------------
-- 3. LEFT JOIN -- all employees, department if they have one
-- ----------------------------------------------------------------
SELECT e.EmployeeName, d.DepartmentName
FROM Employee e
LEFT JOIN Department d ON e.DepartmentID = d.DepartmentID;

-- Expected:
-- EmployeeName | DepartmentName
-- Amina        | Sales
-- Bilal        | Sales
-- Nora         | NULL


-- ----------------------------------------------------------------
-- 4. RIGHT JOIN -- all departments, employees if they have any
-- ----------------------------------------------------------------
SELECT d.DepartmentName, e.EmployeeName
FROM Employee e
RIGHT JOIN Department d ON e.DepartmentID = d.DepartmentID;

-- Expected:
-- DepartmentName | EmployeeName
-- Sales          | Amina
-- Sales          | Bilal
-- HR             | NULL      (no employees in HR)
-- Support        | NULL      (no employees in Support)


-- ----------------------------------------------------------------
-- 5. FULL OUTER JOIN -- everything from both sides
-- ----------------------------------------------------------------
SELECT e.EmployeeName, d.DepartmentName
FROM Employee e
FULL OUTER JOIN Department d ON e.DepartmentID = d.DepartmentID;

-- Expected:
-- EmployeeName | DepartmentName
-- Amina        | Sales
-- Bilal        | Sales
-- Nora         | NULL
-- NULL         | HR
-- NULL         | Support


-- ----------------------------------------------------------------
-- 6. CROSS JOIN -- every employee x every department
-- ----------------------------------------------------------------
SELECT d.DepartmentName, e.EmployeeName
FROM Department d
CROSS JOIN Employee e;

-- Expected: 3 departments x 3 employees = 9 rows total
-- (Sales/Amina, Sales/Bilal, Sales/Nora, HR/Amina, HR/Bilal, HR/Nora,
--  Support/Amina, Support/Bilal, Support/Nora)


-- ----------------------------------------------------------------
-- 7. SELF JOIN -- employee to their manager (same table, two aliases)
-- ----------------------------------------------------------------
SELECT e.EmployeeName, m.EmployeeName AS ManagerName
FROM Employee e
LEFT JOIN Employee m ON e.ManagerID = m.EmployeeID;

-- Expected:
-- EmployeeName | ManagerName
-- Amina        | NULL     (no manager)
-- Bilal        | Amina
-- Nora         | Amina

-- LEFT JOIN is used here (not INNER) so Amina still appears even
-- though she has no manager -- an INNER JOIN would drop her.


-- ----------------------------------------------------------------
-- 8. The WHERE-on-outer-join trap
-- ----------------------------------------------------------------
-- Intention: "all departments, and their employees if any exist"
-- filtered to only show departments with more than one letter --
-- but see what happens when a right-side filter is written wrong:

SELECT d.DepartmentName, e.EmployeeName
FROM Employee e
RIGHT JOIN Department d ON e.DepartmentID = d.DepartmentID
WHERE e.EmployeeName IS NOT NULL;   -- ⚠️ silently turns this back into an INNER JOIN

-- Compare row count to section 4 above -- HR and Support disappear
-- again, because WHERE runs after the join and drops any row where
-- e.EmployeeName is NULL. If you need that condition and still want
-- to keep HR/Support, it belongs in the ON clause instead.


-- ================================================================
-- 9. Practice exercises -- write these yourself before checking notes
-- ================================================================

-- Exercise 1
-- Add a new department 'Marketing' with no employees, and a new
-- employee 'Yusuf' with DepartmentID pointing to a department that
-- doesn't exist (skip the foreign key or disable it temporarily).
-- Re-run the INNER JOIN, LEFT JOIN, and FULL OUTER JOIN queries above
-- and predict the row counts before running them.

-- Exercise 2
-- Write a query that returns only departments with NO employees
-- (hint: LEFT JOIN Department to Employee, then filter WHERE the
-- employee side IS NULL).

-- Exercise 3
-- Extend the self-join in section 7 one level further: return each
-- employee, their manager's name, and their manager's manager's name
-- (hint: join Employee to itself a second time).

-- Exercise 4
-- Rewrite the query in section 8 so the intended filter (only show
-- departments where an employee exists) is applied correctly in the
-- ON clause instead of WHERE, while still keeping HR and Support
-- visible with NULL employee names.

-- Exercise 5
-- Using CROSS JOIN, generate every possible pairing of Department
-- and a literal list of 3 shift names ('Morning', 'Evening', 'Night')
-- to build a shift-assignment planning grid (hint: CROSS JOIN against
-- a VALUES table instead of another real table).
