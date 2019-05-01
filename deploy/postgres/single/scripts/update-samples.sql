
DROP TABLE IF EXISTS update_sample;

CREATE TABLE IF NOT EXISTS update_sample (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    kind VARCHAR(127)
);

INSERT INTO update_sample (name, kind) VALUES
    ('sample 1', 'A'),
    ('sample 2', 'A'),
    ('sample 3', 'B');

-- single field update example
UPDATE update_sample SET kind = 'D' WHERE name = 'sample 1';

-- multiple fields update example
UPDATE update_sample SET kind = 'E', name = 'sample 5' WHERE id = 2;

-- view results
SELECT * FROM update_sample;