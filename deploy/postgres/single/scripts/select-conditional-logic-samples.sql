
DROP TABLE IF EXISTS select_conditional_logic_sample;

CREATE TABLE IF NOT EXISTS select_conditional_logic_sample (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    kind VARCHAR(127),
    size INTEGER
);

INSERT INTO select_conditional_logic_sample(name, kind, size) VALUES
    ('sample 1', 'A', 10),
    ('sample 2', 'A', 20),
    ('sample 3', 'B', 40),
    ('sample 4', 'C', 10),
    ('sample 5', 'C', 30),
    ('sample 6', 'C', 60);

-- conditional logic by expressions
SELECT name,
    CASE
        WHEN size < 20 THEN 'small'
        WHEN name = 'sample 2' THEN 'none'
        WHEN size < 40 THEN 'medium'
        ELSE 'large'
    END size_category
FROM select_conditional_logic_sample;

-- conditional logic by value
SELECT name,
    CASE kind
        WHEN 'A' THEN 'kind A'
        WHEN 'B' THEN 'kind B'
    END kind_description
FROM select_conditional_logic_sample;