-- Hands-on practice: Database System Concepts and Architecture
-- Purpose: understand database structure, DBMS responsibilities, and PostgreSQL basics
--
-- Notes on running this script:
--   - Steps 1 and 7's DROP DATABASE cannot run while you are connected to SchoolDB
--     itself (PostgreSQL will not let you drop the database you're currently in).
--   - Run section 1 while connected to the default 'postgres' database.
--   - Then connect to schooldb (\c schooldb in psql, or click it in pgAdmin) before
--     running sections 2-6.
--   - Reconnect back to 'postgres' (\c postgres) before running the DROP DATABASE
--     line in section 7.

-- 1) Create a database to explore architecture concepts
-- (run this while connected to the 'postgres' database)
CREATE DATABASE schooldb;

-- Connect to the new database:
--   in psql:    \c schooldb
--   in pgAdmin: click on the database in the Browser panel

-- 2) Create tables to represent a reasonable schema
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);

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

-- 3) Insert data and test retrieval
INSERT INTO Departments (DepartmentID, DepartmentName, Location)
VALUES
    (1, 'Computer Science', 'Building A'),
    (2, 'Mathematics', 'Building B');

INSERT INTO Students (StudentID, FirstName, LastName, DepartmentID, Age, Email)
VALUES
    (101, 'Alice', 'Johnson', 1, 20, 'alice@example.com'),
    (102, 'Bob', 'Smith', 2, 22, 'bob@example.com');

SELECT s.StudentID, s.FirstName, s.LastName, d.DepartmentName
FROM Students s
INNER JOIN Departments d ON s.DepartmentID = d.DepartmentID;

-- 4) Example of a view: external/user-specific data layer
CREATE VIEW StudentSummary AS
SELECT s.StudentID, s.FirstName, s.LastName, d.DepartmentName
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID;

SELECT *
FROM StudentSummary;

-- 5) Transaction example to illustrate DBMS control
BEGIN;

UPDATE Students
SET Age = 23
WHERE StudentID = 101;

COMMIT;

-- 6) Backup example
-- PostgreSQL backups are taken from the command line with pg_dump, not a SQL
-- statement, or via pgAdmin's "Backup..." option on the database:
--   pg_dump -U postgres -F c -d schooldb -f /path/to/SchoolDB.backup

-- 7) Cleanup
DROP VIEW IF EXISTS StudentSummary;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Departments;

-- Reconnect to 'postgres' first (\c postgres), since you cannot drop the
-- database you are currently connected to:
DROP DATABASE IF EXISTS schooldb;

-- Reflection:
-- DBMS manages storage, security, transactions, recovery, and querying.
-- The architecture separates the external view from the physical storage.
