USE hospital;

SELECT 
    *
FROM
    patients;
SELECT 
    *
FROM
    services_weekly;
SELECT 
    *
FROM
    staff_schedule;

-- Services with more than 100 patients
SELECT 
    service, COUNT(*) AS patient_count
FROM
    patients
GROUP BY service
HAVING COUNT(*) > 100;

-- Combining WHERE and HAVING
SELECT 
    service, COUNT(*) AS elderly_count
FROM
    patients
WHERE
    age >= 65
GROUP BY service
HAVING COUNT(*) > 20;

-- Filter groups after-- Multiple HAVING conditions
SELECT 
    service,
    AVG(satisfaction) AS avg_sat,
    COUNT(*) AS patient_count
FROM
    patients
GROUP BY service
HAVING AVG(satisfaction) > 80 AND COUNT(*) > 50;

-- 1. Find services that have admitted more than 500 patients in total.
SELECT 
    service, SUM(patients_admitted) AS total_patients
FROM
    services_weekly
GROUP BY service
HAVING SUM(patients_admitted) > 500;

-- 2. Show services where average patient satisfaction is below 75.
SELECT 
    service, AVG(satisfaction) AS avg_sat
FROM
    patients
GROUP BY service
HAVING AVG(satisfaction) < 75;

-- 3. List weeks where total staff presence across all services was less than 50.
SELECT 
    week, SUM(present) AS staff_attendance
FROM
    staff_schedule
GROUP BY service , week
HAVING SUM(present) < 50;

-- Daily Challenge:
-- Question: Identify services that refused more than 100 patients in total and had an average patient satisfaction below 80. Show service name, total refused, and average satisfaction.
SELECT 
    service,
    SUM(patients_refused) AS total_refused,
    AVG(patient_satisfaction) AS avg_sat
FROM
    services_weekly
WHERE
    patients_refused > 100
GROUP BY service
HAVING AVG(patient_satisfaction) < 80;