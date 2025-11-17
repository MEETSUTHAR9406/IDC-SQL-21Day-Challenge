# Day 13 (17/11): INNER JOIN

## Topics Covered
- INNER JOIN  
- Joining two tables  
- Understanding table relationships  

## Key Concepts
`INNER JOIN` returns rows that have matching values in **both tables**.  
It combines data based on a related column, such as `service`, `id`, or `week`.

### Basic Syntax
```sql
SELECT columns
FROM table1
INNER JOIN table2 
    ON table1.column = table2.column;
```

-- Join patients with staff (same service)
```sql
SELECT
    p.patient_id,
    p.name AS patient_name,
    p.service,
    s.staff_name,
    s.role
FROM patients p
INNER JOIN staff s 
    ON p.service = s.service
ORDER BY p.service, p.patient_name;
```

-- Count staff per patient service
```sql
SELECT
    p.patient_id,
    p.name,
    p.service,
    COUNT(s.staff_id) AS staff_count
FROM patients p
INNER JOIN staff s 
    ON p.service = s.service
GROUP BY p.patient_id, p.name, p.service;
```

-- Multiple join conditions
```sql
SELECT *
FROM services_weekly sw
INNER JOIN staff_schedule ss
    ON sw.service = ss.service
    AND sw.week = ss.week;
```

-- Daily Challenge:
-- Question: Create a comprehensive report showing patient_id, patient name, age, service, and the total number of staff members available in their service. Only include patients from services that have more than 5 staff members. Order by number of staff descending, then by patient name.
```sql
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
```
