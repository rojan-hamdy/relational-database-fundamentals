# Aggregate Functions: COUNT, SUM, AVG, MIN, MAX & STRING_AGG

## Overview
Aggregate functions summarize multiple rows into a single scalar value. They ignore `NULL` values (except `COUNT(*)`) and serve as the core building blocks for data analysis, reporting, and dashboard queries.

---

## 1. Baseline Data for Aggregate Examples

**`Sales` Table**
| SaleID | ProductName | Amount |
| :--- | :--- | :--- |
| **1** | Laptop | **1200.00** |
| **2** | Mouse | **25.00** |
| **3** | Keyboard | **60.00** |
| **4** | Monitor | **400.00** |
| **5** | Cable | **`NULL`** *(Pending price)* |

---

## 2. Standard Aggregate Functions

### A. `COUNT()`
Counts the total number of rows or non-null column values.

```sql
SELECT 
    COUNT(*) AS TotalRows,        -- Returns 5 (Includes NULL row)
    COUNT(Amount) AS ValidPrices -- Returns 4 (Ignores NULL)
FROM Sales;
```

---

### B. `SUM()`, `AVG()`, `MIN()`, `MAX()`

Calculates totals, arithmetic means, minimums, and maximums across non-null values.

#### SQL Syntax (Identical in T-SQL & PostgreSQL)
```sql
SELECT 
    SUM(Amount) AS TotalRevenue,   -- 1200 + 25 + 60 + 400 = 1685.00
    AVG(Amount) AS AverageSale,    -- 1685.00 / 4 = 421.25 (Ignores NULL)
    MIN(Amount) AS LowestSale,     -- 25.00
    MAX(Amount) AS HighestSale     -- 1200.00
FROM Sales;
```

---

## 3. String Aggregation (`STRING_AGG`)

Concatenates column values from multiple rows into a single delimited string.

### SQL Server (2017+) & PostgreSQL Syntax (Identical)
```sql
SELECT STRING_AGG(ProductName, ', ') AS ProductList
FROM Sales;
```

#### Execution Result:
`Laptop, Mouse, Keyboard, Monitor, Cable`

---

## 4. PostgreSQL Comparison & Compatibility

| Aggregate Function | SQL Server (T-SQL) | PostgreSQL | Notes |
| :--- | :--- | :--- | :--- |
| **`COUNT(*) / COUNT(col)`** | ✅ Supported | ✅ Supported | Identical syntax |
| **`SUM(), AVG(), MIN(), MAX()`**| ✅ Supported | ✅ Supported | Identical syntax |
| **`STRING_AGG(col, sep)`** | ✅ Supported (SQL Server 2017+) | ✅ Supported | Identical syntax |
| **Boolean Aggregations** | ❌ Requires `MAX(CASE ...)` | ✅ `EVERY()`, `BOOL_OR()` | PostgreSQL has native boolean aggregates |
| **Filter Clause in Aggregates**| ❌ Requires `CASE WHEN` | ✅ `SUM(Amount) FILTER (WHERE ...)` | PostgreSQL supports SQL:2003 `FILTER` clause |

---

## 5. Summary Matrix

| Function | Ignores `NULL`? | Purpose |
| :--- | :--- | :--- |
| **`COUNT(*)`** | No | Total row count in set |
| **`COUNT(col)`** | **Yes** | Count of non-null values in column |
| **`SUM(col)`** | **Yes** | Total numeric sum |
| **`AVG(col)`** | **Yes** | Mean average of non-null entries |
| **`MIN(col) / MAX(col)`** | **Yes** | Boundary minimum and maximum values |
| **`STRING_AGG(col, delim)`**| **Yes** | Concatenates values into delimited text |

---

> 🔗 **See also**
> - [../02_GROUP_BY_HAVING/theory.md](../02_GROUP_BY_HAVING/theory.md)
> - [../06_Built_in_Functions/theory.md](../06_Built_in_Functions/theory.md)
