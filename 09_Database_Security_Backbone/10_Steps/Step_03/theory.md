# Security Backbone — Step 03

## Step 03 — Enforce authentication

Authentication confirms identity. Without it, access control cannot work.

### Common choices
- Windows authentication
- SQL Server authentication
- integrated identity solutions

### Example login creation
```sql
CREATE LOGIN DemoLogin WITH PASSWORD = 'StrongP@ssw0rd!';
GO
```

### SSMS method
1. Connect to the SQL Server instance as an admin.
2. Expand Security.
3. Right-click Logins.
4. Select New Login.
5. Choose SQL Server authentication or Windows authentication.
6. Set password policy and review defaults.

### Key idea
A strong authentication mechanism prevents unauthorized access at the first gate.
