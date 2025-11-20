/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT 
    sd.skills as skill_name,
    count(sjd.skill_id) as demand_count
from job_postings_fact 
INNER JOIN skills_job_dim as sjd on job_postings_fact.job_id = sjd.job_id
INNER JOIN skills_dim as sd on sjd.skill_id = sd.skill_id
where job_title_short ilike '%data analyst%' 
group by skill_name
ORDER BY demand_count DESC
LIMIT 5

--this result shows the top 5 most in-demand skills for data analysts(any job that has data anlasyst in it) based on job postings.
[
  {
    "skill_name": "sql",
    "demand_count": "110380"
  },
  {
    "skill_name": "excel",
    "demand_count": "75348"
  },
  {
    "skill_name": "python",
    "demand_count": "68409"
  },
  {
    "skill_name": "tableau",
    "demand_count": "56569"
  },
  {
    "skill_name": "power bi",
    "demand_count": "45482"
  }
]
--- this result shows the same top 5 most in-demand skills for data analysts but only for remote jobs.
*/
[
  {
    "skill_name": "sql",
    "demand_count": "9015"
  },
  {
    "skill_name": "python",
    "demand_count": "5384"
  },
  {
    "skill_name": "excel",
    "demand_count": "5311"
  },
  {
    "skill_name": "tableau",
    "demand_count": "4744"
  },
  {
    "skill_name": "power bi",
    "demand_count": "3070"
  }
]
