# Security Backbone — Step 01

## Step 01 — Identify assets and sensitive data

The first step in the security backbone is to understand what must be protected.

Examples of sensitive data:
- personal information,
- employee records,
- health data,
- credit card details,
- audit logs,
- payroll tables.

### What to review
- Which tables contain confidential data?
- Which columns are sensitive?
- Which systems depend on the database?
- Which users should access each object?

### Good practice
Create a simple asset inventory:
- database name,
- table name,
- sensitivity level,
- owner,
- access rule.

### Example
```sql
SELECT name, type_desc
FROM sys.objects
WHERE type IN ('U', 'V', 'P');
```
This helps administrators identify the core database objects that require protection.

### pgAdmin method
1. Open pgAdmin.
2. Connect to the server.
3. Expand Databases.
4. Inspect tables, views, and stored procedures.
5. Review which objects hold sensitive information.

### Key idea
If you do not know what needs protection, you cannot design a secure system.
