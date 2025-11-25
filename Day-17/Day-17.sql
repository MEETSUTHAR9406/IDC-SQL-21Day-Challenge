USE hospital;

SELECT * FROM patients;
SELECT * FROM services_weekly;

-- Subquery in SELECT: Show each service's deviation from average
SELECT 
    service,
    COUNT(*) AS patient_count,
    COUNT(*) - (SELECT 
            AVG(service_count)
        FROM
            (SELECT 
                COUNT(*) AS service_count
            FROM
                patients
            GROUP BY service) AS sub) AS diff_from_avg
FROM
    patients
GROUP BY service;

-- Derived table: Service statistics
SELECT 
    service,
    total_admitted,
    CASE
        WHEN total_admitted > avg_admitted THEN 'Above Average'
        ELSE 'Below Average'
    END AS performance
FROM
    (SELECT 
        service,
            SUM(patients_admitted) AS total_admitted,
            (SELECT 
                    AVG(total)
                FROM
                    (SELECT 
                    SUM(patients_admitted) AS total
                FROM
                    services_weekly
                GROUP BY service) AS totals_table) AS avg_admitted
    FROM
        services_weekly
    GROUP BY service) AS service_stats;

-- Complex derived table with multiple calculations
SELECT 
    week_stats.*,
    overall.avg_satisfaction AS hospital_avg_satisfaction
FROM
    (SELECT 
        week,
            AVG(patient_satisfaction) AS weekly_avg_satisfaction,
            SUM(patients_admitted) AS weekly_admissions
    FROM
        services_weekly
    GROUP BY week) AS week_stats
        CROSS JOIN
    (SELECT 
        AVG(patient_satisfaction) AS avg_satisfaction
    FROM
        services_weekly) AS overall;
        
-- 1. Show each patient with their service's average satisfaction as an additional column.
SELECT 
    p.patient_id,
    p.name,
    p.service,
    p.satisfaction AS personal_satisfaction,
    (SELECT 
            AVG(p2.satisfaction)
        FROM
            patients p2
        WHERE
            p2.service = p.service) AS service_avg_satisfaction
FROM
    patients p;

-- 2. Create a derived table of service statistics and query from it.
SELECT 
    service,
    SUM(patients_admitted) AS total_admitted,
    AVG(patient_satisfaction) AS avg_sat
FROM
    services_weekly
GROUP BY service;

SELECT 
    stats.service, stats.total_admitted, stats.avg_sat
FROM
    (SELECT 
        service,
            SUM(patients_admitted) AS total_admitted,
            AVG(patient_satisfaction) AS avg_sat
    FROM
        services_weekly
    GROUP BY service) AS stats;

-- 3. Display staff with their service's total patient count as a calculated field.
SELECT 
    s.staff_id,
    s.staff_name,
    s.service,
    (SELECT 
            SUM(patients_admitted)
        FROM
            services_weekly sw
        WHERE
            sw.service = s.service) AS service_total_admitted
FROM
    staff s;

-- Daily Challenge:
-- Question: Create a report showing each service with: service name, total patients admitted, the difference between their total admissions and the average admissions across all services, and a rank indicator ('Above Average', 'Average', 'Below Average'). Order by total patients admitted descending.
SELECT 
    stats.service,
    stats.total_admitted,
    stats.total_admitted - (SELECT 
            AVG(total_admitted)
        FROM
            (SELECT 
                service, SUM(patients_admitted) AS total_admitted
            FROM
                services_weekly
            GROUP BY service) AS avg_table) AS difference_from_avg,
    CASE
        WHEN
            stats.total_admitted > (SELECT 
                    AVG(total_admitted)
                FROM
                    (SELECT 
                        service, SUM(patients_admitted) AS total_admitted
                    FROM
                        services_weekly
                    GROUP BY service) AS avg_table)
        THEN
            'Above Average'
        WHEN
            stats.total_admitted = (SELECT 
                    AVG(total_admitted)
                FROM
                    (SELECT 
                        service, SUM(patients_admitted) AS total_admitted
                    FROM
                        services_weekly
                    GROUP BY service) AS avg_table)
        THEN
            'Average'
        ELSE 'Below Average'
    END AS rank_status
FROM
    (SELECT 
        service, SUM(patients_admitted) AS total_admitted
    FROM
        services_weekly
    GROUP BY service) AS stats
ORDER BY stats.total_admitted DESC;