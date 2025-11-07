USE hospital;

SELECT * FROM patients;
SELECT * FROM services_weekly;

-- COUNT Queries
SELECT COUNT(*) AS age_84 FROM patients WHERE age = 84;
SELECT age, COUNT(*) AS frequency FROM patients GROUP BY age ORDER BY frequency DESC;
SELECT ROUND(AVG(age), 2) AS avg_age FROM patients;
SELECT COUNT(DISTINCT service) AS unique_services FROM patients;

-- SUM Queries
SELECT SUM(available_beds) AS Score FROM services_weekly;

-- AVG Queries
SELECT AVG(age) AS AVG_AGE FROM patients;
SELECT age, AVG(satisfaction) AS sat_score FROM patients GROUP BY age ORDER BY age DESC;

-- MIN Queries
SELECT MIN(age) AS age_min FROM patients;
SELECT MIN(satisfaction) FROM patients;

-- MAX Queries
SELECT service, MAX(available_beds) AS max_beds FROM services_weekly GROUP BY service;

-- 1. Count the total number of patients in the hospital.
SELECT COUNT(*) AS total_patient FROM patients;

-- 2. Calculate the average satisfaction score of all patients.
SELECT AVG(satisfaction) AS sat_avg FROM patients;

-- 3. Find the minimum and maximum age of patients.
SELECT 
    MIN(age) AS min_age, MAX(age) AS max_age
FROM
    patients;

-- Daily Challenge:
-- Question: Calculate the total number of patients admitted, total patients refused, and the average patient satisfaction across all services and weeks. Round the average satisfaction to 2 decimal places.
SELECT 
    SUM(patients_admitted) AS total_admit,
    SUM(patients_refused) AS total_refused,
    ROUND(AVG(patient_satisfaction), 2)
FROM
    services_weekly;