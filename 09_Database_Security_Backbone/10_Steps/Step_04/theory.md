# Security Backbone — Step 04

## Step 04 — Apply authorization with least privilege

Authorization decides what a valid user may do.

### Principle
Grant only the minimum privileges required for the task.

### Example
```sql
CREATE USER DemoUser FOR LOGIN DemoLogin;
GO

GRANT SELECT ON dbo.Customer TO DemoUser;
GO

DENY DELETE ON dbo.Customer TO DemoUser;
GO
```

### pgAdmin method
1. Expand Database → Security → Users.
2. Select the user.
3. Review permissions.
4. Grant only required privileges.

### Key idea
Least privilege reduces risk if a credential is compromised.
