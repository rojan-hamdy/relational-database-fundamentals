# SSMS Server Configuration

## Overview
Server configuration in SSMS focuses on the instance itself: its properties, security settings, network configuration, and service behavior. This is the higher-level administration layer above individual databases.

---

## 1. Accessing server properties

In SSMS:
1. Connect to the SQL Server instance.
2. Right-click the server name.
3. Select Properties.
4. Review the available configuration pages.

Common areas include:
- General
- Security
- Connections
- Database Settings
- Advanced

---

## 2. Common configuration tasks

- configure authentication mode,
- set maximum server memory,
- define login policies,
- configure remote connections,
- manage SQL Server services,
- review default ports and protocols.

---

## 3. Authentication configuration

SSMS allows administrators to choose between:
- Windows authentication mode,
- SQL Server and Windows authentication mode.

This affects how users are allowed to connect to the instance.

### SSMS wizard steps for enabling SQL Server authentication
1. Open SSMS and connect using an administrator account.
2. Right-click the server name in Object Explorer.
3. Choose Properties.
4. Open the Security page.
5. Select SQL Server and Windows Authentication mode.
6. Click OK.
7. Restart the SQL Server service.

> ⚠️ SQL Server authentication mode must be enabled before a SQL login can connect using a username/password.

### Restart the SQL Server service
In Windows:
- Open Services.
- Locate SQL Server (MSSQLSERVER) or your named instance.
- Right-click and choose Restart.

Equivalent command line (administrative shell):
```powershell
net stop MSSQLSERVER
net start MSSQLSERVER
```

If it is a named instance:
```powershell
net stop MSSQLSERVER$SQLEXPRESS
net start MSSQLSERVER$SQLEXPRESS
```

---

## 4. Equivalent T-SQL and management examples

SQL Server does not provide a direct T-SQL command to switch the instance authentication mode. The standard way is through SSMS or SQL Server Configuration Manager. For user creation, use T-SQL:

```sql
CREATE LOGIN AppUserLogin WITH PASSWORD = 'StrongP@ssw0rd!';
GO

CREATE USER AppUser FOR LOGIN AppUserLogin;
GO
```

```sql
CREATE DATABASE DemoAuthDB;
GO

USE DemoAuthDB;
GO

CREATE SCHEMA Sales AUTHORIZATION dbo;
GO

ALTER AUTHORIZATION ON SCHEMA::Sales TO AppUser;
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Sales TO AppUser;
GO
```

---

## 5. Full walkthrough for login, user, schema, and permissions

### Step 1 — Turn on SQL Server authentication mode
SSMS path:
- Server Properties → Security → SQL Server and Windows Authentication mode

### Step 2 — Restart SQL Server
- Stop and start the SQL Server service.

### Step 3 — Create a new login
SSMS:
1. Expand Security.
2. Right-click Logins.
3. Select New Login.
4. Choose SQL Server authentication.
5. Set a strong password.
6. Click OK.

T-SQL:
```sql
CREATE LOGIN DemoLogin WITH PASSWORD = 'StrongP@ssw0rd!';
GO
```

### Step 4 — Create a new user
SSMS:
1. Expand the target database.
2. Expand Security → Users.
3. Right-click Users → New User.
4. Choose the login created in the previous step.
5. Click OK.

T-SQL:
```sql
USE DemoAuthDB;
GO

CREATE USER DemoUser FOR LOGIN DemoLogin;
GO
```

### Step 5 — Create a schema
SSMS:
1. Expand the database.
2. Expand Security.
3. Right-click Schemas → New Schema.
4. Name it `Sales`.
5. Set schema owner as `dbo` or another approved owner.
6. Click OK.

T-SQL:
```sql
CREATE SCHEMA Sales AUTHORIZATION dbo;
GO
```

### Step 6 — Alter schema
If you want to move an existing table into a schema:

```sql
ALTER SCHEMA Sales TRANSFER dbo.Customer;
GO
```

Or change schema ownership:
```sql
ALTER AUTHORIZATION ON SCHEMA::Sales TO DemoUser;
GO
```

### Step 7 — Add user to schema
SSMS:
- In Security → Schemas, select the schema and adjust permissions or ownership.

T-SQL:
```sql
ALTER AUTHORIZATION ON SCHEMA::Sales TO DemoUser;
GO

GRANT ALTER, SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Sales TO DemoUser;
GO
```

### Step 8 — Set permissions for users
SSMS:
1. Expand Database → Security → Users.
2. Select the user.
3. Open Securables or Schema permissions.
4. Grant or deny the needed permissions.

T-SQL:
```sql
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Sales TO DemoUser;
GO

DENY DELETE ON SCHEMA::Sales TO DemoUser;
GO
```

### Step 9 — Disconnect and reconnect
SSMS:
1. In Object Explorer, right-click the server connection.
2. Choose Disconnect.
3. Connect again.
4. Select SQL Server Authentication.
5. Enter the login and password.
6. Click Connect.

This confirms the SQL login works after the authentication-mode change.

### Step 10 — Create a new query
SSMS:
- Click New Query on the toolbar or use Ctrl+N.
- Choose the database you want to work in.
- Run:

```sql
USE DemoAuthDB;
GO

SELECT SUSER_SNAME() AS LoggedInUser;
GO
```

---

## 6. Example end-to-end script

```sql
USE master;
GO

CREATE LOGIN DemoLogin WITH PASSWORD = 'StrongP@ssw0rd!';
GO

CREATE DATABASE DemoAuthDB;
GO

USE DemoAuthDB;
GO

CREATE USER DemoUser FOR LOGIN DemoLogin;
GO

CREATE SCHEMA Sales AUTHORIZATION dbo;
GO

ALTER AUTHORIZATION ON SCHEMA::Sales TO DemoUser;
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Sales TO DemoUser;
GO
```

---

## 7. Best practices

- keep authentication secure,
- avoid unnecessary privileges,
- document configuration changes,
- validate backup and restore processes,
- monitor memory and connection limits,
- minimize schema ownership to approved roles.

---

## 8. Summary

SSMS server configuration and database security go together. Enabling SQL Server authentication, creating a login, mapping a user, creating a schema, and assigning permissions are the basic operational tasks used to secure an instance and a database.

> 💡 **Core idea**
> A well-configured SQL Server instance improves security, performance, and operational stability.

---

> 🔗 **See also**
> - [../Database_Configuration/theory.md](../Database_Configuration/theory.md)
> - [../../08_Authorization_and_Authentication/theory.md](../../08_Authorization_and_Authentication/theory.md)
