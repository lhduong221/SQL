/*

COPY company_dim
FROM '/Users/duonglai/Desktop/SQL/csv_files/company_dim.csv'
DELIMITER ',' CSV HEADER;

COPY job_postings_fact
FROM '/Users/duonglai/Desktop/SQL/csv_files/job_postings_fact.csv'
DELIMITER ',' CSV HEADER;

COPY skills_dim
FROM '/Users/duonglai/Desktop/SQL/csv_files/skills_dim.csv'
DELIMITER ',' CSV HEADER;

COPY skills_job_dim
FROM '/Users/duonglai/Desktop/SQL/csv_files/skills_job_dim.csv'
DELIMITER ',' CSV HEADER;
*/


-- The code above didn't work on the server due to file path issues. Used the code below instead.

COPY company_dim
FROM '/tmp/csv_files/company_dim.csv'
DELIMITER E'\t'
CSV HEADER;

COPY job_postings_fact
FROM '/tmp/csv_files/job_postings_fact.csv'
DELIMITER E'\t'
CSV HEADER;

COPY skills_dim
FROM '/tmp/csv_files/skills_dim.csv'
DELIMITER E'\t'
CSV HEADER;


/*
COPY skills_job_dim
FROM '/tmp/csv_files/skills_job_dim.csv'
DELIMITER E'\t'
CSV HEADER;
*/

-- Fail because of duplicate rows. Need to clean the csv file first.

-- 1️⃣ staging table without PK
DROP TABLE IF EXISTS skills_job_dim_stg;
CREATE TEMP TABLE skills_job_dim_stg (job_id INT, skill_id INT);

-- 2️⃣ raw CSV load
COPY skills_job_dim_stg
FROM '/tmp/csv_files/skills_job_dim.csv'
WITH (FORMAT csv, DELIMITER E'\t', HEADER true);

-- 3️⃣ insert only unique pairs into real table
INSERT INTO skills_job_dim (job_id, skill_id)
SELECT DISTINCT job_id, skill_id
FROM skills_job_dim_stg
ON CONFLICT (job_id, skill_id) DO NOTHING;


SELECT * FROM company_dim;

SELECT * FROM job_postings_fact;

SELECT * FROM skills_dim;

SELECT * FROM skills_job_dim;


