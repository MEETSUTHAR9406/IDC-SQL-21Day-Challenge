USE hospital;

SELECT * FROM   services_weekly;

-- Find records with NULL events
SELECT *
FROM   services_weekly
WHERE  even IS NULL;

-- Find records with non-NULL events
SELECT *
FROM   services_weekly
WHERE  even IS NOT NULL;

-- Replace NULL with default value
SELECT service,
       week,
       COALESCE(even, 'No Event') AS event_status
FROM   services_weekly;

-- Count NULL values
SELECT Count(*)               AS total_rows,
       Count(even)            AS non_null_events,
       Count(*) - Count(even) AS null_events
FROM   services_weekly;

-- Filter excluding empties and NULLs
SELECT *
FROM   services_weekly
WHERE  even IS NOT NULL
       AND even != 'none';

-- 1. Find all weeks in services_weekly where no special event occurred.
SELECT week,
       even
FROM   services_weekly
WHERE  even IS NULL
        OR even = 'none';

-- 2. Count how many records have null or empty event values.
SELECT *
FROM   services_weekly
WHERE  even IS NULL
        OR even = 'none'
        OR even = '';

-- 3. List all services that had at least one week with a special event.
SELECT DISTINCT service
FROM   services_weekly
WHERE  even IS NOT NULL
       AND even != 'none';

-- Daily Challenge:
-- Question: Analyze the event impact by comparing weeks with events vs weeks without events. Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, and average staff morale. Order by average patient satisfaction descending.
SELECT CASE
         WHEN even IS NULL
               OR even = 'none' THEN 'No Event'
         ELSE 'With Event'
       END                       AS event_status,
       Count(*)                  AS total_weeks,
       Avg(patient_satisfaction) AS avg_sat,
       Avg(staff_morale)         AS avg_morale
FROM   services_weekly
GROUP  BY event_status
ORDER  BY avg_sat DESC; 