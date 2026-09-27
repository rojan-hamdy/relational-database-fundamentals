-- Hands-on practice: DDL, DML, DCL, TCL (PostgreSQL)
-- Purpose: understand how schema, data, permissions, and transactions work together

-- 1) DDL: create a table and modify its structure
CREATE DATABASE demodb;

-- In psql client, switch to the new database:
-- \c demodb

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT,
    email VARCHAR(100)
);

ALTER TABLE students
ADD COLUMN date_of_birth DATE;

-- 2) DML: insert, read, update, and delete data
INSERT INTO students (student_id, first_name, last_name, age, email, date_of_birth)
VALUES
    (1, 'Alice', 'Johnson', 20, 'alice@example.com', '2005-01-15'),
    (2, 'Bob', 'Smith', 22, 'bob@example.com', '2003-03-10');

SELECT *
FROM students;

UPDATE students
SET age = 21
WHERE student_id = 1;

DELETE FROM students
WHERE student_id = 2;

-- 3) DCL: grant and revoke permissions
-- PostgreSQL unifies logins and users into roles
CREATE USER demo_user WITH PASSWORD 'StrongPass123!';

GRANT SELECT, INSERT ON students TO demo_user;

REVOKE INSERT ON students FROM demo_user;

-- 4) TCL: transaction management
BEGIN;

INSERT INTO students (student_id, first_name, last_name, age, email)
VALUES (3, 'Charlie', 'Brown', 23, 'charlie@example.com');

UPDATE students
SET age = 24
WHERE student_id = 3;

-- Decide whether to save or undo
COMMIT;
-- ROLLBACK;

-- Savepoint example
BEGIN;

INSERT INTO students (student_id, first_name, last_name, age, email)
VALUES (4, 'Dana', 'White', 19, 'dana@example.com');

SAVEPOINT before_cleanup;

DELETE FROM students
WHERE student_id = 4;

-- To undo only the delete:
-- ROLLBACK TO SAVEPOINT before_cleanup;

COMMIT;

-- 5) Cleanup for the demo
DROP TABLE IF EXISTS students;

DROP USER IF EXISTS demo_user;

-- Note: To drop the database, disconnect from demodb first (e.g., \c postgres)
-- DROP DATABASE IF EXISTS demodb;

-- Additional reflection:
-- DDL changes the structure of the database.
-- DML changes the data stored in the structure.
-- DCL controls access to the structure and the data.
-- TCL ensures a group of changes is committed or rolled back consistently.
