# pgAdmin & PostgreSQL Database Configuration

## Overview
pgAdmin provides an intuitive graphical interface for configuring PostgreSQL database properties, schemas, extension tools, tablespaces, and security controls.

---

## 1. Database Configuration in pgAdmin

In pgAdmin:
1. Connect to your PostgreSQL server instance.
2. Expand **Databases**.
3. Right-click a database and choose **Properties...**.
4. Review and modify tabs such as:
   - **General**: Name, Owner, Comments.
   - **Definition**: Encoding (UTF8), Template, Tablespace, Connection Limit.
   - **Security**: Grant/revoke database-level privileges (CONNECT, CREATE, TEMPORARY) to roles.
   - **Parameters**: Per-database configuration overrides (e.g. setting custom `search_path` or `statement_timeout`).

---

## 2. Key Database Settings in PostgreSQL

Common database configuration areas:
- **Encoding & Collation**: UTF-8, LC_COLLATE, LC_CTYPE.
- **Default Tablespace**: Specifies physical storage directory for database objects.
- **Connection Limit**: Maximum concurrent connections allowed for this database (`-1` = unlimited).
- **Schema Management**: Managing `public` and custom schemas.
- **Extensions**: Installing relational extensions (e.g. `uuid-ossp`, `pg_trgm`, `postgis`).

---

## 3. Typical Database Admin Tasks

- Create new databases (`CREATE DATABASE`),
- Assign database ownership to specific roles,
- Install extensions (`CREATE EXTENSION`),
- Configure tablespaces (`CREATE TABLESPACE`),
- Define schemas and schema search paths (`ALTER DATABASE ... SET search_path`),
- Set per-database execution timeouts or memory parameters.

---

## 4. Equivalent SQL Commands

```sql
-- Create database with specific owner and encoding
CREATE DATABASE appdb 
    WITH OWNER = appowner 
    ENCODING = 'UTF8'
    CONNECTION LIMIT = 50;

-- Set default search path for the database
ALTER DATABASE appdb SET search_path TO sales, public;

-- Set custom statement timeout for a database
ALTER DATABASE appdb SET statement_timeout = '30s';
```

---

## 5. Tablespace & Storage Configuration

PostgreSQL uses **Tablespaces** to assign different storage locations (e.g., SSDs vs HDDs) to databases or tables.

```sql
-- Create a custom tablespace
CREATE TABLESPACE fast_storage LOCATION '/mnt/fast_ssd/pg_data';

-- Create a database inside the fast tablespace
CREATE DATABASE analyticsdb TABLESPACE fast_storage;
```

---

## 6. End-to-End Workflow: Roles, Databases, Schemas, & Privileges

### Step 1 — Create Role and Database in pgAdmin or SQL
```sql
-- Create application owner role
CREATE ROLE appadmin WITH LOGIN PASSWORD 'SecureAdminPass123!';

-- Create application database owned by appadmin
CREATE DATABASE appdb OWNER appadmin;
```

### Step 2 — Connect to target database
```sql
\c appdb
```

### Step 3 — Create Schema & Tables
```sql
CREATE SCHEMA sales AUTHORIZATION appadmin;

CREATE TABLE sales.customers (
    customer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Step 4 — Configure Default Permissions
```sql
-- Create a read-only reporting role
CREATE ROLE report_user WITH LOGIN PASSWORD 'ReportUserPass123!';

GRANT USAGE ON SCHEMA sales TO report_user;
GRANT SELECT ON ALL TABLES IN SCHEMA sales TO report_user;

-- Ensure future tables inherit SELECT permissions
ALTER DEFAULT PRIVILEGES IN SCHEMA sales 
GRANT SELECT ON TABLES TO report_user;
```

### Step 5 — Verify Active Role & Connection Settings
In pgAdmin Query Tool:
```sql
SELECT current_user, current_database(), current_schema();
```

---

## 7. Best Practices

- Store databases on fast storage using dedicated tablespaces when handling high I/O workloads.
- Avoid using the default `public` schema for sensitive multi-tenant data; create isolated schemas instead.
- Set reasonable connection limits on databases to avoid saturating PostgreSQL process memory.
- Use UTF-8 encoding for standard international character support.
- Script database creation and default privilege grants for reproducible deployment pipelines.

---

## 8. Summary

pgAdmin database configuration provides complete GUI and SQL control over database properties, tablespaces, encoding, schemas, and security defaults.

> 💡 **Core idea**
> Configuring databases with proper owners, schemas, tablespaces, and default privileges ensures security, performance, and clear administrative isolation.

---

> 🔗 **See also**
> - [../Server_Configuration/theory.md](../Server_Configuration/theory.md)
> - [../../10_Import_Export/pgAdmin_Import_Export_Tools/theory.md](../../10_Import_Export/pgAdmin_Import_Export_Tools/theory.md)
