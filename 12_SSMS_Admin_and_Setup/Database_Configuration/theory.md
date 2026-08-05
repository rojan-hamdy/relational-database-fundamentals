# SSMS Database Configuration

## Overview
SSMS provides a graphical interface for configuring database properties and objects. This is often the starting point for database administrators and developers working with SQL Server.

---

## 1. Database configuration in SSMS

From the object explorer:
1. Connect to the SQL Server instance.
2. Expand Databases.
3. Right-click a database.
4. Open Properties.
5. Review and modify options such as recovery model, file locations, or compatibility settings.

---

## 2. Key database settings

Common areas in SSMS include:
- General
- Files
- Filegroups
- Options
- Permissions
- Extended Properties

Examples:
- database size and file paths,
- recovery model,
- auto-growth settings,
- compatibility level.

---

## 3. Typical configuration tasks

- create a new database,
- add files and filegroups,
- set the recovery model,
- change auto-growth parameters,
- configure permissions for users and roles.

---

## 4. Equivalent T-SQL

```sql
CREATE DATABASE AppDB;
GO

USE AppDB;
GO

ALTER DATABASE AppDB
SET RECOVERY SIMPLE;
GO
```

---

## 5. File configuration example

```sql
ALTER DATABASE AppDB
ADD FILEGROUP FG_Archive;
GO

ALTER DATABASE AppDB
ADD FILE (
    NAME = AppDB_Data_Archive,
    FILENAME = 'C:\SQLData\AppDB_Data_Archive.ndf',
    SIZE = 10MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 5MB
) TO FILEGROUP FG_Archive;
GO
```

---

## 6. Real configuration flow: login, user, schema, permissions

The following sequence is the standard way to create a secure database setup in SSMS and in code.

### 6.1 Turn on SQL Server authentication mode
SSMS steps:
1. Connect to the SQL Server instance using an admin account.
2. Right-click the server.
3. Choose Properties.
4. Select Security.
5. Choose SQL Server and Windows Authentication mode.
6. Click OK.
7. Restart the SQL Server service.

### 6.2 Create a login
SSMS path:
- Security → Logins → New Login

T-SQL:
```sql
CREATE LOGIN DemoLogin WITH PASSWORD = 'StrongP@ssw0rd!';
GO
```

### 6.3 Create a database user
SSMS path:
- Database → Security → Users → New User

T-SQL:
```sql
USE DemoAuthDB;
GO

CREATE USER DemoUser FOR LOGIN DemoLogin;
GO
```

### 6.4 Create a schema
SSMS path:
- Database → Security → Schemas → New Schema

T-SQL:
```sql
CREATE SCHEMA Sales AUTHORIZATION dbo;
GO
```

### 6.5 Alter schema
Move an existing table into the schema:
```sql
ALTER SCHEMA Sales TRANSFER dbo.Customer;
GO
```

Or change ownership:
```sql
ALTER AUTHORIZATION ON SCHEMA::Sales TO DemoUser;
GO
```

### 6.6 Add users to schema
Grant permissions at the schema level:
```sql
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Sales TO DemoUser;
GO
```

### 6.7 Set permissions for the user
SSMS path:
- User → Properties → Securables or schema permissions

T-SQL:
```sql
GRANT ALTER, SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Sales TO DemoUser;
GO
```

### 6.8 Disconnect and reconnect
SSMS:
1. Right-click the server connection in Object Explorer.
2. Choose Disconnect.
3. Connect again using SQL Server Authentication.
4. Enter the login name and password.

### 6.9 Open a new query window
SSMS:
- Click New Query.
- Use the target database.

```sql
USE DemoAuthDB;
GO

SELECT SUSER_SNAME() AS CurrentLogin;
GO
```

---

## 7. Best practices

- store data and log files on appropriate drives,
- monitor growth settings,
- use sensible recovery models,
- document configuration changes,
- validate permissions after admin changes,
- keep SQL authentication only when required and secure with strong passwords.

---

## 8. Summary

SSMS database configuration is the GUI way to manage a database’s files, behavior, and access model. The same actions can often be repeated in T-SQL for scripting and repeatability. In practical admin work, the database setup often includes login creation, user mapping, schema creation, and permission assignment.

> 💡 **Core idea**
> Database configuration is not just a setup step; it directly affects performance, recovery, security, and maintainability.

---

> 🔗 **See also**
> - [../Server_Configuration/theory.md](../Server_Configuration/theory.md)
> - [../../10_Import_Export/SSMS_Import_Export_Wizard/theory.md](../../10_Import_Export/SSMS_Import_Export_Wizard/theory.md)
