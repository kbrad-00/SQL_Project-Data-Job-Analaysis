
# 📊 Data Analyst Job Market SQL Project

### *Exploring Salaries, Skills, and Market Demand Using Real Job Postings*

---

## 🚀 Table of Contents

* [Introduction](#introduction)
* [Background](#background)
* [Tools I Used](#tools-i-used)
* [The Analysis](#the-analysis)

  * [1. Top Paying Data Analyst Jobs](#1-top-paying-data-analyst-jobs)
  * [2. Skills for Top Paying Jobs](#2-skills-for-top-paying-jobs)
  * [3. In-Demand Skills for Data Analysts](#3-in-demand-skills-for-data-analysts)
  * [4. Skills Based on Salary](#4-skills-based-on-salary)
  * [5. Most Optimal Skills to Learn](#5-most-optimal-skills-to-learn)
* [What I Learned](#what-i-learned)
* [Conclusions](#conclusions)

---

## 📘 Introduction

This SQL project explores the 2023–2024 data job market, focusing specifically on **Data Analyst roles**.
The goal is to understand:

* 💰 Top-paying Data Analyst jobs
* 🔧 Skills required for top-paying roles
* 🔥 Most in-demand skills
* 📈 Skills associated with the highest salaries
* 🎯 Skills that balance *high demand + high salary*

All SQL scripts used in this analysis are stored in the **`PROJECT_SQL`** folder.

---

## 🏗 Background

The dataset contains:

* Job postings
* Company details
* Salary information
* Skills associated with each job

This project uses SQL to answer real job-market questions using joins, CTEs, aggregation, and filtering.

---

## 🛠 Tools I Used

* SQL (PostgreSQL)
* VS Code
* GitHub

---

# 🧠 The Analysis

---

## 1. Top Paying Data Analyst Jobs

```sql
/*
Question: What are the top-paying data analyst jobs?
*/
SELECT
    dim.name as company_name,
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact
LEFT JOIN company_dim AS dim ON dim.company_id = job_postings_fact.company_id
WHERE job_title_short ILIKE '%data analyst%'
  AND job_location = 'Anywhere'
  AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```

---

## 2. Skills for Top Paying Jobs

```sql
/*
Question: What skills are required for the top-paying data analyst jobs?
*/
WITH top_data_analyst_jobs AS (
    SELECT
        dim.name as company_name,
        job_id,
        job_title,
        salary_year_avg
    FROM job_postings_fact
    LEFT JOIN company_dim AS dim ON dim.company_id = job_postings_fact.company_id
    WHERE job_title_short ILIKE '%data analyst%'
      AND job_location = 'Anywhere'
      AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT 
    top_jobs.job_id,
    top_jobs.job_title,
    top_jobs.salary_year_avg,
    top_jobs.company_name,
    sd.skills as skill_name
FROM top_data_analyst_jobs AS top_jobs
INNER JOIN skills_job_dim AS skd ON skd.job_id = top_jobs.job_id
INNER JOIN skills_dim AS sd ON sd.skill_id = skd.skill_id
ORDER BY top_jobs.salary_year_avg DESC;
```

**Summary:**
Top-paying roles commonly require **SQL, Python, Tableau, R, Snowflake, Pandas, Excel**, and cloud tools like AWS/Azure.

---

## 3. In-Demand Skills for Data Analysts

```sql
/*
Question: What are the most in-demand skills for data analysts?
*/
SELECT 
    sd.skills as skill_name,
    COUNT(sjd.skill_id) as demand_count
FROM job_postings_fact 
INNER JOIN skills_job_dim AS sjd ON job_postings_fact.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE job_title_short ILIKE '%data analyst%' 
GROUP BY skill_name
ORDER BY demand_count DESC
LIMIT 5;
```

**Top 5 Skills (All Jobs):**

* SQL
* Excel
* Python
* Tableau
* Power BI

**Top 5 Skills (Remote Only):**

* SQL
* Python
* Excel
* Tableau
* Power BI

---

## 4. Skills Based on Salary

```sql
/*
Answer: What are the top skills based on salary?
*/
SELECT
    sd.skills as skill_name,
    ROUND(AVG(jpf.salary_year_avg), 0) as avg_salary
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as skd ON jpf.job_id = skd.job_id
INNER JOIN skills_dim as sd ON skd.skill_id = sd.skill_id
WHERE jpf.salary_year_avg IS NOT NULL
  AND jpf.job_title_short ILIKE '%data analyst%'
GROUP BY skill_name
ORDER BY avg_salary DESC
LIMIT 25;
```

**Highest-Paying Skills Include:**
SVN, Solidity, Couchbase, Datarobot, Golang, MXNet, Dplyr, Terraform, Twilio, Kafka.

These are specialized engineering / ML / cloud tools, showing that analysts with engineering-level skills earn more.

---

## 5. Most Optimal Skills to Learn

*(High demand + high salary)*

```sql
/*
Answer: What are the most optimal skills to learn?
*/
WITH skills_demand AS (
    SELECT
        d_skills.skill_id,
        d_skills.skills AS skill_name,
        COUNT(d_map.skill_id) AS demand_count
    FROM job_postings_fact AS d_jobs
    INNER JOIN skills_job_dim AS d_map ON d_jobs.job_id = d_map.job_id
    INNER JOIN skills_dim AS d_skills ON d_map.skill_id = d_skills.skill_id
    WHERE d_jobs.job_title_short ILIKE '%data analyst%'
      AND d_jobs.job_work_from_home = TRUE
      AND d_jobs.salary_year_avg IS NOT NULL
    GROUP BY d_skills.skill_id, d_skills.skills
),
average_salary AS (
    SELECT
        s_skills.skill_id,
        s_skills.skills AS skill_name,
        ROUND(AVG(s_jobs.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact AS s_jobs
    INNER JOIN skills_job_dim AS s_map ON s_jobs.job_id = s_map.job_id
    INNER JOIN skills_dim AS s_skills ON s_map.skill_id = s_skills.skill_id
    WHERE s_jobs.salary_year_avg IS NOT NULL
      AND s_jobs.job_title_short ILIKE '%data analyst%'
      AND s_jobs.job_work_from_home = TRUE
    GROUP BY s_skills.skill_id, s_skills.skills
)
SELECT
    SKD.skill_id,
    SKD.skill_name,
    SKD.demand_count,
    ASA.avg_salary  
FROM skills_demand AS SKD 
INNER JOIN average_salary AS ASA ON SKD.skill_id = ASA.skill_id
WHERE SKD.demand_count > 10
ORDER BY SKD.demand_count DESC, ASA.avg_salary DESC
LIMIT 10;
```

**Best Skills to Learn (High Demand + High Salary):**

* SQL
* Python
* Tableau
* Excel
* R
* Power BI
* SAS
* Looker
* Snowflake
* Oracle

These skills offer both **job security** and **strong compensation**.

---

# 🎓 What I Learned

* How to analyze job market data using SQL
* How skills translate to demand and salary
* How to use CTEs, joins, subqueries, and aggregations
* That SQL, Python, and Tableau consistently dominate the analytics field
* That engineering-adjacent tools can drastically increase salary potential

---

# ✅ Conclusions

* SQL is the most valuable skill across **demand**, **salary**, and **remote job** categories.
* Python, Tableau, Power BI, and Excel form the essential data analyst toolkit.
* Skills like Snowflake, Looker, SAS, R, and Oracle boost earning potential.
* Specialized engineering/ML cloud tools command top salaries but appear less frequently.
* The most strategic skill set blends analytics + BI + SQL + light engineering.

