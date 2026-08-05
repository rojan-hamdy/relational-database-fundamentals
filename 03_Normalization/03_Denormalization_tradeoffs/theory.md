# Denormalization Tradeoffs

## Overview
Denormalization is the intentional process of combining tables or repeating data to improve read performance and simplify reporting. It is the opposite of normalization.

It is not a mistake or a failure of design. In many systems, it is a deliberate tradeoff.

---

## 1. Why denormalize?

A fully normalized database is excellent for integrity and consistency, but it may require many joins. In analytics-heavy systems, those joins can slow down reporting queries.

Denormalization can help when:
- reporting must be fast,
- read-heavy workloads dominate,
- aggregated results are needed frequently,
- operational data is staged for analytics.

---

## 2. Normalized vs denormalized

### Normalized design
```text
Customer -> CustomerID, Name
Order -> OrderID, CustomerID, Total
```

### Denormalized design
```text
OrderSummary -> OrderID, CustomerName, Total, OrderDate
```

The denormalized form avoids repeated joins at read time.

---

## 3. Benefits of denormalization

- fewer joins
- faster reads and reporting
- simpler query logic
- better performance for analytical dashboards

---

## 4. Risks of denormalization

- data duplication
- update anomalies
- more complex maintenance
- risk of inconsistency if not handled carefully

---

## 5. When to denormalize

Choose denormalization when:
- the system is read-heavy,
- reporting speed matters more than strict storage optimization,
- the data is historical or aggregated,
- the business accepts some redundancy for performance.

Choose normalization when:
- integrity and consistency matter most,
- transaction processing is the primary goal,
- the data model needs to support many updates.

---

## 6. Real-world example

A normalized sales model may store:
- Customers
- Orders
- OrderItems
- Products

A denormalized reporting table may store one row per order with customer name, product title, quantity, and total. That simplifies BI queries but duplicates information.

---

## 7. Data warehouse example

Data warehouses often intentionally denormalize dimensions and fact tables to make analytics easier and faster.

Example:
```sql
SELECT CustomerName, SUM(TotalAmount)
FROM SalesFact
GROUP BY CustomerName;
```

This is much faster than joining many normalized tables on every report.

---

## 8. Summary

Normalization improves integrity. Denormalization improves performance.

The best design depends on the workload:
- OLTP = usually normalized
- OLAP/data warehouse = often denormalized or star-schema oriented

> 💡 **Core idea**
> Denormalization is a deliberate performance tradeoff. It reduces complexity at read time but introduces redundancy and maintenance challenges.

---

> 🔗 **See also**
> - [../02_Normal_Forms_1NF_to_BCNF/theory.md](../02_Normal_Forms_1NF_to_BCNF/theory.md)
> - [../../02_Conceptual_and_Logical_Design/05_Conceptual_vs_Logical_vs_Physical/theory.md](../../02_Conceptual_and_Logical_Design/05_Conceptual_vs_Logical_vs_Physical/theory.md)
