
DROP TABLE IF EXISTS delete_sample;

CREATE TABLE IF NOT EXISTS delete_sample (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

INSERT INTO delete_sample (name) VALUES
    ('sample 1'),
    ('sample 2');

-- single record delete example
DELETE FROM delete_sample WHERE name = 'sample 2';

-- view results
SELECT * FROM delete_sample;