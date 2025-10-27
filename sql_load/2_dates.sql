SELECT 
   COUNT(job_id),
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Scientist'
GROUP BY
    month
ORDER BY
    month;