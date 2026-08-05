-- Hands-on practice: DDL, DML, DCL, TCL
-- Purpose: understand how schema, data, permissions, and transactions work together

USE master;
GO

-- 1) DDL: create a table and modify its structure
CREATE DATABASE DemoDB;
GO

USE DemoDB;
GO

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Age INT,
    Email VARCHAR(100)
);
GO

ALTER TABLE Students
ADD DateOfBirth DATE;
GO

-- 2) DML: insert, read, update, and delete data
INSERT INTO Students (StudentID, FirstName, LastName, Age, Email, DateOfBirth)
VALUES
    (1, 'Alice', 'Johnson', 20, 'alice@example.com', '2005-01-15'),
    (2, 'Bob', 'Smith', 22, 'bob@example.com', '2003-03-10');
GO

SELECT *
FROM Students;
GO

UPDATE Students
SET Age = 21
WHERE StudentID = 1;
GO

DELETE FROM Students
WHERE StudentID = 2;
GO

-- 3) DCL: grant and revoke permissions
CREATE LOGIN DemoUser WITH PASSWORD = 'StrongPass123!';
GO

CREATE USER DemoUser FOR LOGIN DemoUser;
GO

GRANT SELECT, INSERT ON Students TO DemoUser;
GO

REVOKE INSERT ON Students FROM DemoUser;
GO

-- 4) TCL: transaction management
BEGIN TRANSACTION;

INSERT INTO Students (StudentID, FirstName, LastName, Age, Email)
VALUES (3, 'Charlie', 'Brown', 23, 'charlie@example.com');

UPDATE Students
SET Age = 24
WHERE StudentID = 3;

-- Decide whether to save or undo
COMMIT;
-- ROLLBACK;
GO

-- Optional: savepoint example
BEGIN TRANSACTION;

INSERT INTO Students (StudentID, FirstName, LastName, Age, Email)
VALUES (4, 'Dana', 'White', 19, 'dana@example.com');

SAVE TRANSACTION BeforeCleanup;

DELETE FROM Students
WHERE StudentID = 4;

-- To undo only the delete, use ROLLBACK TRANSACTION BeforeCleanup
-- ROLLBACK TRANSACTION BeforeCleanup;

COMMIT;
GO

-- 5) Cleanup for the demo
DROP TABLE IF EXISTS Students;
GO

DROP USER IF EXISTS DemoUser;
GO

DROP LOGIN IF EXISTS DemoUser;
GO

DROP DATABASE IF EXISTS DemoDB;
GO

-- Additional reflection:
-- DDL changes the structure of the database.
-- DML changes the data stored in the structure.
-- DCL controls access to the structure and the data.
-- TCL ensures a group of changes is committed or rolled back consistently.

