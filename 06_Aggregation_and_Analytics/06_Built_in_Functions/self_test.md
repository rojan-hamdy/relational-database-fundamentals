# Self-Test — Built-in Functions (String, Date, Math, NULL Handling, System & GUIDs)

**Q1. What are built-in SQL functions used for?**

<details>
<summary>Show answer</summary>
They simplify common tasks such as string processing, date arithmetic, mathematical calculations, handling missing (NULL) data, generating GUIDs, and system lookups.
</details>

**Q2. Which function returns the current date and time?**

<details>
<summary>Show answer</summary>
GETDATE(). For UTC time (useful when logging across time zones), use GETUTCDATE() instead.
</details>

**Q3. Which function converts text to uppercase, and which removes leading/trailing spaces?**

<details>
<summary>Show answer</summary>
UPPER() converts to uppercase; TRIM() removes leading and trailing spaces. They're often combined, e.g. UPPER(TRIM(StudentName)), to clean up messy text data.
</details>

**Q4. What is the difference between `NEWID()` and `NEWSEQUENTIALID()`?**

<details>
<summary>Show answer</summary>
`NEWID()` generates a completely random 16-byte `UNIQUEIDENTIFIER` GUID (can be called anywhere). `NEWSEQUENTIALID()` generates sequential GUIDs to reduce B-tree index fragmentation and can only be used inside `DEFAULT` table constraints.
</details>

**Q5. How can you randomly shuffle query results or pick a random row?**

<details>
<summary>Show answer</summary>
By ordering by `NEWID()`, for example: `SELECT TOP (1) * FROM Student ORDER BY NEWID();`.
</details>

**Q6. What does `ROUND(12.456, 2)` return, and how is it different from `CEILING()` or `FLOOR()`?**

<details>
<summary>Show answer</summary>
ROUND(12.456, 2) returns 12.46 — rounded to 2 decimal places. CEILING() always rounds up to the next integer and FLOOR() always rounds down, regardless of decimal places.
</details>

**Q7. What is the difference between `ISNULL()` and `COALESCE()`?**

<details>
<summary>Show answer</summary>
ISNULL(expr, replacement) takes exactly 2 arguments and is SQL Server–specific. COALESCE(expr1, expr2, ...) takes any number of arguments and returns the first non-NULL value; it's ANSI-standard, so it's more portable across database engines.
</details>

**Q8. What does `NULLIF(a, b)` do, and what's a common use case?**

<details>
<summary>Show answer</summary>
NULLIF(a, b) returns NULL if a equals b, otherwise returns a. A common use case is avoiding a divide-by-zero error: dividing by NULLIF(SomeCount, 0) turns a 0 divisor into NULL, so the division returns NULL instead of throwing an error.
</details>

**Q9. What is the difference between `SCOPE_IDENTITY()` and `@@IDENTITY`?**

<details>
<summary>Show answer</summary>
`SCOPE_IDENTITY()` returns the last identity value generated in the current query/procedure scope. `@@IDENTITY` returns the last identity value generated anywhere in the current session (which can be changed by triggers inserting rows into audit tables).
</details>

**Q10. Which function returns the current database name, and which returns the current user?**

<details>
<summary>Show answer</summary>
DB_NAME() returns the current database name; USER_NAME() returns the current database user. SUSER_NAME() returns the login name of the session, which can differ from the database user.
</details>

---

## Quick revision

- **String** = UPPER, LOWER, CONCAT, LEN, TRIM, SUBSTRING, REPLACE, LEFT/RIGHT, CHARINDEX, FORMAT
- **Date** = GETDATE, DATEADD, DATEDIFF, CONVERT, YEAR/MONTH/DAY, EOMONTH, DATENAME, ISDATE
- **Math** = ROUND, ABS, CEILING/FLOOR, POWER, SQRT, SIGN, RAND
- **NULL handling** = ISNULL, COALESCE, NULLIF, IS NULL / IS NOT NULL
- **GUIDs** = NEWID() (random), NEWSEQUENTIALID() (sequential in DEFAULT constraint)
- **Identity** = SCOPE_IDENTITY(), @@IDENTITY, IDENT_CURRENT()
- **System** = DB_NAME, USER_NAME, SUSER_NAME, HOST_NAME, @@VERSION, @@SERVERNAME, @@ROWCOUNT, GETUTCDATE, ERROR_MESSAGE
