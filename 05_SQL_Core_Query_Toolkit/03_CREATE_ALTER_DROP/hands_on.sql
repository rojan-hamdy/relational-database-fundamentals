-- Hands-on practice: CREATE, ALTER, DROP

CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName NVARCHAR(100) NOT NULL
);

ALTER TABLE Course
ADD Credits INT NOT NULL DEFAULT 3;

INSERT INTO Course (CourseID, CourseName, Credits)
VALUES (1, 'Database Design', 3), (2, 'SQL Queries', 4);

ALTER TABLE Course
ALTER COLUMN CourseName NVARCHAR(150) NOT NULL;

DROP TABLE IF EXISTS Course;
