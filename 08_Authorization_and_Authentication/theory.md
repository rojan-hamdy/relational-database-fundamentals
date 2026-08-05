# Authorization and Authentication

> Status: ✅ Built as the access-control fundamentals lesson.

## Overview
Authentication and authorization are often confused, but they describe two different security functions.

- Authentication answers: Who are you?
- Authorization answers: What are you allowed to do?

In SQL Server and database systems, these concepts control access to servers, databases, objects, and operations.

---

## 1. Authentication

> 💡 **Definition**
> Authentication is the process of verifying the identity of a user or principal.

Examples:
- SQL Server login
- Windows account
- Azure AD identity
- domain user

Authentication proves the identity before the system checks permissions.

### Typical SQL Server authentication types
- Windows authentication
- SQL Server authentication

---

## 2. Authorization

> 💡 **Definition**
> Authorization is the process of checking whether an authenticated identity has permission to perform an action.

Examples:
- read data from a table
- create a database
- update a stored procedure
- restore a backup

Authorization is enforced through permission checks and security roles.

---

## 3. Difference Between Authentication and Authorization

| Concept | Question | Example |
|---|---|---|
| Authentication | Who are you? | A login is validated |
| Authorization | What can you do? | A user can SELECT from a table |

A user must first authenticate before the system can authorize the action.

---

## 4. SQL Server Security Model

SQL Server has a layered security model:

- server-level principals: logins
- database-level principals: users
- object-level permissions: tables, views, procedures
- roles: fixed and custom roles

This separation makes it easier to centralize and manage access policies.

---

## 5. Logins, Users, and Roles

### Login
A login is a server-level identity.

### User
A user is a database-level identity mapped to a login.

### Role
A role groups permissions so they can be assigned to multiple users at once.

Example roles:
- db_datareader
- db_datawriter
- db_owner
- db_securityadmin

---

## 6. Permissions and Privileges

Common permissions include:

- SELECT
- INSERT
- UPDATE
- DELETE
- EXECUTE
- CREATE TABLE
- ALTER ANY LOGIN

Permissions may be granted, revoked, or denied.

### Example
```sql
GRANT SELECT ON dbo.Student TO AppUser;
REVOKE SELECT ON dbo.Student FROM AppUser;
```

---

## 7. Principle of Least Privilege

> ⚠️ **Best practice**
> Users should receive only the minimum privileges required to do their jobs.

This reduces risk and limits the blast radius of security errors or compromised accounts.

---

## 8. Authentication in SSMS

In SSMS, you can manage access through the Security node:

1. Open SSMS.
2. Connect to the SQL Server instance.
3. Expand Security.
4. View Logins.
5. Create or modify login accounts.
6. Map them to database users as needed.

This is the GUI equivalent of configuring authentication and database access.

---

## 9. Equivalent T-SQL Examples

```sql
-- Create SQL login and database user
CREATE LOGIN AppLogin WITH PASSWORD = 'StrongPass123!';
GO

CREATE USER AppUser FOR LOGIN AppLogin;
GO

-- Give read access to a table
GRANT SELECT ON dbo.Student TO AppUser;
GO

-- Remove permission
REVOKE SELECT ON dbo.Student FROM AppUser;
GO

-- Deny a dangerous permission example
DENY DELETE ON dbo.Student TO AppUser;
GO
```

---

## 10. Diagram Illustration

If you have a login/user/access diagram, save it here:

`images/authentication_authorization_flow.png`

and reference it with:

```markdown
![Auth and authorization flow](images/authentication_authorization_flow.png)
```

---

## 11. Exam-Friendly Summary

- Authentication = verify identity
- Authorization = decide allowed actions
- Logins and users are separate server/database objects
- Permissions control object access
- Least privilege reduces security risk

> 💡 **Core idea**
> Authentication proves who a principal is; authorization determines what that principal may do in the database system.

---

> 🔗 **See also**
> - [../09_Database_Security_Backbone/theory.md](../09_Database_Security_Backbone/theory.md)
> - [../../00_Roadmap_and_StyleGuide/roadmap.md](../../00_Roadmap_and_StyleGuide/roadmap.md)
