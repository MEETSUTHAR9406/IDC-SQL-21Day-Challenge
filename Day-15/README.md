# Day 15 (19/11): Multiple Joins

## Topics Covered
- Joining more than two tables  
- Understanding complex multi-table relationships  
- Mixing INNER JOIN and LEFT JOIN  

## Key Concepts
Multiple JOINs allow you to combine data from **three or more tables** in a single result set.  
The JOINs are evaluated **left to right**, and results from each join become inputs for the next.

### Basic Syntax
```sql
SELECT columns
FROM table1
JOIN table2 ON table1.key = table2.key
JOIN table3 ON table2.key = table3.key
LEFT JOIN table4 ON table3.key = table4.key;
```

-- Comprehensive service report with staff and schedules
```sql
SELECT
    sw.service,
    sw.week,
    sw.patients_admitted,
    COUNT(DISTINCT s.staff_id) AS total_staff,
    SUM(CASE WHEN ss.present = 1 THEN 1 ELSE 0 END) AS staff_present
FROM services_weekly sw
LEFT JOIN staff s ON sw.service = s.service
LEFT JOIN staff_schedule ss
    ON s.staff_id = ss.staff_id
    AND sw.week = ss.week
WHERE sw.week = 10
GROUP BY sw.service, sw.week, sw.patients_admitted;
```

-- Patient admission with staff availability
```sql
SELECT
    p.patient_id,
    p.name,
    p.service,
    p.arrival_date,
    COUNT(DISTINCT s.staff_id) AS assigned_staff,
    AVG(ss.present) AS avg_staff_presence
FROM patients p
JOIN staff s ON p.service = s.service
LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id
GROUP BY p.patient_id, p.name, p.service, p.arrival_date;
```

### Daily Challenge
Create a comprehensive service analysis report for week 20 showing: service name, total patients admitted that week, total patients refused, average patient satisfaction, count of staff assigned to service, and count of staff present that week. Order by patients admitted descending.
### Ans:
```sql
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
```
