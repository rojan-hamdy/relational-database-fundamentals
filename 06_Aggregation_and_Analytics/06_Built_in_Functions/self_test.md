# Self-Test — Built-in Functions (String, Date, Math, NULL Handling, System)

**Q1. What are built-in SQL functions used for?**
<details>
<summary>Show answer</summary>
They simplify common tasks such as string processing, date arithmetic, mathematical calculations, handling missing (NULL) data, and system lookups.
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

**Q4. Which function calculates the number of characters in a string?**
<details>
<summary>Show answer</summary>
LEN().
</details>

**Q5. What's the difference between LEFT()/RIGHT() and SUBSTRING()?**
<details>
<summary>Show answer</summary>
LEFT(str, n) and RIGHT(str, n) return the first/last n characters. SUBSTRING(str, start, length) extracts characters from anywhere in the string, starting at a given position for a given length.
</details>

**Q6. What does ROUND(12.456, 2) return, and how is it different from CEILING() or FLOOR()?**
<details>
<summary>Show answer</summary>
ROUND(12.456, 2) returns 12.46 — rounded to 2 decimal places. CEILING() always rounds up to the next integer and FLOOR() always rounds down, regardless of decimal places.
</details>

**Q7. What is the difference between ISNULL() and COALESCE()?**
<details>
<summary>Show answer</summary>
ISNULL(expr, replacement) takes exactly 2 arguments and is SQL Server–specific. COALESCE(expr1, expr2, ...) takes any number of arguments and returns the first non-NULL value; it's ANSI-standard, so it's more portable across database engines.
</details>

**Q8. What does NULLIF(a, b) do, and what's a common use case?**
<details>
<summary>Show answer</summary>
NULLIF(a, b) returns NULL if a equals b, otherwise returns a. A common use case is avoiding a divide-by-zero error: dividing by NULLIF(SomeCount, 0) turns a 0 divisor into NULL, so the division returns NULL instead of throwing an error.
</details>

**Q9. Why should you avoid writing `WHERE column = NULL`?**
<details>
<summary>Show answer</summary>
NULL represents an unknown value, so any comparison using = with NULL evaluates to unknown (treated as false), not true — even if the column is actually NULL. Use `IS NULL` or `IS NOT NULL` instead.
</details>

**Q10. Which function returns the current database name, and which returns the current user?**
<details>
<summary>Show answer</summary>
DB_NAME() returns the current database name; USER_NAME() returns the current database user. SUSER_NAME() returns the login name of the session, which can differ from the database user.
</details>

**Q11. What does @@ROWCOUNT return, and when would you check it?**
<details>
<summary>Show answer</summary>
It returns the number of rows affected by the last statement. It's commonly checked right after an INSERT, UPDATE, or DELETE to confirm how many rows were actually changed.
</details>

**Q12. If you're not sure a built-in function exists or don't remember its exact syntax, what are two ways to find out?**
<details>
<summary>Show answer</summary>
Use IntelliSense in SSMS/Azure Data Studio (type the name and pause, or select it and press Shift+F1 to open its docs page), or check the official Microsoft Learn "Built-in Functions (Transact-SQL)" reference page, which lists every function by category with exact syntax and return types.
</details>

**Q13. Why are built-in functions useful in SQL queries?**
<details>
<summary>Show answer</summary>
They reduce manual logic, make queries cleaner and more readable, and push common data-cleaning and calculation tasks into the database instead of application code.
</details>

---

## Quick revision

- **String** = UPPER, LOWER, CONCAT, LEN, TRIM, SUBSTRING, REPLACE, LEFT/RIGHT, CHARINDEX, FORMAT
- **Date** = GETDATE, DATEADD, DATEDIFF, CONVERT, YEAR/MONTH/DAY, EOMONTH, DATENAME, ISDATE
- **Math** = ROUND, ABS, CEILING/FLOOR, POWER, SQRT, SIGN, RAND
- **NULL handling** = ISNULL, COALESCE, NULLIF, IS NULL / IS NOT NULL
- **System** = DB_NAME, USER_NAME, SUSER_NAME, HOST_NAME, @@VERSION, @@SERVERNAME, @@ROWCOUNT, SCOPE_IDENTITY, GETUTCDATE, ERROR_MESSAGE
- **Finding more** = sys.objects / sys.parameters, IntelliSense + Shift+F1, Microsoft Learn docs
