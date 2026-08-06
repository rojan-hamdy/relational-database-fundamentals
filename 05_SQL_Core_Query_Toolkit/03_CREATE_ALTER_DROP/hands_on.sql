-- Hands-on Practice: CREATE, ALTER, DROP, Schemas & Identity Management

-- 1. Create Schema and Table with IDENTITY
CREATE SCHEMA academy AUTHORIZATION dbo;
GO

CREATE TABLE academy.Course (
    CourseID INT IDENTITY(10, 5) PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT DEFAULT 3
);
GO

-- 2. Insert Row and Retrieve Identity
INSERT INTO academy.Course (CourseName, Credits)
VALUES ('Database Systems', 4);

SELECT SCOPE_IDENTITY() AS NewCourseID;  -- 10

-- 3. Practice SET IDENTITY_INSERT
SET IDENTITY_INSERT academy.Course ON;

INSERT INTO academy.Course (CourseID, CourseName, Credits)
VALUES (99, 'Legacy Data Warehousing', 4);

SET IDENTITY_INSERT academy.Course OFF;

-- 4. Inspect and Reseed Identity with DBCC CHECKIDENT
DBCC CHECKIDENT ('academy.Course', NORESEED);

DBCC CHECKIDENT ('academy.Course', RESEED, 200);

-- 5. Alter Table and Schema Transfer
ALTER TABLE academy.Course
ADD DepartmentCode VARCHAR(10);
GO

-- Cleanup
DROP TABLE academy.Course;
DROP SCHEMA academy;
GO
