-- Hands-on practice: Import/Export via SSMS Wizard

CREATE TABLE ImportSource (
    ID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Value DECIMAL(10,2) NOT NULL
);

INSERT INTO ImportSource (ID, Name, Value)
VALUES (1, 'Alpha', 100.00), (2, 'Beta', 150.50);

SELECT * FROM ImportSource;

-- In SSMS, right-click a database -> Tasks -> Import Data / Export Data
-- to move the table to CSV, Excel, or another database.
