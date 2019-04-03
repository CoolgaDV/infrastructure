
DROP TABLE IF EXISTS select_sets_first_sample;
DROP TABLE IF EXISTS select_sets_second_sample;

CREATE TABLE IF NOT EXISTS select_sets_first_sample (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    size INTEGER
);

CREATE TABLE IF NOT EXISTS select_sets_second_sample (
    id SERIAL PRIMARY KEY,
    second_name VARCHAR(255),
    size INTEGER
);

INSERT INTO select_sets_first_sample(first_name, size) VALUES
    ('sample 1', 30),
    ('sample 2', 20);

INSERT INTO select_sets_second_sample(second_name, size) VALUES
    ('sample 2', 20),
    ('sample 2', 40);

-- union (filters duplicates)
SELECT first_name, size FROM select_sets_first_sample
UNION
SELECT second_name, size FROM select_sets_second_sample;

-- union all (keep duplicates, works faster)
SELECT first_name, size FROM select_sets_first_sample
UNION ALL
SELECT second_name, size FROM select_sets_second_sample;

-- intersect
SELECT first_name, size FROM select_sets_first_sample
INTERSECT
SELECT second_name, size FROM select_sets_second_sample;

-- except
SELECT first_name, size FROM select_sets_first_sample
EXCEPT
SELECT second_name, size FROM select_sets_second_sample;