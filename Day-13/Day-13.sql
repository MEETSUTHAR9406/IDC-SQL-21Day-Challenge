USE hospital;

SELECT * FROM patients;
SELECT * FROM staff;

-- Join patients with staff (same service)
SELECT 
    p.patient_id,
    p.name AS patient_name,
    p.service,
    s.staff_name,
    s.role
FROM
    patients p
        INNER JOIN
    staff s ON p.service = s.service
ORDER BY p.service , p.name;

-- Count staff per patient service
SELECT 
    p.patient_id,
    p.name,
    p.service,
    COUNT(s.staff_id) AS staff_count
FROM
    patients p
        INNER JOIN
    staff s ON p.service = s.service
GROUP BY p.patient_id , p.name , p.service;

-- Multiple join conditions
SELECT * FROM services_weekly sw INNER JOIN staff_schedule ss ON sw.service = ss.service AND sw.week = ss.week;

-- 1. Join patients and staff based on their common service field (show patient and staff who work in same service).
SELECT 
    p.patient_id,
    p.name AS patient_name,
    p.service,
    s.staff_name,
    s.role
FROM
    patients p
        INNER JOIN
    staff s ON p.service = s.service
ORDER BY p.service , p.name;

-- 2. Join services_weekly with staff to show weekly service data with staff information.
SELECT 
    sw.week,
    sw.month,
    sw.service,
    sw.patients_admitted,
    sw.patient_satisfaction,
    s.staff_name,
    s.role
FROM
    services_weekly sw
        INNER JOIN
    staff s ON sw.service = s.service
ORDER BY sw.week , sw.service;

-- 3. Create a report showing patient information along with staff assigned to their service.
SELECT 
    p.patient_id,
    p.name AS patient_name,
    p.age,
    p.service,
    s.staff_name AS assigned_staff,
    s.role
FROM
    patients p
        INNER JOIN
    staff s ON p.service = s.service
ORDER BY p.service , p.name;

-- Daily Challenge:
-- Question: Create a comprehensive report showing patient_id, patient name, age, service, and the total number of staff members available in their service. Only include patients from services that have more than 5 staff members. Order by number of staff descending, then by patient name.
SELECT 
    p.patient_id,
    p.name AS patient_name,
    p.age,
    p.service,
    sc.staff_total
FROM
    patients p
        JOIN
    (SELECT 
        service, COUNT(*) AS staff_total
    FROM
        staff
    GROUP BY service) sc ON p.service = sc.service
WHERE
    sc.staff_total > 5
ORDER BY sc.staff_total DESC , p.name ASC;