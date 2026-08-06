# Set Operators: UNION, UNION ALL, INTERSECT & EXCEPT

## Overview
Set operators combine the result sets of two or more independent `SELECT` queries into a single unified result set. Unlike `JOIN` operations (which combine columns horizontally from multiple tables), **Set Operators combine rows vertically**.

SQL Server supports four primary set operators:
1. `UNION`
2. `UNION ALL`
3. `INTERSECT`
4. `EXCEPT`

---

## 1. Requirements & Rules for Set Operations

For any set operation to succeed, all queries involved must satisfy two strict structural rules:

1. **Equal Number of Columns**: Every `SELECT` statement must return the **exact same number of columns**.
2. **Compatible Data Types**: The columns in corresponding positions must have **compatible data types** (implicit conversion must be possible).

```sql
-- ❌ FAILS: Column count mismatch (2 columns vs 3 columns)
SELECT EmployeeID, Name FROM Employee
UNION
SELECT CustomerID, Name, City FROM Customer;

-- ✅ CORRECT: Corresponding positions have matching types
SELECT EmployeeID AS ID, Name, 'Employee' AS Role FROM Employee
UNION
SELECT CustomerID AS ID, Name, 'Customer' AS Role FROM Customer;
```

> ⚠️ **Column Names**: The resulting output uses the column names from the **first** `SELECT` query.

---

## 2. Visual Breakdown & Set Comparisons

Assuming Set A contains `{1, 2, 3}` and Set B contains `{3, 4, 5}`:

```text
       Set A                    Set B
   ┌───────────┐            ┌───────────┐
   │  1    2   │            │   4    5  │
   │       ┌───┼────────────┼───┐       │
   │       │ 3 │ INTERSECT  │ 3 │       │
   │       └───┼────────────┼───┘       │
   └───────────┘            └───────────┘
```

| Operator | Set Logic | Output for `{1, 2, 3}` & `{3, 4, 5}` | Duplicate Handling |
|---|---|---|---|
| **`UNION`** | Combines Set A + Set B | `{1, 2, 3, 4, 5}` | Removes duplicate rows |
| **`UNION ALL`** | Combines Set A + Set B | `{1, 2, 3, 3, 4, 5}` | **Retains** all duplicates |
| **`INTERSECT`** | Common to both Set A & Set B | `{3}` | Returns distinct shared rows |
| **`EXCEPT`** | Rows in Set A but NOT in Set B | `{1, 2}` | Returns distinct difference |

---

## 3. UNION vs UNION ALL

- `UNION` merges result sets and performs an implicit `DISTINCT` sort operation to eliminate duplicate rows.
- `UNION ALL` concatenates result sets directly **without checking for duplicates**.

### Code Example:
```sql
-- UNION (Removes duplicates, slower for massive datasets)
SELECT City FROM Customer
UNION
SELECT City FROM Supplier;

-- UNION ALL (Preserves duplicates, high performance)
SELECT City FROM Customer
UNION ALL
SELECT City FROM Supplier;
```

> 💡 **Performance Tip**: Always prefer `UNION ALL` over `UNION` unless you explicitly require duplicate removal. `UNION` forces a sort/aggregate execution step in query plans.

---

## 4. INTERSECT

`INTERSECT` returns only rows that appear in **both** result sets.

```sql
-- Find cities where we have BOTH customers AND suppliers
SELECT City FROM Customer
INTERSECT
SELECT City FROM Supplier;
```

### `INTERSECT` vs `INNER JOIN` (NULL Handling Difference)
- `INNER JOIN` ignores rows where join keys are `NULL` (`NULL = NULL` is UNKNOWN).
- `INTERSECT` treats two `NULL` values as **equal**, including `NULL` rows in the shared result!

---

## 5. EXCEPT

`EXCEPT` (known as `MINUS` in Oracle) returns distinct rows from the **left** query that do NOT exist in the **right** query.

```sql
-- Find cities where we have Customers but NO Suppliers
SELECT City FROM Customer
EXCEPT
SELECT City FROM Supplier;
```

> ⚠️ **Order Matters**: `QueryA EXCEPT QueryB` produces different results than `QueryB EXCEPT QueryA`.

---

## 6. Sorting Set Results (`ORDER BY` Placement)

You cannot place an `ORDER BY` clause inside individual `SELECT` queries of a set operation. The `ORDER BY` clause must appear **once at the very end** of the entire statement.

```sql
-- ✅ CORRECT: ORDER BY placed at the end of the entire set operation
SELECT PersonID, FullName, 'Employee' AS Type FROM Employee
UNION ALL
SELECT CustomerID, FullName, 'Customer' AS Type FROM Customer
ORDER BY FullName ASC;
```

---

## 7. Key Takeaways

- **UNION**: Merges rows + removes duplicates.
- **UNION ALL**: Merges rows + keeps duplicates (fastest performance).
- **INTERSECT**: Returns rows present in both sets (treats `NULL` as equal).
- **EXCEPT**: Returns rows in the first set that are absent in the second set.
- **Rule**: Column counts and positional data types must match across all queries.
- **Sorting**: `ORDER BY` belongs at the very end.

---

> 🔗 **See also**
> - [../01_SELECT_WHERE_ORDER_BY/theory.md](../01_SELECT_WHERE_ORDER_BY/theory.md)
> - [../02_JOINS/theory.md](../02_JOINS/theory.md)
> - [../06_Subqueries/theory.md](../06_Subqueries/theory.md)
> - [../syntax_cheatsheet.md](../syntax_cheatsheet.md)
