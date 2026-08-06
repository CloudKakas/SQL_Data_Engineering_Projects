SELECT CHAR_LENGTH('Kakas');

SELECT LOWER('KAKAS');

SELECT UPPER('kakas');

SELECT LEFT('Kakas', 2);

SELECT RIGHT('Kakas', 2);

SELECT SUBSTRING('Kakas', 2, 3);

SELECT 'SQL' || '-' || 'Functions';

SELECT TRIM(' SQL ');

SELECT REPLACE('Kaka_s', '_', '.');

SELECT REGEXP_REPLACE('abdulmalikmusakaka@gmail.com', '^.*(@)', '\1');


-- Final Example - Cleanup this using TEXT Functions
WITH title_lower AS (
    SELECT
        job_title,
        LOWER(TRIM(job_title)) AS job_title_clean
    FROM job_postings_fact
)
SELECT
    job_title,
    CASE
      WHEN job_title_clean LIKE '%data%'
       AND job_title_clean LIKE '%analyst%' THEN 'Data Analyst'
      WHEN job_title_clean LIKE '%data%'
       AND job_title_clean LIKE '%scientist%' THEN 'Data Scientist'
      WHEN job_title_clean LIKE '%data%'
       AND job_title_clean LIKE '%engineer%' THEN 'Data Engineer'
      ELSE 'Other'
    END AS job_title_category
FROM title_lower
ORDER BY RANDOM()
LIMIT 30;

--NULLIF
SELECT NULLIF(5 + 5, 20);
SELECT NULLIF(5 + 5, 10);
SELECT NULLIF(20, 20);

SELECT
    NULLIF(salary_year_avg, 0),
    NULLIF(salary_hour_avg, 0)
FROM
    job_postings_fact
WHERE salary_year_avg IS NOT NULL OR salary_hour_avg IS NOT NULL
LIMIT 10;

-- COALESCE
SELECT COALESCE(NULL, 1, 2);

SELECT
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg * 2080)
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 10;

-- Final Example - Simplify with COALESCE
/*
WITH salaries AS (
    SELECT
        job_title_short,
        salary_year_avg,
        salary_hour_avg,
        CASE
            WHEN salary_year_avg IS NOT NULL THEN salary_year_avg
            WHEN salary_hour_avg IS NOT NULL THEN salary_hour_avg * 2080
            ELSE NULL
        END AS standardized_salary
    FROM job_postings_fact
)
*/
SELECT
    job_title_short,
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg * 2080) AS standardized_salary,
    CASE
        WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) IS NULL THEN 'Missing'
        WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) < 75800 THEN 'Low'
        WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) < 158000 THEN 'Mid'
        ELSE 'High'
    END AS salary_bucket
FROM salaries
ORDER BY standardized_salary DESC;