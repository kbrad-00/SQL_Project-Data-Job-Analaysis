/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/

SELECT
dim.name as company_name,
job_id,
job_title,
job_location,
job_schedule_type,
salary_year_avg,
job_posted_date
from job_postings_fact
left JOIN company_dim as dim on dim.company_id = job_postings_fact.company_id
WHERE  job_title_short ilike '%data analyst%'
AND job_location = 'Anywhere'
and salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
limit 10

