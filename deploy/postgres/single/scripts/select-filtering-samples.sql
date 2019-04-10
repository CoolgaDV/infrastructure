
DROP TABLE IF EXISTS select_filtering_sample;

CREATE TABLE IF NOT EXISTS select_filtering_sample (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    kind VARCHAR(127),
    size INTEGER
);

INSERT INTO select_filtering_sample(name, kind, size) VALUES
    ('sample 1', 'A', 10),
    ('sample 2', 'A', 20),
    ('sample 3', 'B', 40),
    ('sample 4', 'C', 10),
    ('sample 5', 'C', 30),
    ('sample 6', 'C', 60),
    ('sample 7', 'C', null);

-- filter by single field
SELECT * FROM select_filtering_sample WHERE kind = 'A';

-- filter using 'AND' keyword
SELECT * FROM select_filtering_sample WHERE kind = 'C' AND size = 30;

-- filter using 'OR' keyword
SELECT * FROM select_filtering_sample WHERE kind = 'C' OR size = 10;

-- filter using 'OR' and 'AND' keywords combination
SELECT * FROM select_filtering_sample WHERE kind = 'C' AND (name = 'sample 6' OR size = 10);

-- filter using 'NOT' keyword
SELECT * FROM select_filtering_sample WHERE kind = 'A' AND NOT name = 'sample 1';

-- filter using inequality
SELECT * FROM select_filtering_sample WHERE kind != 'A' AND size <> 60;

-- filter using column modification
SELECT * FROM select_filtering_sample WHERE size + 10 = 50;

-- filter using 'BETWEEN' keyword
SELECT * FROM select_filtering_sample WHERE size BETWEEN 20 AND 40;

-- filter using 'IN' keyword
SELECT * FROM select_filtering_sample WHERE name IN ('sample 1', 'sample 2');

-- filter using 'NOT IN' keyword
SELECT * FROM select_filtering_sample WHERE name NOT IN ('sample 1', 'sample 2');

-- filter using wildcards
SELECT * FROM select_filtering_sample WHERE name LIKE 'sam%' AND name LIKE 'sample _';

-- filter using regular expressions
SELECT * FROM select_filtering_sample WHERE name ~ 'sample [1-3]';

-- filer by 'NULL' values
SELECT * FROM select_filtering_sample WHERE size IS NULL;

-- filer by non 'NULL' values
SELECT * FROM select_filtering_sample WHERE size IS NOT NULL;