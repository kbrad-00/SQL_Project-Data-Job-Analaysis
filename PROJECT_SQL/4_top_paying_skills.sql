/*
Answer: What are the top skills based on salary?

Goal:
- Identify which skills are associated with the highest salaries for Data Analyst roles.
- We only look at postings that actually list a salary (salary_year_avg IS NOT NULL).
- We don’t limit by remote or location — this is ALL Data Analyst roles everywhere.

Why this matters:
- It shows which skills “push up” your salary the most.
- Some skills may not be used often, but when they ARE used, the pay is extremely high.
- This is useful for figuring out niche, high-value skills worth learning.

What the query does:
1. JOIN job postings → skills_job_dim (to know which job uses which skill)
2. JOIN again → skills_dim (to get the skill name)
3. Filter for “Data Analyst” roles only (using ILIKE so it picks up variations)
4. Only include jobs with a real salary number
5. GROUP BY skill_name → calculate the AVG salary for each skill
6. ORDER BY avg_salary DESC → highest paying skills at the top
7. LIMIT 25 → top 25 skills by salary
*/

SELECT
    sd.skills AS skill_name,
    ROUND(AVG(jpf.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS skd
    ON jpf.job_id = skd.job_id
INNER JOIN skills_dim AS sd
    ON skd.skill_id = sd.skill_id
WHERE jpf.salary_year_avg IS NOT NULL 
  AND jpf.job_title_short ILIKE '%data analyst%'
GROUP BY sd.skills
ORDER BY avg_salary DESC
LIMIT 25;


/*
Findings Summary (Natural Explanation):

This output shows something important:
The highest-paying “skills” aren’t always the common ones like SQL or Python.
Instead, niche or specialized tools shoot to the top because:
- only a few people know them
- they appear in very advanced or senior positions
- many are tied to machine learning, cloud engineering, or high-security systems

For example:
- svn ($400k)
- solidity ($179k)
- couchbase ($160k)
These aren’t typical BI/Data Analyst tools — they show up in hybrid engineering or blockchain roles.

The list also highlights strong ML frameworks:
- mxnet
- pytorch
- tensorflow
These appear in high-paying data science or ML-heavy analyst roles.

Even cloud + automation shows strong influence:
- terraform
- ansible
- puppet
- kafka
These skills often pair with analytics roles touching infrastructure or automation.

Key Insight:
This query helps answer:
“What SINGLE skill, when present in a Data Analyst job, correlates with the highest salaries?”

It doesn’t measure demand — only pay.  
Which means some skills pay a LOT but aren’t required often.

Final takeaway:
If you’re aiming for “high-salary niche expertise,”  
skills on this list (solidity, kafka, terraform, pytorch, etc.)  
push roles into $150k–$300k+ territory depending on niche and industry.
*/


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

