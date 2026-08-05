# Security Backbone — Step 07

## Step 07 — Manage passwords and secrets safely

Passwords should never be embedded in plain SQL scripts or source code.

### Good practices
- use strong passwords,
- rotate credentials regularly,
- store secrets in a secure password vault,
- avoid checking credentials into repositories.

### Bad practice
```sql
CREATE LOGIN AppUser WITH PASSWORD = '123456';
GO
```

### Key idea
Secrets must be protected by governance and secure storage, not by luck.
