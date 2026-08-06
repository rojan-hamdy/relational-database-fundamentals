# Built-in Functions (String, Date, Math, NULL Handling, System)

## Overview
SQL Server includes many built-in functions that help with string manipulation, date operations, numeric calculations, handling missing (`NULL`) data, and accessing system metadata. They save you from writing manual logic and make queries far more expressive.

### Sample table used in the examples

`dbo.Student`

| StudentID | StudentName | BirthDate  | Score | Email | Phone |
|---|---|---|---|---|---|
| 1 | alice smith | 2001-04-12 | 87.456 | alice@mail.com | NULL |
| 2 | Bob Khan    | 2000-11-02 | 92.1   | NULL | 010-555-1234 |
| 3 |   nora ali  | 2002-01-30 | 78.0   | nora@mail.com | NULL |

Note the messy data on purpose: mixed casing, extra spaces, and missing `Email`/`Phone` values — this is the kind of data these functions are typically used to clean up.

---

## 1. String functions

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
| `FORMAT(value, format)` | Formats a value using a .NET-style format string (e.g. for display) |

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

**Cleaning the sample table's names:**

```sql
SELECT StudentName,
       UPPER(TRIM(StudentName)) AS CleanedUpperName
FROM dbo.Student;
```

| StudentName | CleanedUpperName |
|---|---|
| alice smith  | ALICE SMITH |
| Bob Khan     | BOB KHAN |
|   nora ali   | NORA ALI |

`TRIM` removes the stray leading/trailing spaces on `nora ali`, and `UPPER` standardizes casing — a very common combination before comparing or displaying names.

---

## 2. Date functions

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
SELECT ISDATE('2001-04-12')                     AS ValidDate;       -- 1
SELECT ISDATE('not-a-date')                     AS ValidDate;       -- 0
```

**Computing age from the sample table (assuming "today" is 2026-08-06):**

```sql
SELECT StudentName, BirthDate,
       DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age
FROM dbo.Student;
```

| StudentName | BirthDate | Age |
|---|---|---|
| alice smith | 2001-04-12 | 25 |
| Bob Khan    | 2000-11-02 | 25 |
| nora ali    | 2002-01-30 | 24 |

⚠️ `DATEDIFF(YEAR, ...)` counts calendar-year boundaries crossed, not full 365-day years — so someone born in December can show the "wrong" age for a few weeks after New Year's. For exact age, combine it with a check against the birthday's month/day.

---

## 3. Math functions

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
SELECT POWER(2, 3)       AS PowerResult;     -- 8
SELECT SQRT(81)          AS SquareRoot;      -- 9
SELECT SIGN(-42)         AS SignValue;       -- -1
```

**Rounding scores in the sample table:**

```sql
SELECT StudentName, Score, ROUND(Score, 1) AS ScoreRounded
FROM dbo.Student;
```

| StudentName | Score | ScoreRounded |
|---|---|---|
| alice smith | 87.456 | 87.5 |
| Bob Khan    | 92.1   | 92.1 |
| nora ali    | 78.0   | 78.0 |

---

## 4. Handling NULL values

Missing data is everywhere in real tables (see `Email`/`Phone` in the sample above). These functions let you substitute, detect, or branch on `NULL` without every downstream calculation silently breaking.

| Function | What it does |
|---|---|
| `ISNULL(expr, replacement)` | Returns `replacement` if `expr` is `NULL`, otherwise returns `expr`. SQL Server–specific, exactly 2 arguments. |
| `COALESCE(expr1, expr2, ...)` | Returns the **first** non-`NULL` value in the list. ANSI-standard, works with any number of arguments — prefer this for portability. |
| `NULLIF(expr1, expr2)` | Returns `NULL` if `expr1 = expr2`, otherwise returns `expr1`. Useful for turning a "sentinel" value (like `0` or `''`) into a real `NULL`. |
| `IS NULL` / `IS NOT NULL` | Comparison operators to test for `NULL` (never use `= NULL`, which always evaluates to unknown/false) |

```sql
SELECT ISNULL(NULL, 'N/A')            AS Result;   -- 'N/A'
SELECT ISNULL('value', 'N/A')         AS Result;   -- 'value'
SELECT COALESCE(NULL, NULL, 'third')  AS Result;   -- 'third'
SELECT NULLIF(0, 0)                   AS Result;   -- NULL
SELECT NULLIF(5, 0)                   AS Result;   -- 5
```

**Filling in missing contact info from the sample table:**

```sql
SELECT StudentName,
       ISNULL(Email, 'no email on file')     AS EmailDisplay,
       COALESCE(Email, Phone, 'no contact')  AS BestContact
FROM dbo.Student;
```

| StudentName | EmailDisplay | BestContact |
|---|---|---|
| alice smith | alice@mail.com | alice@mail.com |
| Bob Khan    | no email on file | 010-555-1234 |
| nora ali    | nora@mail.com | nora@mail.com |

`COALESCE` is especially handy here: it tries `Email` first, falls back to `Phone` if the email is missing, and only shows `'no contact'` if both are `NULL` — Bob has no email but does have a phone, so `BestContact` picks that up automatically.

**`NULLIF` example — avoiding a divide-by-zero:**

```sql
SELECT StudentName,
       Score / NULLIF(0, 0) AS UnsafeDivision  -- becomes Score / NULL = NULL, not an error
FROM dbo.Student;
```

Dividing by `NULLIF(SomeCount, 0)` is a common pattern: if `SomeCount` is `0`, `NULLIF` turns it into `NULL`, the division returns `NULL` instead of throwing a divide-by-zero error, and you can wrap the whole thing in `ISNULL(..., 0)` if you'd rather see `0` than `NULL`.

---

## 5. System functions

| Function | What it does |
|---|---|
| `DB_NAME()` | Returns the name of the current database |
| `USER_NAME()` | Returns the name of the current database user |
| `SUSER_NAME()` | Returns the login name of the current session |
| `HOST_NAME()` | Returns the name of the client machine that connected |
| `@@VERSION` | Returns the SQL Server version and build info |
| `@@SERVERNAME` | Returns the name of the server instance |
| `@@ROWCOUNT` | Returns the number of rows affected by the last statement |
| `SCOPE_IDENTITY()` | Returns the last identity (auto-increment) value generated in the current scope — safer than `@@IDENTITY` in triggers/multi-table scenarios |
| `GETUTCDATE()` | Returns the current date/time in UTC (useful for logging across time zones) |
| `ERROR_MESSAGE()` | Inside a `CATCH` block, returns the text of the error that was caught |

```sql
SELECT DB_NAME()         AS CurrentDatabase;
SELECT USER_NAME()       AS CurrentUser;
SELECT SUSER_NAME()      AS LoginName;
SELECT HOST_NAME()       AS ClientMachine;
SELECT @@VERSION         AS SQLVersion;
SELECT @@SERVERNAME      AS ServerName;
SELECT GETUTCDATE()      AS UtcNow;
```

**Logging who inserted a row and when, using system + date functions together:**

```sql
INSERT INTO dbo.AuditLog (TableName, ChangedBy, ChangedAtUtc)
VALUES ('Student', USER_NAME(), GETUTCDATE());

SELECT @@ROWCOUNT AS RowsInserted;  -- 1
```

This is a common pattern in audit tables: capture *who* made a change (`USER_NAME()`), *when* (`GETUTCDATE()` so all logs share one time zone), and confirm *how many rows* were affected (`@@ROWCOUNT`).

---

## 6. Practical example — combining all categories

```sql
SELECT StudentName,
       UPPER(TRIM(StudentName))                          AS CleanedName,
       DATEDIFF(YEAR, BirthDate, GETDATE())               AS Age,
       ROUND(Score, 2)                                    AS ScoreRounded,
       COALESCE(Email, Phone, 'no contact')               AS BestContact,
       DB_NAME()                                          AS SourceDatabase
FROM dbo.Student;
```

| StudentName | CleanedName | Age | ScoreRounded | BestContact | SourceDatabase |
|---|---|---|---|---|---|
| alice smith | ALICE SMITH | 25 | 87.46 | alice@mail.com | SchoolDB |
| Bob Khan    | BOB KHAN    | 25 | 92.10 | 010-555-1234   | SchoolDB |
| nora ali    | NORA ALI    | 24 | 78.00 | nora@mail.com  | SchoolDB |

One query, one pass over the table, and every messy or missing value is cleaned, computed, or substituted — this is the everyday shape of a reporting query.

---

## 9. How to discover details about other functions

The functions above are only a fraction of what SQL Server ships with. Instead of memorizing every one, it's more useful to know how to look them up when you need one you haven't used before.

### a) Ask the database itself

SQL Server exposes its own function catalog as system views you can query directly:

```sql
-- List every built-in and user-defined function, with its type
SELECT name, type_desc
FROM sys.objects
WHERE type IN ('FN', 'IF', 'TF', 'FS', 'FT')  -- scalar, inline table-valued, table-valued, CLR, etc.
ORDER BY name;

-- Search for functions whose name contains a keyword (e.g. all date-related ones)
SELECT name
FROM sys.objects
WHERE type IN ('FN', 'IF', 'TF')
  AND name LIKE '%DATE%';
```

```sql
-- Get the parameter list and return type of a specific function
SELECT p.name AS ParameterName, t.name AS DataType, p.is_output
FROM sys.parameters p
JOIN sys.types t ON p.system_type_id = t.system_type_id
WHERE p.object_id = OBJECT_ID('dbo.MyFunction');
```

Note: `sys.objects` mainly surfaces **user-defined** functions well; SQL Server's *built-in* functions (like `GETDATE`, `ROUND`, `COALESCE`) are part of the engine itself and won't all appear there — for those, the official docs (below) are the reliable source.

### b) Use SSMS / Azure Data Studio IntelliSense

- Start typing a function name and pause — IntelliSense shows a tooltip with its parameter list and a short description.
- Highlight a function name and press **Shift+F1** (SSMS) to jump straight to its documentation page in the browser.
- The **Object Explorer** → `Programmability` → `Functions` → `System Functions` node lists every built-in function grouped by category (String, Date and Time, Mathematical, System, etc.) for the connected SQL Server version.

### c) Check the official Microsoft documentation

The most complete and version-accurate reference is Microsoft Learn's **Built-in Functions (Transact-SQL)** page, organized by the same categories used in this document (String, Date and Time, Mathematical, Logical, System, Conversion, and more). It lists every function's exact syntax, arguments, return type, and compatibility notes per SQL Server version:
`https://learn.microsoft.com/en-us/sql/t-sql/functions/functions`

When in doubt about a function's exact behavior (especially edge cases like `NULL` handling, rounding direction, or locale-dependent formatting), check this page rather than assuming — behavior sometimes differs subtly between SQL Server versions or between SQL Server and other database engines (MySQL, PostgreSQL, Oracle).

### d) Quick sanity-check pattern

For any unfamiliar function, run it standalone with a couple of test values before using it in a real query — this is faster than reading docs for simple cases and confirms exact behavior (rounding, `NULL` handling, return type) in your specific SQL Server version:

```sql
SELECT SOME_FUNCTION('test input') AS Result;
```

---

## 10. Why functions matter
Built-in functions save time by reducing manual code and making queries more expressive. They are essential for reporting, data cleaning, validation, and safely handling incomplete data — pushing that logic into the database instead of application code.

---

## 11. Summary
SQL built-ins help you:
- reshape and clean strings,
- work with dates and calculate durations,
- calculate and round numeric values,
- substitute or detect missing (`NULL`) data safely,
- access system and session context.

> 💡 **Core idea**
> Built-in functions simplify everyday SQL logic — string cleanup, date math, number formatting, `NULL` handling, and system metadata — and make reporting and data processing far easier and more reliable.

---

> 🔗 **See also**
> - [../01_Aggregate_Functions/theory.md](../01_Aggregate_Functions/theory.md)
> - [../05_Window_Functions_and_Ranking/theory.md](../05_Window_Functions_and_Ranking/theory.md)
