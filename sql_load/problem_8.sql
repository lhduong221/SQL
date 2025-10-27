WITH first_quarter_jobs AS(
    SELECT * FROM january_job_postings
    UNION ALL
    SELECT * FROM february_job_postings
    UNION ALL
    SELECT * FROM march_job_postings
)

SELECT * FROM first_quarter_jobs
WHERE salary_year_avg > 70000
ORDER BY salary_year_avg DESC;