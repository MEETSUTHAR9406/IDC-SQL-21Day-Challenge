USE hospital;

SELECT * FROM patients;
SELECT * FROM services_weekly;
SELECT * FROM staff;

-- Count patients per service
SELECT service, COUNT(*) AS patient_count FROM patients GROUP BY service;

-- Multiple aggregates per group
SELECT
    service,
    COUNT(*) AS total_patients,
    AVG(age) AS avg_age,
    AVG(satisfaction) AS avg_satisfaction
FROM patients
GROUP BY service
ORDER BY total_patients DESC;

-- Group by multiple columns
SELECT 
    service,
    CASE
        WHEN age >= 65 THEN 'Senior'
        ELSE 'Adult'
    END AS age_group,
    COUNT(*) AS count
FROM
    patients
GROUP BY service , age_group;

-- 1. Count the number of patients by each service.
SELECT service, COUNT(*) AS total_patients FROM patients GROUP BY service;

-- 2. Calculate the average age of patients grouped by service.
SELECT service, AVG(age) AS avg_age FROM patients GROUP BY service;

-- 3. Find the total number of staff members per role.
SELECT role, COUNT(*) AS total_staff FROM staff GROUP BY role;

-- Daily Challenge:
-- Question: For each hospital service, calculate the total number of patients admitted, total patients refused, and the admission rate (percentage of requests that were admitted). Order by admission rate descending.
SELECT
    service,
    SUM(patients_admitted) AS total_admitted,
    SUM(patients_refused) AS total_refused,
    (SUM(patients_admitted) / (SUM(patients_admitted) + SUM(patients_refused)) * 100) AS admission_rate
FROM services_weekly
GROUP BY service
ORDER BY admission_rate DESC;