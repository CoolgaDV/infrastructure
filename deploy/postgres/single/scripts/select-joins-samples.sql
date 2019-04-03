
DROP TABLE IF EXISTS select_joins_first_sample;
DROP TABLE IF EXISTS select_joins_second_sample;
DROP TABLE IF EXISTS select_joins_third_sample;

CREATE TABLE IF NOT EXISTS select_joins_third_sample (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    third_kind VARCHAR(127)
);

INSERT INTO select_joins_third_sample(name, third_kind) VALUES
    ('third sample 1', 'B'),
    ('third sample 2', 'B'),
    ('third sample 3', 'C');

CREATE TABLE IF NOT EXISTS select_joins_second_sample (
    id SERIAL PRIMARY KEY,
    third_sample_id INTEGER REFERENCES select_joins_third_sample (id),
    name VARCHAR(255),
    second_kind VARCHAR(127)
);

INSERT INTO select_joins_second_sample(third_sample_id, name, second_kind) VALUES
    (1, 'second sample 1', 'A'),
    (3, 'second sample 2', 'A'),
    (3, 'second sample 3', 'B');

CREATE TABLE IF NOT EXISTS select_joins_first_sample (
    id SERIAL PRIMARY KEY,
    second_sample_id INTEGER REFERENCES select_joins_second_sample (id),
    name VARCHAR(255),
    first_kind VARCHAR(127)
);

INSERT INTO select_joins_first_sample(second_sample_id, name, first_kind) VALUES
    (1, 'first sample 1', 'A'),
    (2, 'first sample 2', 'A'),
    (2, 'first sample 3', 'B'),
    (1, 'first sample 4', 'C'),
    (2, 'first sample 5', 'C'),
    (3, 'first sample 6', 'C');

-- cross join (Cartesian Product)
SELECT f.name first_name, s.name second_name
FROM select_joins_first_sample f
CROSS JOIN select_joins_second_sample s;

-- inner join
SELECT f.name first_name, s.name second_name
FROM select_joins_first_sample f
    INNER JOIN select_joins_second_sample s ON f.second_sample_id = s.id;

-- legacy inner join (not recommended to use)
SELECT f.name first_name, s.name second_name
FROM select_joins_first_sample f, select_joins_second_sample s
WHERE f.second_sample_id = s.id;

-- inner join with where condition
SELECT f.name first_name, s.name second_name
FROM select_joins_first_sample f
    INNER JOIN select_joins_second_sample s ON f.second_sample_id = s.id
WHERE s.second_kind = 'A';

-- inner join with three tables
SELECT f.name, s.name, t.name
FROM select_joins_first_sample f
    INNER JOIN select_joins_second_sample s ON f.second_sample_id = s.id
    INNER JOIN select_joins_third_sample t ON s.third_sample_id = t.id;

-- inner join with subquery
SELECT f.name, s.second_kind
FROM select_joins_first_sample f
    INNER JOIN (SELECT id, second_kind FROM select_joins_second_sample) s
        ON f.second_sample_id = s.id;

-- inner join with two references to the same table
SELECT f.name, s.name, se.second_kind
FROM select_joins_first_sample f
    INNER JOIN select_joins_second_sample s ON f.second_sample_id = s.id
    INNER JOIN select_joins_second_sample se ON f.second_sample_id = se.id;

-- inner join with self referencing (recursion)
SELECT f.name, fi.name
FROM select_joins_first_sample f
    INNER JOIN select_joins_first_sample fi ON f.second_sample_id = fi.id;

-- inner join with non-equality join condition
SELECT f.name, s.name
FROM select_joins_first_sample f
    INNER JOIN select_joins_second_sample s ON f.id > s.id;