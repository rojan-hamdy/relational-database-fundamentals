# JOINs (Inner, Outer, Cross, Self)

## Overview
A join combines rows from two or more tables based on a related column. This is one of the most important concepts in relational database design and query writing — it's how normalized, split-up data gets reassembled into a single, useful result set.

---

## 1. Why Joins Matter

Data is normally split across tables to reduce redundancy and improve structure. For example:
- `Student` table stores student details
- `Department` table stores department names
- A relationship connects the two using `DepartmentID`

Joins let us work with that connected data as one result set, instead of storing the department name repeatedly inside every student row.

### Sample Baseline Data

**`Department` Table**
| DepartmentID | DepartmentName |
| :--- | :--- |
| **10** | Computer Science |
| **20** | Mathematics |
| **40** | Physics |

**`Student` Table**
| StudentID | StudentName | DepartmentID |
| :--- | :--- | :--- |
| **1** | Alice | **10** |
| **2** | Bob | **20** |
| **3** | Charlie | **30** *(Does not exist in Department)* |
| **4** | Diana | **10** |
| **5** | Ethan | **`NULL`** *(No department assigned)* |

Notice on purpose:
- Charlie belongs to `DepartmentID 30`, which **does not exist** in `Department`.
- Ethan has **no department** at all (`NULL`).
- Physics (`DepartmentID 40`) exists but **has no students**.

---

## 2. Table Creation Setup

### T-SQL (SQL Server) & PostgreSQL Syntax (Identical)
```sql
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    DepartmentID INT NULL
);

INSERT INTO Department (DepartmentID, DepartmentName)
VALUES (10, 'Computer Science'),
       (20, 'Mathematics'),
       (40, 'Physics');

INSERT INTO Student (StudentID, StudentName, DepartmentID)
VALUES (1, 'Alice',   10),
       (2, 'Bob',     20),
       (3, 'Charlie', 30),
       (4, 'Diana',   10),
       (5, 'Ethan',   NULL);
```

---

## 3. INNER JOIN

**Returns only the rows that match in both tables.** If a row on either side has no match, it is left out entirely.

### SQL Syntax (Identical in T-SQL & PostgreSQL)
```sql
SELECT s.StudentName, d.DepartmentName
FROM Student AS s
INNER JOIN Department AS d
    ON s.DepartmentID = d.DepartmentID;
```

### Execution Result:
| StudentName | DepartmentName |
| :--- | :--- |
| **Alice** | Computer Science |
| **Bob** | Mathematics |
| **Diana** | Computer Science |

Charlie (`DepartmentID = 30`) and Ethan (`DepartmentID = NULL`) are excluded. Physics is excluded.

---

## 4. LEFT JOIN (LEFT OUTER JOIN)

**Returns every row from the left table, plus matching rows from the right table.** Where there is no match, the right table's columns return `NULL`.

### SQL Syntax (Identical in T-SQL & PostgreSQL)
```sql
SELECT s.StudentName, d.DepartmentName
FROM Student AS s
LEFT JOIN Department AS d
    ON s.DepartmentID = d.DepartmentID;
```

### Execution Result:
| StudentName | DepartmentName |
| :--- | :--- |
| **Alice** | Computer Science |
| **Bob** | Mathematics |
| **Charlie** | **`NULL`** |
| **Diana** | Computer Science |
| **Ethan** | **`NULL`** |

---

## 5. RIGHT JOIN (RIGHT OUTER JOIN)

**Returns every row from the right table, plus matching rows from the left table.**

### SQL Syntax (Identical in T-SQL & PostgreSQL)
```sql
SELECT s.StudentName, d.DepartmentName
FROM Student AS s
RIGHT JOIN Department AS d
    ON s.DepartmentID = d.DepartmentID;
```

### Execution Result:
| StudentName | DepartmentName |
| :--- | :--- |
| **Alice** | Computer Science |
| **Diana** | Computer Science |
| **Bob** | Mathematics |
| **`NULL`** | Physics |

---

## 6. FULL OUTER JOIN

**Returns every row from both tables**, matching them where possible and filling in `NULL` on whichever side has no match.

### SQL Syntax (Identical in T-SQL & PostgreSQL)
```sql
SELECT s.StudentName, d.DepartmentName
FROM Student AS s
FULL OUTER JOIN Department AS d
    ON s.DepartmentID = d.DepartmentID;
```

### Execution Result:
| StudentName | DepartmentName |
| :--- | :--- |
| **Alice** | Computer Science |
| **Bob** | Mathematics |
| **Charlie** | **`NULL`** |
| **Diana** | Computer Science |
| **Ethan** | **`NULL`** |
| **`NULL`** | Physics |

---

## 7. CROSS JOIN

**Returns every possible combination of rows from both tables** (Cartesian Product: $5 \times 3 = 15$ rows).

### SQL Syntax (Identical in T-SQL & PostgreSQL)
```sql
SELECT s.StudentName, d.DepartmentName
FROM Student AS s
CROSS JOIN Department AS d;
```

---

## 8. SELF JOIN

Joining a table **to itself** using aliases (e.g. finding mentors/managers).

### Setup & Query Syntax (Identical in T-SQL & PostgreSQL)
```sql
-- Querying Mentees and their Mentors
SELECT mentee.StudentName AS Mentee, mentor.StudentName AS Mentor
FROM Student AS mentee
LEFT JOIN Student AS mentor
    ON mentee.DepartmentID = mentor.DepartmentID 
   AND mentee.StudentID <> mentor.StudentID;
```

---

## 9. PostgreSQL Compatibility & Comparison

| Join Feature | SQL Server (T-SQL) | PostgreSQL | Notes |
| :--- | :--- | :--- | :--- |
| **`INNER`, `LEFT`, `RIGHT`, `FULL OUTER`, `CROSS`** | ✅ Supported | ✅ Supported | 100% standard ANSI SQL syntax in both engines. |
| **`USING (column_name)`** | ❌ Not Supported | ✅ Supported | PostgreSQL allows `LEFT JOIN Department USING (DepartmentID)`. SQL Server requires explicit `ON s.col = d.col`. |
| **Join Hints** | ✅ Supported (`OPTION (HASH JOIN)`) | ❌ Custom Hints Not Native | SQL Server lets developers force join algorithms (`LOOP`, `MERGE`, `HASH`). PostgreSQL uses query planner config flags (`enable_nestloop`, etc.). |

---

## 10. Summary Matrix

| Join Type | Included Rows |
| :--- | :--- |
| **`INNER JOIN`** | Only rows with matches in **both** tables |
| **`LEFT JOIN`** | **All** left table rows + matched right table rows (`NULL` if no match) |
| **`RIGHT JOIN`** | **All** right table rows + matched left table rows (`NULL` if no match) |
| **`FULL OUTER JOIN`** | **All** rows from **both** tables (complete union of matches & non-matches) |
| **`CROSS JOIN`** | Cartesian product ($N \times M$) of all rows |
| **`SELF JOIN`** | A table joined with itself to compare internal relationships |

---

> 🔗 **See also**
> - [../01_SELECT_WHERE_ORDER_BY/theory.md](../01_SELECT_WHERE_ORDER_BY/theory.md)
> - [../syntax_cheatsheet.md](../syntax_cheatsheet.md)
