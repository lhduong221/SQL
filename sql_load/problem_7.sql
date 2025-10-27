WITH remote_jobs AS(
    SELECT *
    FROM job_postings_fact
    WHERE job_location = 'Anywhere'
)
INNER JOIN skills_job_dim ON remote_jobs.job_id = skills_job_dim.job_id
SELECT * FROM remote_jobs
;


WITH temp AS(
    SELECT * 
    FROM skills_job_dim
    INNER JOIN job_postings_fact
    ON skills_job_dim.job_id = job_postings_fact.job_id
)
SELECT 
    skill_id,
    COUNT(*) AS total_remote_jobs
FROM
    temp
WHERE
    job_location = 'Anywhere'
GROUP BY
    skill_id
;


WITH temp AS(
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim
    INNER JOIN
        job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE
        job_location = 'Anywhere' AND
        job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)
SELECT
    skills,
    skill_count
FROM temp
INNER JOIN skills_dim ON temp.skill_id = skills_dim.skill_id
ORDER BY
    skill_count DESC


