
DROP TABLE IF EXISTS select_projections_sample;

CREATE TABLE IF NOT EXISTS select_projections_sample (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    kind VARCHAR(127),
    size INTEGER
);

INSERT INTO select_projections_sample(name, kind, size)VALUES
    ('sample 1', 'A', 10),
    ('sample 2', 'A', 20),
    ('sample 3', 'B', 40),
    ('sample 4', 'C', 10),
    ('sample 5', 'C', 30),
    ('sample 6', 'C', 60);

-- select all columns
SELECT * FROM select_projections_sample;

-- select columns 'name' and 'size'
SELECT name, size FROM select_projections_sample;

-- select columns 'name' and 'size' with aliases (with and without 'AS' keyword)
SELECT name AS name_alias, size size_alias FROM select_projections_sample;

-- select with column modifications
SELECT
    UPPER(name),
    size * 10 AS increased_size,
    'sample' AS constant
FROM select_projections_sample;

-- select distinct by single column
SELECT DISTINCT kind FROM select_projections_sample;

-- select distinct by multiple columns
SELECT DISTINCT kind, size FROM select_projections_sample;

-- select from nested query
SELECT * FROM (SELECT name, size FROM select_projections_sample) AS table_alias;

-- select with ordering
SELECT * FROM select_projections_sample
ORDER BY
    kind,
    size + 10 DESC,
    name ASC;