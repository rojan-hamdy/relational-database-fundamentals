-- ================================================================
-- Hands-on practice: Built-in Functions
-- (String, Date, Math, NULL Handling, System)
-- ================================================================

-- ----------------------------------------------------------------
-- 1. Setup — a deliberately messy table to clean up below
-- ----------------------------------------------------------------
CREATE TABLE Student (
    StudentID   INT PRIMARY KEY,
    StudentName NVARCHAR(100) NOT NULL,
    BirthDate   DATE NOT NULL,
    Score       DECIMAL(5,2) NOT NULL,
    Email       NVARCHAR(100) NULL,
    Phone       NVARCHAR(20)  NULL
);

INSERT INTO Student (StudentID, StudentName, BirthDate, Score, Email, Phone)
VALUES
    (1, 'alice smith',  '2001-04-12', 87.456, 'alice@mail.com', NULL),
    (2, 'Bob Khan',     '2000-11-02', 92.1,   NULL,             '010-555-1234'),
    (3, '  nora ali  ', '2002-01-30', 78.0,   'nora@mail.com',  NULL),
    (4, 'TARIQ HADI',   '1999-07-19', 65.333, NULL,             NULL);

-- Note the messy data on purpose: mixed casing, extra spaces, and
-- missing Email/Phone -- exactly what these functions are for.


-- ----------------------------------------------------------------
-- 2. String functions
-- ----------------------------------------------------------------
SELECT UPPER('database')         AS upper_name,
       LOWER('SQL SERVER')       AS lower_name,
       LEN('Performance')        AS name_length,
       CONCAT('Alice', ' ', 'Smith') AS full_name,
       TRIM('  nora ali  ')      AS trimmed,
       SUBSTRING('database', 1, 4) AS sub_part,
       LEFT('database', 4)       AS left_part,
       RIGHT('database', 4)      AS right_part,
       REPLACE('2024-01-01', '-', '/') AS replaced,
       CHARINDEX('base', 'database')   AS found_at;

-- Clean up the messy names in the table
SELECT StudentName,
       UPPER(TRIM(StudentName)) AS CleanedUpperName
FROM Student;

-- Expected:
-- alice smith    -> ALICE SMITH
-- Bob Khan       -> BOB KHAN
--   nora ali     -> NORA ALI   (extra spaces removed by TRIM)
-- TARIQ HADI     -> TARIQ HADI


-- ----------------------------------------------------------------
-- 3. Date functions
-- ----------------------------------------------------------------
SELECT GETDATE()                               AS current_datetime,
       DATEADD(day, 7, GETDATE())              AS next_week,
       DATEDIFF(YEAR, '2000-01-01', GETDATE()) AS years_passed,
       CONVERT(VARCHAR, GETDATE(), 23)         AS short_date,
       YEAR('2001-04-12')                      AS birth_year,
       MONTH('2001-04-12')                     AS birth_month,
       EOMONTH('2001-04-12')                   AS end_of_month,
       DATENAME(WEEKDAY, '2001-04-12')         AS day_name,
       ISDATE('2001-04-12')                    AS is_valid_date,
       ISDATE('not-a-date')                    AS is_invalid_date;

-- Compute each student's age
SELECT StudentName, BirthDate,
       DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age
FROM Student;


-- ----------------------------------------------------------------
-- 4. Math functions
-- ----------------------------------------------------------------
SELECT ABS(-100)          AS absolute_value,
       ROUND(15.785, 2)   AS rounded_value,
       CEILING(15.1)      AS ceiling_value,
       FLOOR(15.9)        AS floor_value,
       POWER(2, 3)        AS power_result,
       SQRT(81)           AS square_root,
       SIGN(-42)          AS sign_value;

-- Round every student's score to 1 decimal place
SELECT StudentName, Score, ROUND(Score, 1) AS ScoreRounded
FROM Student;


-- ----------------------------------------------------------------
-- 5. Handling NULL values
-- ----------------------------------------------------------------
SELECT ISNULL(NULL, 'N/A')            AS isnull_result,
       COALESCE(NULL, NULL, 'third')  AS coalesce_result,
       NULLIF(0, 0)                   AS nullif_result_null,
       NULLIF(5, 0)                   AS nullif_result_five;

-- Fill in missing contact info: prefer Email, fall back to Phone,
-- otherwise show a placeholder
SELECT StudentName,
       ISNULL(Email, 'no email on file')     AS EmailDisplay,
       COALESCE(Email, Phone, 'no contact')  AS BestContact
FROM Student;

-- Expected BestContact:
-- alice smith  -> alice@mail.com   (has email)
-- Bob Khan     -> 010-555-1234     (no email, falls back to phone)
-- nora ali     -> nora@mail.com    (has email)
-- TARIQ HADI   -> no contact       (both email and phone are NULL)

-- Common pitfall: this returns NO rows for Bob or Tariq, even though
-- their Email IS actually NULL -- never compare to NULL with '='
SELECT StudentName FROM Student WHERE Email = NULL;      -- wrong
SELECT StudentName FROM Student WHERE Email IS NULL;      -- correct


-- ----------------------------------------------------------------
-- 6. System & GUID / Identity functions
-- ----------------------------------------------------------------
SELECT DB_NAME()      AS current_database,
       USER_NAME()    AS current_user,
       SUSER_NAME()   AS login_name,
       HOST_NAME()    AS client_machine,
       @@VERSION      AS sql_version,
       @@SERVERNAME   AS server_name,
       GETUTCDATE()   AS utc_now;

-- GUID & Identity Generation
SELECT NEWID() AS RandomGUID;

-- SCOPE_IDENTITY() inspection
INSERT INTO Student (StudentID, StudentName, BirthDate, Score)
VALUES (5, 'Zane Grey', '2003-05-10', 88.0);

SELECT @@ROWCOUNT AS RowsInserted, SCOPE_IDENTITY() AS LastScopeID;


-- ----------------------------------------------------------------
-- 7. Putting it all together
-- ----------------------------------------------------------------
SELECT StudentName,
       UPPER(TRIM(StudentName))               AS CleanedName,
       DATEDIFF(YEAR, BirthDate, GETDATE())    AS Age,
       ROUND(Score, 2)                         AS ScoreRounded,
       COALESCE(Email, Phone, 'no contact')    AS BestContact,
       DB_NAME()                               AS SourceDatabase
FROM Student;


-- ================================================================
-- 8. Practice exercises -- write these yourself before checking notes
-- ================================================================

-- Exercise 1
-- Return each student's first name and last name as separate columns,
-- assuming StudentName is always "first last" (hint: CHARINDEX + LEFT/RIGHT
-- or SUBSTRING to split on the space).

-- Exercise 2
-- Add a column IsAdult that shows 'Yes' if a student is 18 or older
-- (based on Age) and 'No' otherwise (hint: CASE WHEN, or IIF()).

-- Exercise 3
-- Write a query that safely computes Score / NULLIF(SomeDivisor, 0)
-- for a divisor column you add yourself, and wrap the result in
-- ISNULL(..., 0) so a zero divisor shows 0 instead of NULL.

-- Exercise 4
-- Use FORMAT() to display Score as a percentage string, e.g. '87.46%'.

-- Exercise 5
-- Using sys.objects, list every user-defined function currently in
-- this database whose name contains the word 'Get'.
