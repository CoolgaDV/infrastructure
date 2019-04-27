
DROP TABLE IF EXISTS insert_sample;

CREATE TABLE IF NOT EXISTS insert_sample (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS insert_source_sample (
    id SERIAL PRIMARY KEY,
    source_name VARCHAR(255)
);

INSERT INTO insert_source_sample(source_name) VALUES
    ('sample 4'),
    ('sample 5');

-- insert single record
INSERT INTO insert_sample (name) VALUES ('sample 1');

-- insert multiple records
INSERT INTO insert_sample (name) VALUES
    ('sample 2'),
    ('sample 3');

-- insert from select
INSERT INTO insert_sample (name) SELECT source_name FROM insert_source_sample;

-- view results
SELECT * FROM insert_sample;