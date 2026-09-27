# Security Backbone — Step 02

## Step 02 — Define users, roles, and access groups

Access should be assigned by responsibility, not by ad hoc exceptions.

Common groups:
- DB reader
- DB writer
- data analyst
- application role
- database administrator
- auditor

### Best practice
Use roles when possible so permissions are consistent and easier to audit.

### Example T-SQL
```sql
CREATE ROLE App_ReadOnly;
GO

CREATE ROLE App_Developer;
GO
```

```sql
GRANT SELECT ON SCHEMA::dbo TO App_ReadOnly;
GO
```

### pgAdmin method
1. Open the target database.
2. Expand Security.
3. Expand Roles.
4. Create or modify roles.
5. Add users to the correct role.

### Key idea
Permissions should follow business responsibilities, not individual preferences.
