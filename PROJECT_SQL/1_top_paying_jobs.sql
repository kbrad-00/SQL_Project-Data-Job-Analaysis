/*
Question: what are the top paying data analysis jobs?
-Identify the top 10 paying data anlasyt roles that are available remotely.
-focus on the job postings with specified salary information(remove those with "not specified" salary info).
why? highlight the top paying opptunities for data analyst offering insight into employment trends and salary expectations in the field.
*/  

SELECT
job_id,
job_title,
job_location,
job_schedule_type,
salary_year_avg,
job_posted_date
from job_postings_facts 