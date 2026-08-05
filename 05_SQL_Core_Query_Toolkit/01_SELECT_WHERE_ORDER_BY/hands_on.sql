-- Hands-on practice: SELECT, WHERE, ORDER BY

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName NVARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    DepartmentID INT NULL
);

INSERT INTO Student (StudentID, StudentName, Age, DepartmentID)
VALUES
    (1, 'Amina', 20, 10),
    (2, 'Bilal', 23, 20),
    (3, 'Sara', 19, 10),
    (4, 'Omar', 27, 30);

SELECT StudentName, Age
FROM Student
WHERE Age >= 20
ORDER BY Age DESC;

SELECT *
FROM Student
WHERE DepartmentID = 10
ORDER BY StudentName ASC;
