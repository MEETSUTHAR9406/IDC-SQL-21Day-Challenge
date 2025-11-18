USE hospital;

SELECT * FROM patients;
SELECT * FROM staff;

-- All staff with their schedule (including staff with no schedule)
SELECT 
    s.staff_id,
    s.staff_name,
    s.role,
    s.service,
    COUNT(ss.week) AS weeks_scheduled,
    SUM(COALESCE(ss.present, 0)) AS weeks_present
FROM
    staff s
        LEFT JOIN
    staff_schedule ss ON s.staff_id = ss.staff_id
GROUP BY s.staff_id , s.staff_name , s.role , s.service;

-- Find staff with NO schedule records
SELECT 
    s.*
FROM
    staff s
        LEFT JOIN
    staff_schedule ss ON s.staff_id = ss.staff_id
WHERE
    ss.staff_id IS NULL;
    
-- All services and their stats (even services with no patients)
SELECT 
    sw.service, sw.week, COUNT(p.patient_id) AS patient_count
FROM
    services_weekly sw
        LEFT JOIN
    patients p ON sw.service = p.service
GROUP BY sw.service , sw.week;

-- 1. Show all staff members and their schedule information (including those with no schedule entries).
SELECT 
    s.staff_id,
    s.staff_name,
    s.role,
    s.service,
    ss.week,
    ss.present
FROM
    staff s
        LEFT JOIN
    staff_schedule ss ON s.staff_id = ss.staff_id;

-- 2. List all services from services_weekly and their corresponding staff (show services even if no staff assigned).
SELECT 
    sw.week,
    sw.month,
    sw.service,
    sw.available_beds,
    sw.patients_request,
    sw.patients_admitted,
    sw.patients_refused,
    sw.patient_satisfaction,
    sw.staff_morale,
    s.staff_id,
    s.staff_name,
    s.role
FROM
    services_weekly sw
        LEFT JOIN
    staff s ON sw.service = s.service;

-- 3. Display all patients and their service's weekly statistics (if available).
SELECT 
    p.patient_id,
    p.name AS patient_name,
    p.age,
    p.service,
    sw.week,
    sw.month,
    sw.patients_admitted,
    sw.patients_refused,
    sw.patient_satisfaction,
    sw.staff_morale
FROM
    patients p
        LEFT JOIN
    services_weekly sw ON p.service = sw.service;

-- Daily Challenge:
-- Question: Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service) and the count of weeks they were present (from staff_schedule). Include staff members even if they have no schedule records. Order by weeks present descending.
SELECT 
    s.staff_id,
    s.staff_name,
    s.role,
    s.service,
    COUNT(ss.week) AS weeks_present
FROM
    staff s
        LEFT JOIN
    staff_schedule ss ON s.staff_id = ss.staff_id
GROUP BY s.staff_id , s.staff_name , s.role , s.service
ORDER BY weeks_present DESC;