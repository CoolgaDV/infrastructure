
DROP TABLE IF EXISTS select_grouping_sample;

CREATE TABLE IF NOT EXISTS select_grouping_sample (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    kind VARCHAR(127),
    sub_kind VARCHAR(127),
    size INTEGER
);

INSERT INTO select_grouping_sample(name, kind, sub_kind, size) VALUES
    ('sample 1', 'A', 'D', 10),
    ('sample 2', 'A', 'E', 20),
    ('sample 3', 'B', 'F', 40),
    ('sample 4', 'C', 'J', 10),
    ('sample 5', 'C', 'J', 30),
    ('sample 6', 'C', 'K', 60),
    ('sample 6', 'C', 'K', null);

-- grouping by single field (same as distinct select)
SELECT kind FROM select_grouping_sample GROUP BY kind;

-- grouping with count aggregation
SELECT kind, COUNT(*) FROM select_grouping_sample GROUP BY kind;

-- grouping with aggregation filtering
SELECT kind, COUNT(*) FROM select_grouping_sample GROUP BY kind HAVING COUNT(*) > 1;

-- aggregation functions with default group
SELECT
    MAX(size),
    MIN(size),
    AVG(size),
    SUM(size),
    COUNT(size) count_size,
    COUNT(*) count_all
FROM select_grouping_sample;

-- using distinct filtering with aggregate functions
SELECT COUNT(kind) count_all, COUNT(DISTINCT kind) FROM select_grouping_sample;

-- using expressions with aggregate functions
SELECT MAX(size + 5) FROM select_grouping_sample;

-- using expressions for grouping
SELECT size % 30 FROM select_grouping_sample GROUP BY (size % 30);

-- grouping by multiple columns
SELECT kind, sub_kind FROM select_grouping_sample GROUP BY kind, sub_kind;

-- grouping with roll up
SELECT kind, sub_kind, SUM(size) FROM select_grouping_sample GROUP BY ROLLUP (kind, sub_kind);