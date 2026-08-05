# Aggregate Functions

> Status: ✅ Built as the summary-statistics lesson.

## Overview
Aggregate functions summarize multiple rows into a single value. They are widely used in reporting, dashboards, and operational analysis.

Common aggregate functions include:
- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`

---

## 1. COUNT()

Counts the number of rows or non-null values.

```sql
SELECT COUNT(*)
FROM dbo.Student;
```

```sql
SELECT COUNT(Age)
FROM dbo.Student;
```

---

## 2. SUM()

Adds numeric values.

```sql
SELECT SUM(Amount)
FROM dbo.Sales;
```

---

## 3. AVG()

Calculates the arithmetic mean.

```sql
SELECT AVG(Amount)
FROM dbo.Sales;
```

---

## 4. MIN() and MAX()

Find the smallest and largest values.

```sql
SELECT MIN(Price) AS LowestPrice,
       MAX(Price) AS HighestPrice
FROM dbo.Product;
```

---

## 5. Example dataset

```sql
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Amount DECIMAL(10,2)
);

INSERT INTO Sales (SaleID, ProductName, Amount)
VALUES (1, 'Laptop', 1200.00),
       (2, 'Mouse', 25.00),
       (3, 'Keyboard', 60.00),
       (4, 'Monitor', 400.00);
```

```sql
SELECT COUNT(*) AS TotalSales,
       SUM(Amount) AS TotalRevenue,
       AVG(Amount) AS AvgSale,
       MIN(Amount) AS LowestSale,
       MAX(Amount) AS HighestSale
FROM dbo.Sales;
```

---

## 6. Key takeaways

Aggregate functions collapse many values into one meaningful summary:
- count records,
- total values,
- average values,
- identify min and max values.

> 💡 **Core idea**
> Aggregate functions are the building blocks of reporting and analytics queries.

---

> 🔗 **See also**
> - [../02_GROUP_BY_HAVING/theory.md](../02_GROUP_BY_HAVING/theory.md)
> - [../06_Built_in_Functions/theory.md](../06_Built_in_Functions/theory.md)
