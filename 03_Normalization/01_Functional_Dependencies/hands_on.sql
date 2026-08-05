-- Hands-on practice: Functional Dependencies
-- Purpose: understand dependency-driven table design and normalization thinking

USE master;
GO

CREATE DATABASE NormalizationDemo;
GO

USE NormalizationDemo;
GO

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);
GO

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    CONSTRAINT FK_Student_Department
        FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);
GO

CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL
);
GO

CREATE TABLE Enrollment (
    StudentID INT,
    CourseID INT,
    Grade VARCHAR(10),
    PRIMARY KEY (StudentID, CourseID),
    CONSTRAINT FK_Enrollment_Student
        FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID),
    CONSTRAINT FK_Enrollment_Course
        FOREIGN KEY (CourseID)
        REFERENCES Course(CourseID)
);
GO

INSERT INTO Department (DepartmentID, DepartmentName)
VALUES (1, 'Computer Science'), (2, 'Mathematics');

INSERT INTO Student (StudentID, StudentName, DepartmentID)
VALUES (101, 'Alice Johnson', 1), (102, 'Bob Smith', 2);

INSERT INTO Course (CourseID, CourseName)
VALUES (1, 'Database Systems'), (2, 'Discrete Math');

INSERT INTO Enrollment (StudentID, CourseID, Grade)
VALUES (101, 1, 'A'), (101, 2, 'B'), (102, 1, 'A');
GO

-- Functional dependency examples:
-- StudentID -> StudentName, DepartmentID
-- DepartmentID -> DepartmentName
-- CourseID -> CourseName
-- (StudentID, CourseID) -> Grade

SELECT s.StudentID, s.StudentName, d.DepartmentName, c.CourseName, e.Grade
FROM Student s
JOIN Department d ON s.DepartmentID = d.DepartmentID
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Course c ON e.CourseID = c.CourseID;
GO

DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Department;
DROP DATABASE IF EXISTS NormalizationDemo;
GO

