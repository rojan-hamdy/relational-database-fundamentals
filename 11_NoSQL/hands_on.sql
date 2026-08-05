-- Hands-on practice: NoSQL
-- Purpose: understand why NoSQL differs from relational design

-- This file is conceptual and can be used to compare relational vs document models.
-- In SQL Server, use a relational table structure for comparison.

USE master;
GO

CREATE DATABASE NoSQLComparisonDemo;
GO

USE NoSQLComparisonDemo;
GO

-- Relational table: structured, fixed schema
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT,
    Department VARCHAR(50)
);
GO

INSERT INTO Student (StudentID, Name, Age, Department)
VALUES (101, 'Alice', 21, 'CS'), (102, 'Bob', 22, 'Math');
GO

SELECT *
FROM Student;
GO

-- Document-style representation (conceptual, not native SQL Server JSON storage)
-- {
--   "studentId": 101,
--   "name": "Alice",
--   "age": 21,
--   "department": "CS",
--   "interests": ["DB", "AI"]
-- }

-- This shows how a document can hold nested and flexible data.

DROP TABLE IF EXISTS Student;
DROP DATABASE IF EXISTS NoSQLComparisonDemo;
GO

-- Comparison points:
-- Relational: fixed schema, strong integrity, joins, normalization
-- NoSQL: flexible schema, nested data, scalability, high-volume access

