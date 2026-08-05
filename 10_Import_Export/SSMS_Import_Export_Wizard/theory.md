# Import/Export via SSMS Wizard

> Status: ✅ Built as the GUI-based data migration lesson.

## Overview
SQL Server Management Studio (SSMS) includes a wizard that helps import and export data between SQL Server and external sources such as flat files, Excel files, or other database systems.

This is often the fastest way to perform a data move when a user wants a visual guided process.

---

## 1. Typical use cases

Use the SSMS Import and Export Wizard when:
- moving data from Excel or CSV to SQL Server,
- exporting tables to flat files,
- migrating data between databases,
- creating quick prototypes or test data loads.

---

## 2. Wizard path in SSMS

1. Open SSMS.
2. Connect to the SQL Server instance.
3. Right-click a database.
4. Choose Tasks → Import Data or Export Data.
5. Select the source or destination.
6. Choose tables or queries to move.
7. Map source and destination columns.
8. Run the package and review the result.

---

## 3. Common source/destination types

- SQL Server database
- Flat file (.csv, .txt)
- Excel file
- OLE DB provider
- Other database systems

---

## 4. Mapping and validation

Before running the import/export, you should check:
- column names match,
- data types are compatible,
- nullability is appropriate,
- delimiters and text qualifiers are correct.

---

## 5. Equivalent T-SQL ideas

The wizard often creates an SSIS package or an operation equivalent to a bulk load process. In simple cases, these workflows are mirrored by:

```sql
BULK INSERT dbo.Student
FROM 'C:\data\student_data.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
```

This is the T-SQL equivalent of some import operations.

---

## 6. Best practices

- test on a non-production database,
- keep backups before migration,
- check the destination schema before data load,
- validate counts and sample records after import,
- use the wizard for quick tasks, but script long-term migrations for repeatability.

---

## 7. Summary

The SSMS wizard is a practical GUI tool for moving data between systems quickly. It is easier for ad hoc tasks and teaching, while scripted bulk operations are better for repeatable production pipelines.

> 💡 **Core idea**
> GUI wizards make data transfer accessible, while scripted bulk operations offer precision, automation, and repeatability.

---

> 🔗 **See also**
> - [../BCP_and_Scripts/theory.md](../BCP_and_Scripts/theory.md)
> - [../../12_SSMS_Admin_and_Setup/Database_Configuration/theory.md](../../12_SSMS_Admin_and_Setup/Database_Configuration/theory.md)
