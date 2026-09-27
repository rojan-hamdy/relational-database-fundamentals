# Security Backbone — Step 05

## Step 05 — Protect database objects

Not all objects should be equally accessible.

Examples:
- payroll tables,
- audit tables,
- stored procedures,
- configuration tables,
- sensitive views.

### Example
```sql
DENY INSERT ON dbo.Payroll TO FinanceUser;
GO
```

### pgAdmin method
1. Open database object properties.
2. Set permissions for tables, views, and procedures.
3. Restrict access to admin-only objects.

### Key idea
Protection must be applied to objects, not only to users.
