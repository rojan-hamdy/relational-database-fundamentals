-- Hands-on Practice: SELECT, WHERE, ORDER BY, TOP WITH TIES, LIKE, CASE, IIF & NEWID()

-- 1. Create and Populate Sample Table
CREATE TABLE dbo.Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    DepartmentID INT NULL,
    Score DECIMAL(5,2) NOT NULL
);

INSERT INTO dbo.Student (StudentID, StudentName, Age, DepartmentID, Score)
VALUES
    (1, 'Amina Smith', 20, 10, 95.00),
    (2, 'Bilal Khan', 23, 20, 90.00),
    (3, 'Sara Ahmed', 19, 10, 90.00),
    (4, 'Omar Hassan', 27, 30, 85.00),
    (5, 'Adam Davis', 22, 10, 78.50);

-- 2. Practice LIKE Pattern Matching
-- Names starting with 'A'
SELECT * FROM dbo.Student WHERE StudentName LIKE 'A%';

-- Second character is 'm'
SELECT * FROM dbo.Student WHERE StudentName LIKE '_m%';

-- First name starting with A or B
SELECT * FROM dbo.Student WHERE StudentName LIKE '[A-B]%';

-- 3. Practice TOP WITH TIES
-- Scores: 95.00, 90.00, 90.00 -> TOP (2) WITH TIES returns 3 rows because of the tie at 90.00!
SELECT TOP (2) WITH TIES StudentID, StudentName, Score
FROM dbo.Student
ORDER BY Score DESC;

-- 4. Practice CASE and IIF Conditional Logic
SELECT 
    StudentName, 
    Score,
    IIF(Score >= 80.00, 'Pass', 'Fail') AS Status,
    CASE 
        WHEN Score >= 90.00 THEN 'Grade A'
        WHEN Score >= 80.00 THEN 'Grade B'
        ELSE 'Grade C'
    END AS PerformanceGrade
FROM dbo.Student;

-- 5. Practice Random Sorting with NEWID()
SELECT TOP (1) StudentName, Score
FROM dbo.Student
ORDER BY NEWID();
