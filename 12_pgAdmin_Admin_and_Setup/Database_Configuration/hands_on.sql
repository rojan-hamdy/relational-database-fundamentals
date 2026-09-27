-- Hands-on practice: PostgreSQL & pgAdmin Database Configuration
-- Purpose: practice database creation, schema setup, encoding, and privilege management

-- Step 1: Create application owner role
CREATE ROLE appadmin WITH LOGIN PASSWORD 'SecureAdminPass123!';

-- Step 2: Create a database owned by appadmin
CREATE DATABASE democonfigdb OWNER appadmin ENCODING = 'UTF8';

-- Step 3: Connect to the new database (in psql: \c democonfigdb, or open Query Tool on democonfigdb in pgAdmin)
-- \c democonfigdb

-- Step 4: Create tables under the sales schema
CREATE SCHEMA sales AUTHORIZATION appadmin;

CREATE TABLE sales.employee (
    employee_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL
);

INSERT INTO sales.employee (employee_name, department)
VALUES ('Nabil', 'IT'), ('Huda', 'Finance');

SELECT * FROM sales.employee;

-- Cleanup (run when finished)
-- DROP TABLE IF EXISTS sales.employee;
-- DROP SCHEMA IF EXISTS sales;
-- DROP DATABASE IF EXISTS democonfigdb;
-- DROP ROLE IF EXISTS appadmin;
