# Security Backbone — Step 08

## Step 08 — Monitor access, changes, and audit activity

You cannot secure what you do not audit.

### Useful signals
- failed login attempts,
- successful logins,
- permission changes,
- schema modifications,
- DML changes on sensitive tables.

### Example
```sql
SELECT *
FROM sys.server_principals;
```

```sql
SELECT *
FROM sys.database_permissions;
```

### pgAdmin method
1. Open SQL Server logs.
2. Review failed login events.
3. Check activity on critical objects.
4. Enable auditing if required.

### Key idea
Monitoring makes security measurable and recoverable.
