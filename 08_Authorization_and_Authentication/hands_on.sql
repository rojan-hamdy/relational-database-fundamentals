-- Hands-on practice: Authorization and Authentication
-- Purpose: understand identity verification and permission enforcement

USE master;
GO

CREATE DATABASE SecurityDemo;
GO

USE SecurityDemo;
GO

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    Age INT
);
GO

INSERT INTO Student (StudentID, StudentName, Age)
VALUES (1, 'Alice', 20), (2, 'Bob', 22);
GO

-- Create login and database user for demonstration
CREATE LOGIN DemoLogin WITH PASSWORD = 'StrongPass123!';
GO

CREATE USER DemoUser FOR LOGIN DemoLogin;
GO

-- Grant access
GRANT SELECT ON dbo.Student TO DemoUser;
GO

-- Optional deny example
-- DENY UPDATE ON dbo.Student TO DemoUser;

-- Review access
SELECT *
FROM Student;
GO

-- Revoke permission when done
REVOKE SELECT ON dbo.Student FROM DemoUser;
GO

DROP USER IF EXISTS DemoUser;
DROP LOGIN IF EXISTS DemoLogin;
DROP TABLE IF EXISTS Student;
DROP DATABASE IF EXISTS SecurityDemo;
GO

-- Reflection:
-- Authentication confirms who the user is.
-- Authorization decides what the authenticated user can do.

