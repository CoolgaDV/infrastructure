
DROP TABLE IF EXISTS select_subqueries_sample;

CREATE TABLE IF NOT EXISTS select_subqueries_sample (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    kind VARCHAR(127),
    size INTEGER
);

INSERT INTO select_subqueries_sample(name, kind, size)VALUES
    ('sample 1', 'A', 10),
    ('sample 2', 'A', 20),
    ('sample 3', 'B', 40),
    ('sample 4', 'C', 10),
    ('sample 5', 'C', 30),
    ('sample 6', 'C', 60);

-- scalar subquery
SELECT name FROM select_subqueries_sample
WHERE size = (SELECT MAX(size) FROM select_subqueries_sample);

-- vector subquery with 'IN' keyword
SELECT name FROM select_subqueries_sample
WHERE kind IN (SELECT DISTINCT kind FROM select_subqueries_sample WHERE size = 10);

-- vector subquery with 'ALL' keyword
SELECT name FROM select_subqueries_sample
WHERE size > ALL (SELECT DISTINCT size FROM select_subqueries_sample WHERE kind = 'A');

-- vector subquery with 'ANY' keyword
SELECT name FROM select_subqueries_sample
WHERE size > ANY (SELECT DISTINCT size FROM select_subqueries_sample WHERE kind = 'A');

-- table subquery
SELECT sub.name, sub.kind
FROM (SELECT name, kind FROM select_subqueries_sample WHERE size > 20) sub;

-- bound subquery
SELECT name FROM select_subqueries_sample first
WHERE EXISTS(SELECT 1 from select_subqueries_sample second WHERE second.size > first.size);

