# Day 14 (18/11): LEFT JOIN and RIGHT JOIN

## Topics Covered
- LEFT JOIN  
- RIGHT JOIN  
- Handling unmatched records  

## Key Concepts
`LEFT JOIN` returns **all rows from the left table**, and matching rows from the right table.  
If no match exists, rows from the right table appear as **NULL**.

`RIGHT JOIN` is the opposite, but is used less frequently and can usually be rewritten as a LEFT JOIN.

### Basic Syntax
```sql
-- LEFT JOIN
SELECT columns
FROM table1
LEFT JOIN table2 
    ON table1.column = table2.column;
```

-- RIGHT JOIN
```sql
SELECT columns
FROM table1
RIGHT JOIN table2 
    ON table1.column = table2.column;
```

-- All staff with schedule data (including non-scheduled staff)
```sql
SELECT
    s.staff_id,
    s.staff_name,
    s.role,
    s.service,
    COUNT(ss.week) AS weeks_scheduled,
    SUM(COALESCE(ss.present, 0)) AS weeks_present
FROM staff s
LEFT JOIN staff_schedule ss 
    ON s.staff_id = ss.staff_id
GROUP BY s.staff_id, s.staff_name, s.role, s.service;
```

-- Staff with no schedule entries
```sql
SELECT s.*
FROM staff s
LEFT JOIN staff_schedule ss 
    ON s.staff_id = ss.staff_id
WHERE ss.staff_id IS NULL;
```

-- All services with patient counts (including services with zero patients)
```sql
SELECT
    sw.service,
    sw.week,
    COUNT(p.patient_id) AS patient_count
FROM services_weekly sw
LEFT JOIN patients p 
    ON sw.service = p.service
GROUP BY sw.service, sw.week;
```

-- Daily Challenge:
-- Question: Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service) and the count of weeks they were present (from staff_schedule). Include staff members even if they have no schedule records. Order by weeks present descending.
```sql
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
```
