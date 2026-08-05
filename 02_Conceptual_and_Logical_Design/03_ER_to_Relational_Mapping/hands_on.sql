-- Hands-on practice: ER to Relational Mapping
-- Purpose: map conceptual design entities to relational tables and relationships

USE master;
GO

CREATE DATABASE ERMappingDemo;
GO

USE ERMappingDemo;
GO

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);
GO

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
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

INSERT INTO Student (StudentID, FirstName, LastName, DepartmentID)
VALUES (101, 'Alice', 'Johnson', 1), (102, 'Bob', 'Smith', 2);

INSERT INTO Course (CourseID, CourseName)
VALUES (1, 'Database Systems'), (2, 'Discrete Math');

INSERT INTO Enrollment (StudentID, CourseID)
VALUES (101, 1), (101, 2), (102, 1);
GO

SELECT d.DepartmentName, s.FirstName, s.LastName, c.CourseName
FROM Department d
JOIN Student s ON d.DepartmentID = s.DepartmentID
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Course c ON e.CourseID = c.CourseID;
GO

DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Department;
DROP DATABASE IF EXISTS ERMappingDemo;
GO

