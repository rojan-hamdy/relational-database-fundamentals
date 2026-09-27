-- Hands-on practice: PostgreSQL Bulk Import/Export via COPY & Commands
-- Purpose: test creating tables, populating data, and formatting COPY commands

DROP TABLE IF EXISTS customer;

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

INSERT INTO customer (customer_id, customer_name, city)
VALUES (1, 'Maya', 'Dubai'), (2, 'Samir', 'Riyadh');

SELECT * FROM customer;

-- Example COPY statements for exporting and importing CSV files:
-- Server-side export to CSV:
-- COPY customer TO '/tmp/customer_data.csv' WITH (FORMAT csv, HEADER);

-- Client-side export in psql:
-- \copy customer TO 'C:/temp/customer_data.csv' WITH (FORMAT csv, HEADER);

-- Client-side import in psql:
-- \copy customer FROM 'C:/temp/customer_data.csv' WITH (FORMAT csv, HEADER);
