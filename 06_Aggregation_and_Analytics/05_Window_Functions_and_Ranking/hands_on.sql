-- Hands-on practice: Window Functions & Ranking

CREATE TABLE StudentMarks (
    StudentID INT PRIMARY KEY,
    StudentName NVARCHAR(100) NOT NULL,
    Subject NVARCHAR(50) NOT NULL,
    Score INT NOT NULL
);

INSERT INTO StudentMarks (StudentID, StudentName, Subject, Score)
VALUES
    (1, 'Aisha', 'Math', 90),
    (2, 'Khalid', 'Math', 85),
    (3, 'Nora', 'Math', 90),
    (4, 'Omar', 'Science', 88),
    (5, 'Huda', 'Science', 92);

SELECT StudentName, Subject, Score,
       ROW_NUMBER() OVER (PARTITION BY Subject ORDER BY Score DESC) AS RowNum,
       RANK() OVER (PARTITION BY Subject ORDER BY Score DESC) AS SubjectRank,
       SUM(Score) OVER (PARTITION BY Subject) AS SubjectTotal
FROM StudentMarks;
