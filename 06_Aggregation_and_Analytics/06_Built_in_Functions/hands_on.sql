-- Hands-on practice: Built-in Functions (String, Date, Math, System)

SELECT UPPER('database') AS upper_name,
       LOWER('SQL SERVER') AS lower_name,
       LEN('Performance') AS name_length,
       GETDATE() AS current_datetime,
       ROUND(15.785, 2) AS rounded_value;

SELECT DB_NAME() AS current_database,
       DATEADD(day, 7, GETDATE()) AS next_week,
       ABS(-100) AS absolute_value;
