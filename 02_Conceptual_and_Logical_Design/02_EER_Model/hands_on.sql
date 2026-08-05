-- Hands-on practice: EER Model
-- Purpose: model inheritance and specialization patterns

USE master;
GO

CREATE DATABASE EERModelDemo;
GO

USE EERModelDemo;
GO

CREATE TABLE Person (
    PersonID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DOB DATE
);
GO

CREATE TABLE Employee (
    PersonID INT PRIMARY KEY,
    Salary DECIMAL(10,2),
    HireDate DATE,
    CONSTRAINT FK_Employee_Person
        FOREIGN KEY (PersonID)
        REFERENCES Person(PersonID)
);
GO

CREATE TABLE Customer (
    PersonID INT PRIMARY KEY,
    MembershipNumber VARCHAR(50),
    CONSTRAINT FK_Customer_Person
        FOREIGN KEY (PersonID)
        REFERENCES Person(PersonID)
);
GO

INSERT INTO Person (PersonID, Name, DOB)
VALUES (1, 'Alice Johnson', '1990-01-15'), (2, 'Bob Smith', '1985-05-20'), (3, 'Cara White', '1993-09-09');

INSERT INTO Employee (PersonID, Salary, HireDate)
VALUES (1, 75000.00, '2020-03-01');

INSERT INTO Customer (PersonID, MembershipNumber)
VALUES (2, 'VIP-204');
GO

SELECT p.PersonID, p.Name, e.Salary, c.MembershipNumber
FROM Person p
LEFT JOIN Employee e ON p.PersonID = e.PersonID
LEFT JOIN Customer c ON p.PersonID = c.PersonID;
GO

DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Person;
DROP DATABASE IF EXISTS EERModelDemo;
GO

