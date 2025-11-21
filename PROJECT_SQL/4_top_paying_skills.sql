/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
    sd.skills as skill_name,
    round(AVG(jpf.salary_year_avg), 0) as avg_salary
    from job_postings_fact as jpf
    inner join skills_job_dim as skd
        on jpf.job_id = skd.job_id
    inner join skills_dim as sd
        on skd.skill_id = sd.skill_id
        where jpf.salary_year_avg is not null 
        and jpf.job_title_short ilike '%data analyst%'
        GROUP BY skill_name
        order by avg_salary DESC
        LIMIT 25;

[
  {
    "skill_name": "svn",
    "avg_salary": "400000"
  },
  {
    "skill_name": "solidity",
    "avg_salary": "179000"
  },
  {
    "skill_name": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skill_name": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skill_name": "golang",
    "avg_salary": "155000"
  },
  {
    "skill_name": "mxnet",
    "avg_salary": "149000"
  },
  {
    "skill_name": "dplyr",
    "avg_salary": "147633"
  },
  {
    "skill_name": "vmware",
    "avg_salary": "147500"
  },
  {
    "skill_name": "terraform",
    "avg_salary": "146734"
  },
  {
    "skill_name": "twilio",
    "avg_salary": "138500"
  },
  {
    "skill_name": "gitlab",
    "avg_salary": "134126"
  },
  {
    "skill_name": "kafka",
    "avg_salary": "129999"
  },
  {
    "skill_name": "puppet",
    "avg_salary": "129820"
  },
  {
    "skill_name": "keras",
    "avg_salary": "127013"
  },
  {
    "skill_name": "pytorch",
    "avg_salary": "125226"
  },
  {
    "skill_name": "perl",
    "avg_salary": "124686"
  },
  {
    "skill_name": "ansible",
    "avg_salary": "124370"
  },
  {
    "skill_name": "hugging face",
    "avg_salary": "123950"
  },
  {
    "skill_name": "tensorflow",
    "avg_salary": "120647"
  },
  {
    "skill_name": "cassandra",
    "avg_salary": "118407"
  },
  {
    "skill_name": "notion",
    "avg_salary": "118092"
  },
  {
    "skill_name": "atlassian",
    "avg_salary": "117966"
  },
  {
    "skill_name": "bitbucket",
    "avg_salary": "116712"
  },
  {
    "skill_name": "airflow",
    "avg_salary": "116387"
  },
  {
    "skill_name": "scala",
    "avg_salary": "115480"
  }
]
