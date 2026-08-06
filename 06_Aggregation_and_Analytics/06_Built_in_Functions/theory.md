# Built-in Functions (String, Date, Math, NULL Handling, System & GUIDs)

## Overview
SQL Server includes many built-in functions that help with string manipulation, date operations, numeric calculations, handling missing (`NULL`) data, generating unique identifiers (`NEWID()`), identity retrieval (`SCOPE_IDENTITY()`), and accessing system metadata.

---

## Sample Table Used in Examples

`dbo.Student`

| StudentID | StudentName | BirthDate | Score | Email | Phone |
|---|---|---|---|---|---|
| 1 | alice smith | 2001-04-12 | 87.456 | alice@mail.com | NULL |
| 2 | Bob Khan | 2000-11-02 | 92.1 | NULL | 010-555-1234 |
| 3 | nora ali | 2002-01-30 | 78.0 | nora@mail.com | NULL |

---

## 1. String Functions

| Function | What it does |
|---|---|
| `UPPER(str)` | Converts text to all uppercase |
| `LOWER(str)` | Converts text to all lowercase |
| `LEN(str)` | Returns the number of characters (ignores trailing spaces) |
| `CONCAT(a, b, ...)` | Joins values into one string; treats `NULL` as an empty string (safer than `+`) |
| `TRIM(str)` | Removes leading and trailing spaces |
| `SUBSTRING(str, start, length)` | Extracts part of a string, starting at `start`, for `length` characters |
| `REPLACE(str, old, new)` | Replaces every occurrence of `old` with `new` |
| `LEFT(str, n)` / `RIGHT(str, n)` | Returns the first/last `n` characters |
| `CHARINDEX(sub, str)` | Returns the position where `sub` first appears inside `str` (0 if not found) |
| `FORMAT(value, format)` | Formats a value using a .NET-style format string |

```sql
SELECT UPPER('alice')                        AS UpperName;        -- 'ALICE'
SELECT LOWER('ALICE')                        AS LowerName;        -- 'alice'
SELECT LEN('database')                       AS NameLength;       -- 8
SELECT CONCAT('Alice', ' ', 'Smith')         AS FullName;         -- 'Alice Smith'
SELECT TRIM('  nora ali  ')                  AS Trimmed;          -- 'nora ali'
SELECT SUBSTRING('database', 1, 4)           AS Sub;              -- 'data'
SELECT REPLACE('2024-01-01', '-', '/')       AS Replaced;         -- '2024/01/01'
SELECT LEFT('database', 4)                   AS LeftPart;         -- 'data'
SELECT RIGHT('database', 4)                  AS RightPart;        -- 'base'
SELECT CHARINDEX('base', 'database')         AS Position;         -- 5
SELECT FORMAT(1234.5, 'N2')                  AS Formatted;        -- '1,234.50'
```

---

## 2. Date Functions

| Function | What it does |
|---|---|
| `GETDATE()` | Returns the current date and time |
| `DATEADD(part, n, date)` | Adds `n` units (`DAY`, `MONTH`, `YEAR`, etc.) to a date |
| `DATEDIFF(part, start, end)` | Returns the difference between two dates, in the given unit |
| `CONVERT(type, date, style)` | Converts/formats a date using a numeric style code |
| `YEAR(date)` / `MONTH(date)` / `DAY(date)` | Extracts the year, month, or day part of a date |
| `EOMONTH(date)` | Returns the last day of the month for the given date |
| `DATENAME(part, date)` | Returns the name of a date part as text (e.g. `'April'`, `'Monday'`) |
| `ISDATE(value)` | Returns `1` if a value can be interpreted as a valid date, otherwise `0` |

```sql
SELECT GETDATE()                                AS CurrentDateTime;
SELECT DATEADD(DAY, 7, GETDATE())               AS NextWeek;
SELECT DATEDIFF(YEAR, '2000-01-01', GETDATE())  AS YearsPassed;
SELECT CONVERT(VARCHAR, GETDATE(), 23)          AS ShortDate;       -- 'YYYY-MM-DD'
SELECT YEAR('2001-04-12')                       AS BirthYear;       -- 2001
SELECT MONTH('2001-04-12')                      AS BirthMonth;      -- 4
SELECT EOMONTH('2001-04-12')                    AS EndOfMonth;      -- '2001-04-30'
SELECT DATENAME(WEEKDAY, '2001-04-12')          AS DayName;         -- 'Thursday'
```

---

## 3. Math Functions

| Function | What it does |
|---|---|
| `ABS(n)` | Returns the absolute (non-negative) value |
| `ROUND(n, d)` | Rounds `n` to `d` decimal places |
| `CEILING(n)` / `FLOOR(n)` | Rounds up / down to the nearest integer |
| `POWER(base, exp)` | Raises `base` to the power `exp` |
| `SQRT(n)` | Square root |
| `SIGN(n)` | Returns `-1`, `0`, or `1` depending on the sign of `n` |
| `RAND()` | Returns a pseudo-random float between 0 and 1 |

```sql
SELECT ABS(-15)          AS AbsoluteValue;   -- 15
SELECT ROUND(12.456, 2)  AS RoundedValue;    -- 12.46
SELECT CEILING(12.1)     AS CeilingValue;    -- 13
SELECT FLOOR(12.9)       AS FloorValue;      -- 12
```

---

## 4. Handling NULL Values

| Function | What it does |
|---|---|
| `ISNULL(expr, replacement)` | Returns `replacement` if `expr` is `NULL`, otherwise returns `expr` (SQL Server specific) |
| `COALESCE(expr1, expr2, ...)` | Returns the **first** non-`NULL` value in the list (ANSI standard) |
| `NULLIF(expr1, expr2)` | Returns `NULL` if `expr1 = expr2`, otherwise returns `expr1` |
| `IS NULL` / `IS NOT NULL` | Logical operators to check for missing data |

```sql
SELECT ISNULL(Email, 'no email on file')     AS EmailDisplay,
       COALESCE(Email, Phone, 'no contact')  AS BestContact
FROM dbo.Student;
```

---

## 5. Unique Identifier Functions (`NEWID()` & `NEWSEQUENTIALID()`)

SQL Server supports Globally Unique Identifiers (GUIDs) stored in columns of type `UNIQUEIDENTIFIER`.

| Function / Syntax | Output Type | Description / Performance Characteristics |
|---|---|---|
| `NEWID()` | `UNIQUEIDENTIFIER` | Generates a completely **random** 16-byte GUID value (e.g., `6F9619FF-8B86-D011-B42D-00C04FC964FF`). |
| `NEWSEQUENTIALID()` | `UNIQUEIDENTIFIER` | Generates a **sequential** GUID. Can only be used in `DEFAULT` table constraints. Reduces index fragmentation. |

### Code Examples:
```sql
-- Generate a GUID inline
SELECT NEWID() AS RandomGUID;

-- Using NEWID() in DEFAULT constraints
CREATE TABLE dbo.Orders (
    OrderID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Using NEWSEQUENTIALID() to reduce B-tree index fragmentation
CREATE TABLE dbo.HighVolumeOrders (
    OrderID UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    OrderDate DATETIME DEFAULT GETDATE()
);

-- Randomly shuffling/sorting query rows
SELECT TOP (1) StudentName 
FROM dbo.Student 
ORDER BY NEWID();
```

---

## 6. System & Identity Functions

| Function | What it does | Scope / Behavior |
|---|---|---|
| `SCOPE_IDENTITY()` | Returns last identity generated in current scope | **Safest choice** for application queries |
| `@@IDENTITY` | Returns last identity generated across any scope | Affected by triggers! |
| `IDENT_CURRENT('table')` | Returns last identity generated for table across all sessions | Session-independent |
| `IDENT_SEED('table')` | Returns configured seed value of identity column | N/A |
| `IDENT_INCR('table')` | Returns configured increment step of identity column | N/A |
| `DB_NAME()` | Returns current database name | System metadata |
| `USER_NAME()` | Returns current database user | Security metadata |
| `@@ROWCOUNT` | Returns rows affected by last statement | Session status |

```sql
INSERT INTO dbo.Student (StudentName, BirthDate, Score)
VALUES ('David Clark', '2001-09-15', 85.0);

SELECT 
    SCOPE_IDENTITY() AS NewStudentID,
    IDENT_CURRENT('dbo.Student') AS CurrentTableID,
    @@ROWCOUNT AS InsertedRows;
```

---

## 7. Practical Reporting Example

```sql
SELECT StudentName,
       UPPER(TRIM(StudentName))                          AS CleanedName,
       DATEDIFF(YEAR, BirthDate, GETDATE())               AS Age,
       ROUND(Score, 2)                                    AS ScoreRounded,
       COALESCE(Email, Phone, 'no contact')               AS BestContact,
       DB_NAME()                                          AS SourceDatabase
FROM dbo.Student;
```

---

## 8. Summary

- **String & Date Functions**: Format, extract, clean, and compute intervals.
- **NULL Handling**: `COALESCE` (portable) and `ISNULL` prevent unexpected missing data failures.
- **GUID Generation**: `NEWID()` generates random GUIDs (ideal for distributed systems or random sorting); `NEWSEQUENTIALID()` generates sequential GUIDs for low-fragmentation indexes.
- **Identity Functions**: `SCOPE_IDENTITY()` captures newly inserted IDs safely without trigger interference.

---

> 🔗 **See also**
> - [../../05_SQL_Core_Query_Toolkit/01_SELECT_WHERE_ORDER_BY/theory.md](../../05_SQL_Core_Query_Toolkit/01_SELECT_WHERE_ORDER_BY/theory.md)
> - [../../04_Constraints_and_Integrity/PK_FK_Unique_Check_Default/theory.md](../../04_Constraints_and_Integrity/PK_FK_Unique_Check_Default/theory.md)
