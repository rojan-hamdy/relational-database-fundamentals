-- ================================================================
-- Hands-on practice: Window Functions & Ranking
-- ================================================================

-- ----------------------------------------------------------------
-- 1. Setup
-- ----------------------------------------------------------------
CREATE TABLE StudentMarks (
    StudentID   INT PRIMARY KEY,
    StudentName NVARCHAR(100) NOT NULL,
    Subject     NVARCHAR(50)  NOT NULL,
    Score       INT NOT NULL
);

INSERT INTO StudentMarks (StudentID, StudentName, Subject, Score)
VALUES
    (1, 'Aisha',  'Math',    90),
    (2, 'Khalid', 'Math',    85),
    (3, 'Nora',   'Math',    90),
    (4, 'Omar',   'Science', 88),
    (5, 'Huda',   'Science', 92),
    (6, 'Sami',   'Science', 88),
    (7, 'Layla',  'Math',    75),
    (8, 'Tariq',  'Science', 92);

-- Added Sami, Layla, Tariq so every function below has enough rows
-- per subject to show ties, buckets, and neighbor rows clearly.


-- ----------------------------------------------------------------
-- 2. Ranking: ROW_NUMBER, RANK, DENSE_RANK
-- ----------------------------------------------------------------
SELECT StudentName, Subject, Score,
       ROW_NUMBER() OVER (PARTITION BY Subject ORDER BY Score DESC) AS RowNum,
       RANK()       OVER (PARTITION BY Subject ORDER BY Score DESC) AS SubjectRank,
       DENSE_RANK() OVER (PARTITION BY Subject ORDER BY Score DESC) AS SubjectDenseRank
FROM StudentMarks
ORDER BY Subject, Score DESC;

-- Expected (Math has a tie at 90; Science has a tie at 92 and at 88):
-- StudentName | Subject | Score | RowNum | SubjectRank | SubjectDenseRank
-- Aisha       | Math    | 90    | 1      | 1           | 1
-- Nora        | Math    | 90    | 2      | 1           | 1
-- Khalid      | Math    | 85    | 3      | 3           | 2
-- Layla       | Math    | 75    | 4      | 4           | 3
-- Huda        | Science | 92    | 1      | 1           | 1
-- Tariq       | Science | 92    | 2      | 1           | 1
-- Omar        | Science | 88    | 3      | 3           | 2
-- Sami        | Science | 88    | 4      | 3           | 2


-- ----------------------------------------------------------------
-- 3. Grouping: NTILE
-- ----------------------------------------------------------------
SELECT StudentName, Subject, Score,
       NTILE(2) OVER (PARTITION BY Subject ORDER BY Score DESC) AS ScoreHalf
FROM StudentMarks
ORDER BY Subject, Score DESC;

-- NTILE(2) splits each subject's students into a top half and bottom half
-- by score. With 4 students per subject, each half gets exactly 2.


-- ----------------------------------------------------------------
-- 4. Aggregation without collapsing rows: SUM() OVER
-- ----------------------------------------------------------------
SELECT StudentName, Subject, Score,
       SUM(Score) OVER (PARTITION BY Subject)                       AS SubjectTotal,
       SUM(Score) OVER (PARTITION BY Subject ORDER BY StudentID)    AS RunningTotalInSubject
FROM StudentMarks
ORDER BY Subject, StudentID;

-- SubjectTotal is the same value repeated for every row in that subject
-- (the whole partition is the window). RunningTotalInSubject grows row
-- by row because ORDER BY narrows the window to "this row and earlier".


-- ----------------------------------------------------------------
-- 5. Comparing to neighboring rows: LAG, LEAD
-- ----------------------------------------------------------------
SELECT StudentName, Subject, Score,
       LAG(Score, 1)  OVER (PARTITION BY Subject ORDER BY Score DESC) AS PrevScoreInSubject,
       LEAD(Score, 1) OVER (PARTITION BY Subject ORDER BY Score DESC) AS NextScoreInSubject,
       Score - LAG(Score, 1) OVER (PARTITION BY Subject ORDER BY Score DESC) AS DropFromPrev
FROM StudentMarks
ORDER BY Subject, Score DESC;

-- DropFromPrev shows how much lower each student's score is than the
-- student ranked just above them in the same subject. The top scorer
-- in each subject has no "previous" row, so PrevScoreInSubject and
-- DropFromPrev are both NULL for them.


-- ----------------------------------------------------------------
-- 6. Best/worst in group on every row: FIRST_VALUE, LAST_VALUE
-- ----------------------------------------------------------------
SELECT StudentName, Subject, Score,
       FIRST_VALUE(StudentName) OVER (
           PARTITION BY Subject ORDER BY Score DESC
       ) AS TopScorerInSubject,
       LAST_VALUE(StudentName) OVER (
           PARTITION BY Subject ORDER BY Score DESC
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS LowestScorerInSubject
FROM StudentMarks
ORDER BY Subject, Score DESC;

-- Every Math row shows the same TopScorerInSubject / LowestScorerInSubject,
-- and every Science row shows its own pair -- the frame clause on
-- LAST_VALUE is required, otherwise it just returns the current row.


-- ----------------------------------------------------------------
-- 7. Percentile position: PERCENT_RANK
-- ----------------------------------------------------------------
SELECT StudentName, Subject, Score,
       PERCENT_RANK() OVER (PARTITION BY Subject ORDER BY Score) AS PctRankInSubject
FROM StudentMarks
ORDER BY Subject, Score;

-- PctRankInSubject = (RANK - 1) / (rows_in_subject - 1), recalculated
-- separately for Math and Science. The lowest scorer in each subject
-- is 0.0, the highest is close to (or at) 1.0.


-- ================================================================
-- 8. Practice exercises -- write these yourself before checking notes
-- ================================================================

-- Exercise 1
-- Return only the top scorer per subject (use one of the ranking
-- functions above in a CTE, then filter).

-- Exercise 2
-- For each student, show how many points behind the subject's top
-- scorer they are (hint: FIRST_VALUE + subtraction).

-- Exercise 3
-- Using LAG(), flag which students improved compared to the student
-- ranked just above them within the same subject (should always be
-- FALSE here since we ordered by Score DESC -- try it ordered ASC
-- by StudentID instead to compare against enrollment order).

-- Exercise 4
-- Split all students (regardless of subject) into 3 NTILE buckets by
-- score, with no PARTITION BY. Compare the result to the partitioned
-- version in section 3 -- what changes and why?

-- Exercise 5
-- Add a new subject 'Art' with only one student. Re-run the
-- PERCENT_RANK query. What value does that student get, and why?
