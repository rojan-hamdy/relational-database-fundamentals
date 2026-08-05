-- Hands-on practice: The Relational Data Model
-- Purpose: model entities, keys, and constraints in relational form

USE master;
GO

CREATE DATABASE RelationalModelDemo;
GO

USE RelationalModelDemo;
GO

-- 1) Create parent table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100) DEFAULT 'Main Campus'
);
GO

-- 2) Create child table with a foreign key and constraints
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Age INT CHECK (Age BETWEEN 0 AND 120),
    Email VARCHAR(100) UNIQUE,
    DepartmentID INT,
    CONSTRAINT fk_student_department
        FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);
GO

-- 3) Insert valid rows
INSERT INTO Departments (DepartmentID, DepartmentName, Location)
VALUES
    (1, 'Computer Science', 'Building A'),
    (2, 'Mathematics', 'Building B');
GO

INSERT INTO Students (StudentID, FirstName, LastName, Age, Email, DepartmentID)
VALUES
    (101, 'Alice', 'Johnson', 20, 'alice@example.com', 1),
    (102, 'Bob', 'Smith', 22, 'bob@example.com', 2);
GO

-- 4) Query with a join to see the relationship
SELECT s.StudentID, s.FirstName, s.LastName, d.DepartmentName
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID;
GO

-- 5) Show a constraint violation example (uncomment to test)
-- INSERT INTO Students (StudentID, FirstName, LastName, Age, Email, DepartmentID)
-- VALUES (103, 'Charlie', 'Brown', -5, 'charlie@example.com', 1);

-- 6) Self-check on referential integrity
-- INSERT INTO Students (StudentID, FirstName, LastName, Age, Email, DepartmentID)
-- VALUES (104, 'Dana', 'White', 25, 'dana@example.com', 99);
-- This fails because DepartmentID 99 does not exist in Departments.

-- 7) Cleanup
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Departments;
DROP DATABASE IF EXISTS RelationalModelDemo;
GO

-- Reflection:
-- The relational model organizes data in tables with keys and constraints.
-- It allows relationships between entities to stay valid and consistent.

