# JOINs (Inner, Outer, Cross, Self)

## Overview
A join combines rows from two or more tables based on a related column. This is one of the most important concepts in relational database design and query writing — it's how normalized, split-up data gets reassembled into a single, useful result set.

---

## 1. Why joins matter

Data is normally split across tables to reduce redundancy and improve structure. For example:
- `Student` table stores student details
- `Department` table stores department names
- A relationship connects the two using `DepartmentID`

Joins let us work with that connected data as one result set, instead of storing the department name repeatedly inside every student row.

### Sample tables used in every example below

`Department`

| DepartmentID | DepartmentName |
|---|---|
| 10 | Computer Science |
| 20 | Mathematics |
| 40 | Physics |

`Student`

| StudentID | StudentName | DepartmentID |
|---|---|---|
| 1 | Alice   | 10 |
| 2 | Bob     | 20 |
| 3 | Charlie | 30 |
| 4 | Diana   | 10 |
| 5 | Ethan   | NULL |

Notice on purpose:
- Charlie belongs to `DepartmentID 30`, which **doesn't exist** in `Department`.
- Ethan has **no department** at all (`NULL`).
- Physics (`DepartmentID 40`) exists but **has no students**.

This mismatched data is exactly what makes the difference between join types visible.

```sql
CREATE TABLE Department (
    DepartmentID   INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Student (
    StudentID    INT PRIMARY KEY,
    StudentName  VARCHAR(100),
    DepartmentID INT
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

## 2. INNER JOIN

**Returns only the rows that match in both tables.** If a row on either side has no match, it's left out entirely.

```sql
SELECT s.StudentName, d.DepartmentName
FROM Student AS s
INNER JOIN Department AS d
    ON s.DepartmentID = d.DepartmentID;
```

**Result:**

| StudentName | DepartmentName |
|---|---|
| Alice   | Computer Science |
| Bob     | Mathematics |
| Diana   | Computer Science |

Charlie (department 30 doesn't exist) and Ethan (`NULL` department) both **disappear** — they have no match. Physics also disappears since no student belongs to it. This is the most common join type: use it when you only want rows that have a valid relationship on both sides.

---

## 3. LEFT JOIN (LEFT OUTER JOIN)

**Returns every row from the left table, plus matching rows from the right table.** Where there's no match, the right table's columns come back as `NULL`.

```sql
SELECT s.StudentName, d.DepartmentName
FROM Student AS s
LEFT JOIN Department AS d
    ON s.DepartmentID = d.DepartmentID;
```

**Result:**

| StudentName | DepartmentName |
|---|---|
| Alice   | Computer Science |
| Bob     | Mathematics |
| Charlie | NULL |
| Diana   | Computer Science |
| Ethan   | NULL |

Every student appears — even Charlie and Ethan, whose `DepartmentName` shows `NULL` since neither has a valid match. Physics still doesn't appear, since it's not in the left table and has no students to bring it in.

**Typical use:** "show me all students, and their department if they have one" — i.e. keep everything from the primary/left table regardless of whether the related data exists.

---

## 4. RIGHT JOIN (RIGHT OUTER JOIN)

**Returns every row from the right table, plus matching rows from the left table.** The mirror image of `LEFT JOIN`.

```sql
SELECT s.StudentName, d.DepartmentName
FROM Student AS s
RIGHT JOIN Department AS d
    ON s.DepartmentID = d.DepartmentID;
```

**Result:**

| StudentName | DepartmentName |
|---|---|
| Alice   | Computer Science |
| Diana   | Computer Science |
| Bob     | Mathematics |
| NULL    | Physics |

Every department appears — including Physics, which has no students, so `StudentName` shows `NULL`. Charlie and Ethan disappear here, since they're not tied to a valid row in the right table.

💡 `RIGHT JOIN` is just `LEFT JOIN` with the tables swapped — most people default to always writing `LEFT JOIN` and reordering the `FROM`/`JOIN` tables instead, purely for readability consistency across a codebase.

---

## 5. FULL OUTER JOIN

**Returns every row from both tables**, matching them where possible and filling in `NULL` on whichever side has no match.

```sql
SELECT s.StudentName, d.DepartmentName
FROM Student AS s
FULL OUTER JOIN Department AS d
    ON s.DepartmentID = d.DepartmentID;
```

**Result:**

| StudentName | DepartmentName |
|---|---|
| Alice   | Computer Science |
| Bob     | Mathematics |
| Charlie | NULL |
| Diana   | Computer Science |
| Ethan   | NULL |
| NULL    | Physics |

This is the union of the `LEFT JOIN` and `RIGHT JOIN` results — nothing is dropped from either table. Charlie/Ethan appear with no department, and Physics appears with no student.

**Typical use:** data audits — e.g. finding every mismatch in both directions at once (orphaned students *and* empty departments) in a single query.

---

## 6. CROSS JOIN

**Returns every possible combination of rows from both tables** (a Cartesian product) — there's no `ON` condition at all.

```sql
SELECT s.StudentName, d.DepartmentName
FROM Student AS s
CROSS JOIN Department AS d;
```

**Result:** 5 students × 3 departments = **15 rows** (only the first few shown):

| StudentName | DepartmentName |
|---|---|
| Alice   | Computer Science |
| Alice   | Mathematics |
| Alice   | Physics |
| Bob     | Computer Science |
| Bob     | Mathematics |
| Bob     | Physics |
| ... | ... |

Every student is paired with every department, regardless of `DepartmentID`. Row count is always `(rows in table A) × (rows in table B)`.

> ⚠️ Use this carefully — result sets grow multiplicatively and can become enormous with larger tables (a 10,000-row table cross-joined with another 10,000-row table produces 100,000,000 rows).

**Typical use:** generating combinations on purpose — e.g. every product × every size/color variant, or a calendar table × every store location.

---

## 7. SELF JOIN

Not a distinct join *keyword* — a `SELF JOIN` is simply joining a table **to itself**, using table aliases to treat it as if it were two separate tables. Any of the join types above (`INNER`, `LEFT`, etc.) can be used this way.

**Example:** add a `ManagerID` column to `Student` (repurposed here as a "mentor" relationship) to demonstrate:

```sql
ALTER TABLE Student ADD MentorID INT NULL;

UPDATE Student SET MentorID = 1 WHERE StudentID IN (3, 4);  -- Charlie & Diana mentored by Alice
UPDATE Student SET MentorID = 2 WHERE StudentID = 5;        -- Ethan mentored by Bob
```

| StudentID | StudentName | DepartmentID | MentorID |
|---|---|---|---|
| 1 | Alice   | 10 | NULL |
| 2 | Bob     | 20 | NULL |
| 3 | Charlie | 30 | 1 |
| 4 | Diana   | 10 | 1 |
| 5 | Ethan   | NULL | 2 |

```sql
SELECT mentee.StudentName AS Mentee, mentor.StudentName AS Mentor
FROM Student AS mentee
LEFT JOIN Student AS mentor
    ON mentee.MentorID = mentor.StudentID;
```

**Result:**

| Mentee | Mentor |
|---|---|
| Alice   | NULL |
| Bob     | NULL |
| Charlie | Alice |
| Diana   | Alice |
| Ethan   | Bob |

The same `Student` table is aliased twice (`mentee` and `mentor`) so each row can be compared against another row in that same table. `LEFT JOIN` is used so students with no mentor (`NULL`) still show up.

**Typical use:** hierarchical or self-referencing data — employee/manager, category/parent-category, mentee/mentor, replies-to-a-comment.

---

## 8. Filtering with an OUTER JOIN — a common trap

Putting a filter on the *right-hand* table in the `WHERE` clause silently turns a `LEFT JOIN` back into something like an `INNER JOIN`, because `WHERE` runs after the join and drops any row where the filtered column is `NULL`.

```sql
-- Intention: "all students, and their department name if it's Computer Science"
-- What actually happens: non-CS students are removed entirely
SELECT s.StudentName, d.DepartmentName
FROM Student AS s
LEFT JOIN Department AS d
    ON s.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';   -- ⚠️ drops Bob, Charlie, Ethan
```

**Fix:** move the condition into the `ON` clause instead, so it's applied *during* the join rather than *after* it:

```sql
SELECT s.StudentName, d.DepartmentName
FROM Student AS s
LEFT JOIN Department AS d
    ON s.DepartmentID = d.DepartmentID
    AND d.DepartmentName = 'Computer Science';
```

**Result:**

| StudentName | DepartmentName |
|---|---|
| Alice   | Computer Science |
| Bob     | NULL |
| Charlie | NULL |
| Diana   | Computer Science |
| Ethan   | NULL |

Now every student still appears, and only Computer Science actually shows a department name — matching the original intention.

---

## 9. Example: assembling a query step by step

```sql
SELECT s.StudentName, d.DepartmentName
FROM Student AS s
LEFT JOIN Department AS d
    ON s.DepartmentID = d.DepartmentID;
```

Reading it in the order the engine effectively evaluates it:
1. `FROM Student AS s` — start with every row in `Student`.
2. `LEFT JOIN Department AS d ON s.DepartmentID = d.DepartmentID` — for each student row, look for a matching department; keep the student row either way, filling `NULL` if nothing matches.
3. `SELECT s.StudentName, d.DepartmentName` — pick which columns to return from the combined rows.

This produces the same 5-row result shown in section 3 above.

---

## 10. Key takeaways

| Join type | Keeps |
|---|---|
| `INNER JOIN` | Only rows that match in **both** tables |
| `LEFT JOIN` | **All** left rows, matched right ones if available (`NULL` otherwise) |
| `RIGHT JOIN` | **All** right rows, matched left ones if available (`NULL` otherwise) |
| `FULL OUTER JOIN` | **All** rows from **both** sides, matched where possible |
| `CROSS JOIN` | **Every combination** of rows — no matching condition at all |
| `SELF JOIN` | A table joined to **itself** — usually for hierarchical/self-referencing data |

> 💡 **Core idea**
> Joins let the database combine related data across tables while respecting the keys that connect them. Which join you pick determines what happens to *unmatched* rows — that's the whole decision.

---

> 🔗 **See also**
> - [../01_SELECT_WHERE_ORDER_BY/theory.md](../01_SELECT_WHERE_ORDER_BY/theory.md)
> - [../syntax_cheatsheet.md](../syntax_cheatsheet.md)
