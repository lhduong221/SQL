/* 
What are the top skills based on salary for Data Analyst roles? 
- Get average salary for each skills of Data Analyst roles 
-> Help reveal how different skills impact salary levels.
*/

SELECT
    skills,
    ROUND (AVG(salary_year_avg),1) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 10
