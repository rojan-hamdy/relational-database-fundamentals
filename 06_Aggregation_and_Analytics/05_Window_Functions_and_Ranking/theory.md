# Window Functions & Ranking

> Status: ✅ Built as the analytical function lesson.

## Overview
Window functions perform calculations across a set of table rows related to the current row, without collapsing the result into a single row like aggregate functions do.

They are widely used in ranking, running totals, and comparisons across partitions.

---

## 1. ROW_NUMBER()

```sql
SELECT StudentName,
       ROW_NUMBER() OVER (ORDER BY Age DESC) AS RankNumber
FROM dbo.Student;
```

This assigns a unique sequential number to each row.

---

## 2. RANK() and DENSE_RANK()

```sql
SELECT StudentName, Age,
       RANK() OVER (ORDER BY Age DESC) AS RankValue,
       DENSE_RANK() OVER (ORDER BY Age DESC) AS DenseRankValue
FROM dbo.Student;
```

- `RANK()` leaves gaps for ties
- `DENSE_RANK()` keeps consecutive ranks

---

## 3. NTILE()

`NTILE(n)` divides rows into `n` roughly equal groups.

```sql
SELECT StudentName, Age,
       NTILE(4) OVER (ORDER BY Age) AS Quartile
FROM dbo.Student;
```

---

## 4. SUM() OVER()

```sql
SELECT StudentName, Salary,
       SUM(Salary) OVER (ORDER BY Salary) AS RunningTotal
FROM dbo.Employee;
```

This calculates a running total while preserving each row in the result.

---

## 5. PARTITION BY

```sql
SELECT DepartmentID, StudentName, Salary,
       ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS DeptRank
FROM dbo.Employee;
```

This ranks employees within each department separately.

---

## 6. Common use cases

- top-3 performers by department,
- running total of sales,
- ranking students by score,
- calculating moving metrics.

---

## 7. Key takeaways

Window functions let you:
- rank rows,
- compare rows to each other,
- compute running totals,
- partition results by groups.

> 💡 **Core idea**
> Window functions keep row-level detail while computing analytical values contextually across the set of rows related to the current row.

---

> 🔗 **See also**
> - [../01_Aggregate_Functions/theory.md](../01_Aggregate_Functions/theory.md)
> - [../06_Built_in_Functions/theory.md](../06_Built_in_Functions/theory.md)
