-- Hands-on practice: Import/Export via pgAdmin GUI Tools
-- Purpose: create sample table for pgAdmin Import/Export testing

DROP TABLE IF EXISTS import_source;

CREATE TABLE import_source (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    value NUMERIC(10,2) NOT NULL
);

INSERT INTO import_source (id, name, value)
VALUES (1, 'Alpha', 100.00), (2, 'Beta', 150.50);

SELECT * FROM import_source;

-- Instructions for pgAdmin GUI:
-- 1. Right-click table 'import_source' in pgAdmin Browser panel.
-- 2. Select 'Import/Export Data...'
-- 3. Set Direction = Export, Format = csv, Header = Yes.
-- 4. Specify filename and click OK to export.
