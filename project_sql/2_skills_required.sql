/*
Getting the skills required for the top 10 paying Data Analyst jobs that offer remote work.
*/

WITH top_da_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND 
        salary_rate = 'year' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = 'TRUE'
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT *
FROM top_da_jobs
INNER JOIN skills_job_dim ON top_da_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY top_da_jobs.salary_year_avg DESC