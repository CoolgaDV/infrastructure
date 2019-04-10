
DROP TABLE IF EXISTS select_joins_first_sample;
DROP TABLE IF EXISTS select_joins_second_sample;

CREATE TABLE IF NOT EXISTS select_joins_second_sample (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    second_kind VARCHAR(127)
);

INSERT INTO select_joins_second_sample(name, second_kind) VALUES
    ('second sample 1', 'A'),
    ('second sample 2', 'A'),
    ('second sample 3', 'B');

CREATE TABLE IF NOT EXISTS select_joins_first_sample (
    id SERIAL PRIMARY KEY,
    second_sample_id INTEGER REFERENCES select_joins_second_sample (id),
    name VARCHAR(255),
    first_kind VARCHAR(127)
);

INSERT INTO select_joins_first_sample(second_sample_id, name, first_kind) VALUES
    (1,     'first sample 1', 'A'),
    (2,     'first sample 2', 'A'),
    (null,  'first sample 3', 'B'),
    (1,     'first sample 4', 'C'),
    (null,  'first sample 5', 'C'),
    (3,     'first sample 6', 'C');

-- cross join (Cartesian Product)
SELECT f.name first_name, s.name second_name
FROM select_joins_first_sample f
    CROSS JOIN select_joins_second_sample s;

-- left outer join
SELECT f.name first_name, s.name second_name
FROM select_joins_first_sample f
    LEFT OUTER JOIN select_joins_second_sample s on f.first_kind = s.second_kind;

-- right outer join
SELECT f.name first_name, s.name second_name
FROM select_joins_second_sample s
         RIGHT OUTER JOIN select_joins_first_sample f on f.first_kind = s.second_kind;