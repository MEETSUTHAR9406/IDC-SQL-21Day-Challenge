USE hospital;

SELECT * FROM   patients;
SELECT * FROM   staff;
SELECT * FROM   services_weekly;

-- Get unique services
SELECT DISTINCT service
FROM   patients;

-- Unique combinations of service and age group
SELECT DISTINCT service,
                CASE
                  WHEN age < 18 THEN 'Pediatric'
                  WHEN age BETWEEN 18 AND 65 THEN 'Adult'
                  ELSE 'Senior'
                END AS age_group
FROM   patients;

-- Count distinct values
SELECT Count(DISTINCT service) AS unique_services
FROM   patients;

-- DISTINCT with multiple columns
SELECT DISTINCT service,
                arrival_date
FROM   patients
ORDER  BY service,
          arrival_date;

-- 1. List all unique services in the patients table.
SELECT DISTINCT service
FROM   patients;

-- 2. Find all unique staff roles in the hospital.
SELECT DISTINCT role
FROM   staff;

-- 3. Get distinct months from the services_weekly table.
SELECT DISTINCT month
FROM   services_weekly;

-- Daily Challenge:
-- Question: Find all unique combinations of service and event type from the services_weekly table where events are not null or none, along with the count of occurrences for each combination. Order by count descending.
SELECT DISTINCT service,
                even,
                Count(*) AS occurences
FROM   services_weekly
WHERE  even IS NOT NULL
       AND even <> ''
       AND even <> 'none'
GROUP  BY service,
          even
ORDER  BY occurences DESC; 