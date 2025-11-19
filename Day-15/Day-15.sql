USE hospital;

-- Comprehensive service report with staff and schedules
SELECT 
    sw.service,
    sw.week,
    sw.patients_admitted,
    COUNT(DISTINCT s.staff_id) AS total_staff,
    SUM(CASE
        WHEN ss.present = 1 THEN 1
        ELSE 0
    END) AS staff_present
FROM
    services_weekly sw
        LEFT JOIN
    staff s ON sw.service = s.service
        LEFT JOIN
    staff_schedule ss ON s.staff_id = ss.staff_id
        AND sw.week = ss.week
WHERE
    sw.week = 10
GROUP BY sw.service , sw.week , sw.patients_admitted;

-- Patient admission with staff availability
SELECT 
    p.patient_id,
    p.name,
    p.service,
    p.arrival_date,
    COUNT(DISTINCT s.staff_id) AS assigned_staff,
    AVG(ss.present) AS avg_staff_presence
FROM
    patients p
        JOIN
    staff s ON p.service = s.service
        LEFT JOIN
    staff_schedule ss ON s.staff_id = ss.staff_id
GROUP BY p.patient_id , p.name , p.service , p.arrival_date;

-- 1. Join patients, staff, and staff_schedule to show patient service and staff availability.
SELECT 
    p.patient_id,
    p.name AS patient_name,
    p.service,
    s.staff_name,
    ss.week,
    ss.present AS staff_present
FROM
    patients p
        JOIN
    staff s ON p.service = s.service
        LEFT JOIN
    staff_schedule ss ON s.staff_id = ss.staff_id;
    
-- 2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
SELECT 
    sw.week,
    sw.service,
    sw.patients_admitted,
    sw.patients_refused,
    sw.patient_satisfaction,
    s.staff_name,
    ss.present AS staff_present
FROM
    services_weekly sw
        LEFT JOIN
    staff s ON sw.service = s.service
        LEFT JOIN
    staff_schedule ss ON s.staff_id = ss.staff_id
        AND sw.week = ss.week;
    
-- 3. Create a multi-table report showing patient admissions with staff information.
SELECT 
    p.patient_id,
    p.name AS patient_name,
    p.service,
    s.staff_name,
    s.role
FROM
    patients p
        JOIN
    staff s ON p.service = s.service;
    
-- Daily Challenge:
-- Question: Create a comprehensive service analysis report for week 20 showing: service name, total patients admitted that week, total patients refused, average patient satisfaction, count of staff assigned to service, and count of staff present that week. Order by patients admitted descending.
SELECT 
    sw.service,
    SUM(sw.patients_admitted) AS total_admitted,
    SUM(sw.patients_refused) AS total_refused,
    AVG(sw.patient_satisfaction) AS avg_satisfaction,
    COUNT(DISTINCT s.staff_id) AS staff_assigned,
    COUNT(ss.present) AS staff_present_week
FROM
    services_weekly sw
        LEFT JOIN
    staff s ON sw.service = s.service
        LEFT JOIN
    staff_schedule ss ON s.staff_id = ss.staff_id
        AND sw.week = ss.week
WHERE
    sw.week = 20
GROUP BY sw.service
ORDER BY total_admitted DESC;