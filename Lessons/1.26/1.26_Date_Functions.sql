SELECT
    job_posted_date::TIMESTAMPTZ AS timestamp,
    job_posted_date::DATE AS date,
    job_posted_date::TIME AS time
FROM job_postings_fact
LIMIT 10;

--EXTRACT
SELECT
    EXTRACT(YEAR FROM job_posted_date) AS job_posted_year,
    EXTRACT(MONTH FROM job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
GROUP BY
    EXTRACT(YEAR FROM job_posted_date),
    EXTRACT(MONTH FROM job_posted_date)
ORDER BY    job_posted_year,
job_posted_month;

-- DATE_TRUNC
SELECT
    job_posted_date,
    DATE_TRUNC('year', job_posted_date) AS truncated_year,
    DATE_TRUNC('quarter', job_posted_date) AS truncated_quater,
    DATE_TRUNC('month', job_posted_date) AS truncated_month,
    DATE_TRUNC('week', job_posted_date) AS truncated_week,
    DATE_TRUNC('day', job_posted_date) AS truncated_day,
    DATE_TRUNC('hour', job_posted_date) AS truncated_hour
FROM job_postings_fact
ORDER BY RANDOM()
LIMIT 10;


SELECT
    DATE_TRUNC('month', job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE 
    job_title_short = 'Data Engineer'
     AND EXTRACT(YEAR FROM job_posted_date) = 2024
GROUP BY
    DATE_TRUNC('month', job_posted_date)
ORDER BY
    job_posted_month;

-- AT TIME ZONE
SELECT
    '2026-08-02 00:00:00+00'::TIMESTAMPTZ AT TIME ZONE 'EST';

SELECT
    job_title_short,
    job_location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'WET'
FROM
    job_postings_fact
WHERE
    job_location LIKE 'Nigeria';


SELECT
    
    EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'WET') AS job_posted_hour,
    COUNT(job_id)
FROM
    job_postings_fact
WHERE
    job_location LIKE 'Nigeria'
GROUP BY 
    EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'WET')
    ORDER BY job_posted_hour;