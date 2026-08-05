# Security Backbone — Step 09

> Status: ✅ Built as a practical checklist.

## Step 09 — Back up, restore, and recover securely

A backup is part of the security design. If the backup is missing or unprotected, recovery can be impossible.

### Best practices
- create scheduled backups,
- encrypt backup files,
- test restore operations,
- limit who can restore production data.

### Example
```sql
BACKUP DATABASE DemoAuthDB TO DISK = 'C:\Backups\DemoAuthDB.bak';
GO
```

### Key idea
Security includes continuity and recovery, not just login prevention.
