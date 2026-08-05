-- Hands-on practice: Database System Concepts and Architecture
-- Purpose: understand database structure, DBMS responsibilities, and SQL Server basics

USE master;
GO

-- 1) Create a database to explore architecture concepts
CREATE DATABASE SchoolDB;
GO

USE SchoolDB;
GO

-- 2) Create tables to represent a reasonable schema
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);
GO

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentID INT,
    Age INT CHECK (Age >= 0),
    Email VARCHAR(100) UNIQUE,
    CONSTRAINT fk_students_department
        FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
GO

-- 3) Insert data and test retrieval
INSERT INTO Departments (DepartmentID, DepartmentName, Location)
VALUES
    (1, 'Computer Science', 'Building A'),
    (2, 'Mathematics', 'Building B');
GO

INSERT INTO Students (StudentID, FirstName, LastName, DepartmentID, Age, Email)
VALUES
    (101, 'Alice', 'Johnson', 1, 20, 'alice@example.com'),
    (102, 'Bob', 'Smith', 2, 22, 'bob@example.com');
GO

SELECT s.StudentID, s.FirstName, s.LastName, d.DepartmentName
FROM Students s
INNER JOIN Departments d ON s.DepartmentID = d.DepartmentID;
GO

-- 4) Example of a view: external/user-specific data layer
CREATE VIEW StudentSummary AS
SELECT s.StudentID, s.FirstName, s.LastName, d.DepartmentName
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID;
GO

SELECT *
FROM StudentSummary;
GO

-- 5) Transaction example to illustrate DBMS control
BEGIN TRANSACTION;

UPDATE Students
SET Age = 23
WHERE StudentID = 101;

COMMIT;
GO

-- 6) Backup example (will create a file on disk if path is valid)
-- BACKUP DATABASE SchoolDB
-- TO DISK = 'C:\SQLBackups\SchoolDB.bak';

-- 7) Cleanup
DROP VIEW IF EXISTS StudentSummary;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Departments;
DROP DATABASE IF EXISTS SchoolDB;
GO

-- Reflection:
-- DBMS manages storage, security, transactions, recovery, and querying.
-- The architecture separates the external view from the physical storage.

