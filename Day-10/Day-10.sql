USE hospital;

SELECT *
FROM   patients;

SELECT *
FROM   staff;

-- Categorize patient satisfaction
SELECT NAME,
       satisfaction,
       CASE
         WHEN satisfaction >= 90 THEN 'Excellent'
         WHEN satisfaction >= 75 THEN 'Good'
         WHEN satisfaction >= 60 THEN 'Fair'
         ELSE 'Needs Improvement'
       END AS satisfaction_category
FROM   patients;

-- Create age groups
SELECT NAME,
       age,
       CASE
         WHEN age < 18 THEN 'Pediatric'
         WHEN age BETWEEN 18 AND 65 THEN 'Adult'
         ELSE 'Senior'
       END AS age_group
FROM   patients;

-- Conditional aggregation
SELECT service,
       Count(*) AS TOTAL,
       Sum(CASE
             WHEN satisfaction >= 80 THEN 1
             ELSE 0
           END) AS high_satisfaction_count,
       Sum(CASE
             WHEN satisfaction < 60 THEN 1
             ELSE 0
           END) AS low_satisfaction_count
FROM   patients
GROUP  BY service;

-- 1. Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
SELECT NAME,
       satisfaction,
       CASE
         WHEN satisfaction >= 90 THEN 'High'
         WHEN satisfaction >= 75 THEN 'Medium'
         WHEN satisfaction >= 60 THEN 'Low'
         ELSE 'Very Low'
       END AS satisfaction_category
FROM   patients;

-- 2. Label staff roles as 'Medical' or 'Support' based on role type.
SELECT staff_name,
       role,
       service,
       CASE
         WHEN role IN ( 'doctor', 'nurse', 'surgeon' ) THEN 'Medical'
         ELSE 'Support'
       END AS role_category
FROM   staff;

-- Daily Challenge:
-- Question: Create a service performance report showing service name, total patients admitted, and a performance category based on the following: 'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65, otherwise 'Needs Improvement'. Order by average satisfaction descending.
SELECT service,
       Sum(patients_admitted)    AS total_admitted,
       Avg(patient_satisfaction) AS avg_satisfaction,
       CASE
         WHEN Avg(patient_satisfaction) >= 85 THEN 'Excellent'
         WHEN Avg(patient_satisfaction) >= 75 THEN 'Good'
         WHEN Avg(patient_satisfaction) >= 65 THEN 'Fair'
         ELSE 'Needs Improvement'
       END                       AS performance_category
FROM   services_weekly
GROUP  BY service
ORDER  BY avg_satisfaction DESC; 