# pgAdmin & PostgreSQL Server Configuration

## Overview
Server configuration in PostgreSQL focuses on the server instance (cluster) itself: its runtime configuration parameters (`postgresql.conf`), client authentication rules (`pg_hba.conf`), security roles, network settings, and service behavior. This is the higher-level administration layer above individual databases.

---

## 1. Accessing Server Properties & Settings

In pgAdmin:
1. Connect to your PostgreSQL server instance in the Browser panel.
2. Right-click the server name and select **Properties...**.
3. Review the available configuration tabs:
   - **General**: Connection parameters (host, port, maintenance database, username).
   - **Connection**: Passwords, SSL mode, connection timeouts.
   - **Advanced**: SSL certificate settings, DB restriction rules.

To view or adjust runtime configuration variables in pgAdmin:
- Select the server or database node, open the **Query Tool**, and run `SHOW ALL;` or use pgAdmin's configuration editor dialogs.

---

## 2. Common Server Configuration Tasks

- Configure client authentication rules (`pg_hba.conf`),
- Tune memory allocation (`shared_buffers`, `work_mem`, `maintenance_work_mem`),
- Configure WAL (Write-Ahead Logging) and archiving parameters,
- Manage server connections and max connection limits (`max_connections`),
- Create and configure security roles (logins and group roles),
- Review default ports (default `5432`) and network binding (`listen_addresses`).

---

## 3. Client Authentication & Connection Management

PostgreSQL uses `pg_hba.conf` (Host-Based Authentication) to control client connection privileges:
- **Local / Unix domain sockets**: `peer`, `trust`, or `md5` / `scram-sha-256`.
- **IPv4 / IPv6 TCP connections**: `scram-sha-256` (recommended password method), `md5`, `cert`, etc.

### Managing Server Configuration Parameters
Parameters can be modified via SQL commands or configuration files:

```sql
-- View current configuration
SHOW max_connections;
SHOW shared_buffers;

-- Change a setting for future server restarts
ALTER SYSTEM SET shared_buffers = '2GB';

-- Reload configuration files without restarting the server
SELECT pg_reload_conf();
```

---

## 4. PostgreSQL Roles & Schema Management

In PostgreSQL, logins and users are unified into **Roles**. A role with the `LOGIN` attribute functions as a login account.

```sql
-- Step 1: Create a role with login privilege and password
CREATE ROLE demologin WITH LOGIN PASSWORD 'StrongP@ssw0rd123!';

-- Step 2: Create a database owned by a specific role
CREATE DATABASE demoauthdb OWNER postgres;

-- Step 3: Connect to the database and create a schema
\c demoauthdb

CREATE SCHEMA sales AUTHORIZATION demologin;

-- Step 4: Grant schema and table privileges to the role
GRANT USAGE ON SCHEMA sales TO demologin;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA sales TO demologin;
```

---

## 5. Full Walkthrough: Role, Schema, and Permissions in pgAdmin & SQL

### Step 1 — Create a New Login Role in pgAdmin
1. In the Browser panel, right-click **Login/Group Roles**.
2. Select **Create > Login/Group Role...**.
3. In the **General** tab, set the name (e.g., `demouser`).
4. In the **Definition** tab, set the password.
5. In the **Privileges** tab, toggle **Can login?** to `Yes`.
6. Click **Save**.

Equivalent SQL:
```sql
CREATE ROLE demouser WITH LOGIN PASSWORD 'StrongP@ssw0rd123!';
```

### Step 2 — Create a Schema
1. Expand **Databases > demoauthdb > Schemas**.
2. Right-click **Schemas** and choose **Create > Schema...**.
3. Enter the schema name `sales` and set Owner to `demouser`.
4. Click **Save**.

Equivalent SQL:
```sql
CREATE SCHEMA sales AUTHORIZATION demouser;
```

### Step 3 — Assign Schema Privileges
```sql
-- Allow role to use the schema
GRANT USAGE ON SCHEMA sales TO demouser;

-- Allow role to create objects inside the schema
GRANT CREATE ON SCHEMA sales TO demouser;

-- Grant default privileges for future tables created in schema sales
ALTER DEFAULT PRIVILEGES IN SCHEMA sales 
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO demouser;
```

### Step 4 — Verify Connection in pgAdmin
1. Right-click **Servers** in pgAdmin -> **Register > Server...**.
2. Set connection Host to `localhost`, Database to `demoauthdb`, Username to `demouser`, and enter the password.
3. Click **Save** and test executing queries under the new role context:

```sql
SELECT current_user, current_database();
```

---

## 6. Example End-to-End Setup Script

```sql
-- Run as postgres superuser
CREATE ROLE AppUser WITH LOGIN PASSWORD 'SecureP@ss2026!';

CREATE DATABASE DemoAuthDB OWNER postgres;

-- Connect to DemoAuthDB
\c DemoAuthDB

CREATE SCHEMA Sales AUTHORIZATION AppUser;

GRANT USAGE, CREATE ON SCHEMA Sales TO AppUser;

-- Grant permissions on future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA Sales 
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO AppUser;
```

---

## 7. Best Practices for Server Administration

- Use `scram-sha-256` authentication in `pg_hba.conf`.
- Never run application workloads using the `postgres` superuser role.
- Document changes made via `ALTER SYSTEM` or direct editing of `postgresql.conf`.
- Set appropriate `work_mem` and `shared_buffers` based on available system RAM.
- Periodically reload configuration changes (`SELECT pg_reload_conf();`) or restart services cleanly.

---

## 8. Summary

pgAdmin server configuration and database security revolve around PostgreSQL's role hierarchy, schema authorization, and configuration settings. Configuring client access, creating roles with controlled privileges, creating schemas, and managing default privileges are core administration tasks.

> 💡 **Core idea**
> A well-configured PostgreSQL server instance ensures robust security, optimal memory usage, and clean isolation across databases.

---

> 🔗 **See also**
> - [../Database_Configuration/theory.md](../Database_Configuration/theory.md)
> - [../../08_Authorization_and_Authentication/theory.md](../../08_Authorization_and_Authentication/theory.md)
