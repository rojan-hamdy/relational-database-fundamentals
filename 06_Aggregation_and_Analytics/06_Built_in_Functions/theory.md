# Built-in Functions (String, Date, Math, System)

## Overview
SQL Server includes many built-in functions that help with string manipulation, date operations, numeric calculations, and system metadata access.

---

## 1. String functions

```sql
SELECT UPPER('alice') AS UpperName;
SELECT LOWER('ALICE') AS LowerName;
SELECT LEN('database') AS NameLength;
SELECT CONCAT('Alice', ' ', 'Smith') AS FullName;
```

---

## 2. Date functions

```sql
SELECT GETDATE() AS CurrentDateTime;
SELECT DATEADD(DAY, 7, GETDATE()) AS NextWeek;
SELECT DATEDIFF(YEAR, '2000-01-01', GETDATE()) AS YearsPassed;
SELECT CONVERT(VARCHAR, GETDATE(), 23) AS ShortDate;
```

---

## 3. Math functions

```sql
SELECT ABS(-15) AS AbsoluteValue;
SELECT ROUND(12.456, 2) AS RoundedValue;
SELECT POWER(2, 3) AS PowerResult;
SELECT SQRT(81) AS SquareRoot;
```

---

## 4. System functions

```sql
SELECT DB_NAME() AS CurrentDatabase;
SELECT USER_NAME() AS CurrentUser;
SELECT @@VERSION AS SQLVersion;
```

---

## 5. Practical example

```sql
SELECT StudentName,
       UPPER(StudentName) AS UpperCaseName,
       DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age,
       ROUND(Score, 2) AS ScoreRounded
FROM dbo.Student;
```

---

## 6. Why functions matter

Built-in functions save time by reducing manual code and making queries more expressive. They are essential for reporting, transformation, and data validation.

---

## 7. Summary

SQL built-ins help you:
- reshape strings,
- work with dates,
- calculate values,
- access system context.

> 💡 **Core idea**
> Built-in functions simplify everyday SQL logic and make reporting and data processing far easier.

---

> 🔗 **See also**
> - [../01_Aggregate_Functions/theory.md](../01_Aggregate_Functions/theory.md)
> - [../05_Window_Functions_and_Ranking/theory.md](../05_Window_Functions_and_Ranking/theory.md)
