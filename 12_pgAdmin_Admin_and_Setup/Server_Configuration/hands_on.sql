-- Hands-on practice: PostgreSQL & pgAdmin Server Configuration
-- Purpose: practice creating roles, databases, schemas, and setting default privileges

-- Step 1: Create a login role
CREATE ROLE demologin WITH LOGIN PASSWORD 'StrongP@ssw0rd123!';

-- Step 2: Create target database
CREATE DATABASE demoauthdb OWNER postgres;

-- Step 3: Switch to the database (in psql: \c demoauthdb, or open Query Tool on demoauthdb in pgAdmin)
-- \c demoauthdb

-- Step 4: Create a schema owned by the new role
CREATE SCHEMA sales AUTHORIZATION demologin;

-- Step 5: Grant permissions to the role
GRANT USAGE, CREATE ON SCHEMA sales TO demologin;

ALTER DEFAULT PRIVILEGES IN SCHEMA sales 
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO demologin;

-- Step 6: Verify active user and database
SELECT current_user, current_database();

-- Cleanup (run as superuser when finished)
-- DROP SCHEMA IF EXISTS sales CASCADE;
-- DROP DATABASE IF EXISTS demoauthdb;
-- DROP ROLE IF EXISTS demologin;
