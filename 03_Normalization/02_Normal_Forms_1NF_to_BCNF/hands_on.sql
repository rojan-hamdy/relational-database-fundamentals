-- Hands-on practice: Normal Forms (1NF to BCNF)

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName NVARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL,
    DepartmentName NVARCHAR(100) NOT NULL
);

-- This version is not fully normalized because DepartmentName repeats for many students.

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(100) NOT NULL
);

CREATE TABLE StudentNormalized (
    StudentID INT PRIMARY KEY,
    StudentName NVARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL,
    CONSTRAINT FK_Student_Department FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);

INSERT INTO Department (DepartmentID, DepartmentName)
VALUES (1, 'Computer Science'), (2, 'Business');

INSERT INTO StudentNormalized (StudentID, StudentName, DepartmentID)
VALUES (101, 'Ayesha', 1), (102, 'Khalid', 2);
