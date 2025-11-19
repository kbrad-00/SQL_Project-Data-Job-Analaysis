SELECT COUNT(*) AS posting_2023
FROM job_postings_fact
WHERE job_title_short ILIKE '%Engineer%'
  AND (salary_year_avg IS NOT NULL OR salary_hour_avg IS NOT NULL)
  AND job_posted_date >= DATE '2023-01-01'
  AND job_posted_date <  DATE '2024-01-01';
