/*
Answer: What are the most optimal skills to learn 
(aka skills that are BOTH in high demand AND high-paying)?

- Identify skills in high demand for Data Analyst roles
- Identify skills with high average salaries for Data Analyst roles
- Focus on remote positions that list a salary
- Why?
    Targets skills that offer job security (high demand)
    AND strong financial reward (high salary).
    This gives strategic insight into which skills are worth learning
    for long-term data analytics career growth.
*/

-- CTE #1: Skills in high demand for Data Analyst jobs
WITH skills_demand AS (
    SELECT
        d_skills.skill_id,
        d_skills.skills AS skill_name,
        COUNT(d_map.skill_id) AS demand_count
    FROM job_postings_fact AS d_jobs
    INNER JOIN skills_job_dim AS d_map
        ON d_jobs.job_id = d_map.job_id
    INNER JOIN skills_dim AS d_skills
        ON d_map.skill_id = d_skills.skill_id
    WHERE d_jobs.job_title_short ILIKE '%data analyst%'
      AND d_jobs.job_work_from_home = TRUE
      AND d_jobs.salary_year_avg IS NOT NULL
    GROUP BY d_skills.skill_id, d_skills.skills
),

-- CTE #2: Average salary per skill for Data Analyst jobs
average_salary AS (
    SELECT
        s_skills.skill_id,
        s_skills.skills AS skill_name,
        ROUND(AVG(s_jobs.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact AS s_jobs
    INNER JOIN skills_job_dim AS s_map
        ON s_jobs.job_id = s_map.job_id
    INNER JOIN skills_dim AS s_skills
        ON s_map.skill_id = s_skills.skill_id
    WHERE s_jobs.salary_year_avg IS NOT NULL
      AND s_jobs.job_title_short ILIKE '%data analyst%'
      AND s_jobs.job_work_from_home = TRUE
    GROUP BY s_skills.skill_id, s_skills.skills
)

-- Final Output: Combine both CTEs using skill_id
SELECT
    SKD.skill_id,
    SKD.skill_name,
    SKD.demand_count,
    ASA.avg_salary
FROM skills_demand AS SKD
INNER JOIN average_salary AS ASA
    ON SKD.skill_id = ASA.skill_id
WHERE SKD.demand_count > 10
ORDER BY SKD.demand_count DESC, ASA.avg_salary DESC
LIMIT 10;


-- Optional shorter version (same logic, no CTEs)
SELECT
    sd.skill_id,
    sd.skills AS skill_name,
    COUNT(sjd.skill_id) AS demand_count,
    ROUND(AVG(jpf.salary_year_avg), 0) AS avg_salary

FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id

WHERE jpf.job_title_short ILIKE '%data analyst%'
    AND jpf.job_work_from_home = TRUE
    AND jpf.salary_year_avg IS NOT NULL

GROUP BY sd.skill_id, sd.skills
HAVING COUNT(sjd.skill_id) > 10
ORDER BY demand_count DESC, avg_salary DESC
LIMIT 25;

/*
Findings Summary:
These skills are both:
    - used often in Data Analyst job postings (high demand)
    - associated with high average salaries (high-paying)

This combination makes them the MOST valuable skills to learn.

Top results included:
- SQL (highest demand)
- Tableau & Python (high demand + strong salary)
- Power BI, R, SAS, Looker
- Cloud/Engineering skills like Snowflake, Azure, AWS
- Workflow tools like JIRA and Alteryx

Conclusion:
Technical analytics skills (SQL, Python),
data visualization tools (Tableau, Power BI),
and cloud/data engineering tools (Snowflake, Azure, AWS)
provide the strongest mix of job security + high salary.
*/
