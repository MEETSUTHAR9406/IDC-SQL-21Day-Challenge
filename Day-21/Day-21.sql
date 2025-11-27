USE hospital;

-- Simple CTE for service statistics
WITH service_stats AS (
    SELECT
        service,
        COUNT(*) AS patient_count,
        AVG(satisfaction) AS avg_satisfaction
    FROM patients
    GROUP BY service
)
SELECT *FROM service_stats
WHERE avg_satisfaction > 75 ORDER BY patient_count DESC;

-- Multiple CTEs for complex analysis
WITH
patient_metrics AS (
    SELECT
        service,
        COUNT(*) AS total_patients,
        AVG(age) AS avg_age,
        AVG(satisfaction) AS avg_satisfaction
    FROM patients
    GROUP BY service
),
staff_metrics AS (
    SELECT
        service,
        COUNT(*) AS total_staff
    FROM staff
    GROUP BY service
),
weekly_metrics AS (
    SELECT
        service,
        SUM(patients_admitted) AS total_admitted,
        SUM(patients_refused) AS total_refused
    FROM services_weekly
    GROUP BY service
)
SELECT
    pm.service,
    pm.total_patients,
    pm.avg_age,
    pm.avg_satisfaction,
    sm.total_staff,
    wm.total_admitted,
    wm.total_refused,
    ROUND(100.0 * wm.total_admitted /
          (wm.total_admitted + wm.total_refused), 2) AS admission_rate
FROM patient_metrics pm
LEFT JOIN staff_metrics sm ON pm.service = sm.service
LEFT JOIN weekly_metrics wm ON pm.service = wm.service
ORDER BY pm.avg_satisfaction DESC;

-- CTE referencing another CTE
WITH
all_admissions AS (
    SELECT
        service,
        SUM(patients_admitted) AS total
    FROM services_weekly
    GROUP BY service
),
high_performing_services AS (
    SELECT service
    FROM all_admissions
    WHERE total > (SELECT AVG(total) FROM all_admissions)
)
SELECT *FROM patients
WHERE service IN (SELECT service FROM high_performing_services);

-- 1. Create a CTE to calculate service statistics, then query from it.
WITH service_stats AS (
    SELECT 
        service,
        SUM(patients_admitted) AS total_admitted,
        SUM(patients_refused) AS total_refused,
        AVG(patient_satisfaction) AS avg_satisfaction
    FROM services_weekly
    GROUP BY service
)
SELECT * FROM service_stats;

-- 2. Use multiple CTEs to break down a complex query into logical steps.
WITH 
admissions AS (
    SELECT service, SUM(patients_admitted) AS total_admitted
    FROM services_weekly
    GROUP BY service
),
refusals AS (
    SELECT service, SUM(patients_refused) AS total_refused
    FROM services_weekly
    GROUP BY service
)
SELECT 
    a.service, 
    a.total_admitted, 
    r.total_refused
FROM admissions a
JOIN refusals r ON a.service = r.service;

-- 3. Build a CTE for staff utilization and join it with patient data.
WITH staff_util AS (
    SELECT 
        service,
        COUNT(*) AS staff_count
    FROM staff
    GROUP BY service
)
SELECT 
    p.patient_id,
    p.name AS patient_name,
    p.service,
    su.staff_count
FROM patients p
LEFT JOIN staff_util su ON p.service = su.service;

-- Daily Challenge:
-- Question: Create a comprehensive hospital performance dashboard using CTEs. Calculate: 1) Service-level metrics (total admissions, refusals, avg satisfaction), 2) Staff metrics per service (total staff, avg weeks present), 3) Patient demographics per service (avg age, count). Then combine all three CTEs to create a final report showing service name, all calculated metrics, and an overall performance score (weighted average of admission rate and satisfaction). Order by performance score descending.
WITH 
-- 1) Service-level metrics
service_metrics AS (
    SELECT 
        service,
        SUM(patients_admitted) AS total_admissions,
        SUM(patients_refused) AS total_refusals,
        AVG(patient_satisfaction) AS avg_satisfaction
    FROM services_weekly
    GROUP BY service
),

-- 2) Staff metrics per service
staff_metrics AS (
    SELECT 
        service,
        COUNT(*) AS total_staff,
        AVG(weeks_present) AS avg_weeks_present
    FROM (
        SELECT 
            staff_id,
            service,
            COUNT(*) AS weeks_present
        FROM staff_schedule
        WHERE present = 1
        GROUP BY staff_id, service
    ) AS staff_weeks
    GROUP BY service
),

-- 3) Patient demographics per service
patient_demographics AS (
    SELECT 
        service,
        AVG(age) AS avg_age,
        COUNT(*) AS total_patients
    FROM patients
    GROUP BY service
)

-- FINAL REPORT
SELECT 
    sm.service,

    sm.total_admissions,
    sm.total_refusals,
    sm.avg_satisfaction,

    stm.total_staff,
    stm.avg_weeks_present,

    pd.avg_age,
    pd.total_patients,

    -- Performance Score (weighted: 40% admissions + 60% satisfaction)
    (sm.total_admissions * 0.4 + sm.avg_satisfaction * 0.6) AS performance_score

FROM service_metrics sm
LEFT JOIN staff_metrics stm ON sm.service = stm.service
LEFT JOIN patient_demographics pd ON sm.service = pd.service
ORDER BY performance_score DESC;	