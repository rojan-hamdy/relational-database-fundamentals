# Set Operators: UNION, UNION ALL, INTERSECT & EXCEPT

## Overview
Set operators combine the result sets of two or more independent `SELECT` queries into a single unified result set. Unlike `JOIN` operations (which combine columns horizontally), **Set Operators combine rows vertically**.

---

## 1. Baseline Data for Set Examples

**Table: `Customer`**
| CustomerID | Name | City |
| :--- | :--- | :--- |
| **1** | Alice | **Cairo** |
| **2** | Bob | **Alexandria** |
| **3** | Charlie | **Giza** |

**Table: `Supplier`**
| SupplierID | Name | City |
| :--- | :--- | :--- |
| **10** | Delta Corp | **Cairo** |
| **20** | Echo Ltd | **Luxor** |
| **30** | Foxtrot | **Giza** |

---

## 2. Standard Set Operators Syntax & Behavior

### A. `UNION` (Combines & Eliminates Duplicates)

#### T-SQL & PostgreSQL Syntax (Identical)
```sql
SELECT City FROM Customer
UNION
SELECT City FROM Supplier;
```

#### Execution Result:
`Alexandria`, `Cairo`, `Giza`, `Luxor` (Distinct cities combined across both tables).

---

### B. `UNION ALL` (Combines & Preserves Duplicates)

#### T-SQL & PostgreSQL Syntax (Identical)
```sql
SELECT City FROM Customer
UNION ALL
SELECT City FROM Supplier;
```

#### Execution Result:
`Cairo`, `Alexandria`, `Giza`, `Cairo`, `Luxor`, `Giza` (All 6 rows returned directly without duplicate filtering).

---

### C. `INTERSECT` (Common Distinct Rows)

#### T-SQL & PostgreSQL Syntax (Identical)
```sql
SELECT City FROM Customer
INTERSECT
SELECT City FROM Supplier;
```

#### Execution Result:
`Cairo`, `Giza` (Shared cities existing in both tables).

---

### D. `EXCEPT` (Difference - Left Set Minus Right Set)

#### T-SQL & PostgreSQL Syntax (Identical)
```sql
SELECT City FROM Customer
EXCEPT
SELECT City FROM Supplier;
```

#### Execution Result:
`Alexandria` (Cities present in `Customer` but NOT in `Supplier`).

---

## 3. PostgreSQL Comparison & Compatibility

| Set Operator | SQL Server (T-SQL) | PostgreSQL | Notes |
| :--- | :--- | :--- | :--- |
| **`UNION`** | ✅ Supported | ✅ Supported | 100% ANSI standard |
| **`UNION ALL`** | ✅ Supported | ✅ Supported | 100% ANSI standard |
| **`INTERSECT`** | ✅ Supported | ✅ Supported | 100% ANSI standard |
| **`EXCEPT`** | ✅ Supported | ✅ Supported | 100% ANSI standard (Called `MINUS` in Oracle) |
| **`INTERSECT ALL`** | ❌ Not Supported | ✅ Supported | PostgreSQL supports multiset intersection (`INTERSECT ALL`) |
| **`EXCEPT ALL`** | ❌ Not Supported | ✅ Supported | PostgreSQL supports multiset difference (`EXCEPT ALL`) |

---

## 4. Key Takeaways

- **UNION**: Vertical row stack with duplicate removal.
- **UNION ALL**: Vertical row stack retaining all duplicate rows (best performance).
- **INTERSECT**: Returns distinct shared rows.
- **EXCEPT**: Returns rows present in query 1 but absent in query 2.
- **Rule**: Number of columns and positional data types must match across all combined queries.
- **`ORDER BY`**: Placed strictly at the end of the entire statement.

---

> 🔗 **See also**
> - [../01_SELECT_WHERE_ORDER_BY/theory.md](../01_SELECT_WHERE_ORDER_BY/theory.md)
> - [../02_JOINS/theory.md](../02_JOINS/theory.md)
> - [../06_Subqueries/theory.md](../06_Subqueries/theory.md)
