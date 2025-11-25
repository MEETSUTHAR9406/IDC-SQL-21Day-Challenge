# Day 18 (24/11): UNION and UNION ALL

## Topics Covered
- UNION
- UNION ALL
- Combining result sets

## Key Concepts
UNION is used to combine the results of two or more SELECT queries into a single output.
It helps merge data from multiple tables when the structure (number of columns + data types) align.

### Basic Syntax
```sql
SELECT column1, column2
FROM table1
UNION [ALL]
SELECT column1, column2
FROM table2;
```

-- Combine patient and staff names
```sql
SELECT 
    name AS full_name, 'Patient' AS type, service
FROM
    patients 
UNION ALL SELECT 
    staff_name AS full_name, 'Staff' AS type, service
FROM
    staff
ORDER BY service , type , full_name;
```

-- High and low performers
```sql
SELECT 
    patient_id, name, satisfaction, 'High Performer' AS category
FROM
    patients
WHERE
    satisfaction >= 90 
UNION SELECT 
    patient_id, name, satisfaction, 'Low Performer' AS category
FROM
    patients
WHERE
    satisfaction < 50
ORDER BY satisfaction DESC;
```

-- All unique services from multiple tables
```sql
SELECT DISTINCT
    service
FROM
    patients 
UNION SELECT DISTINCT
    service
FROM
    staff 
UNION SELECT DISTINCT
    service
FROM
    services_weekly;
```

-- Monthly summary from different metrics
```sql
SELECT 
    'Admissions' AS metric,
    month,
    SUM(patients_admitted) AS value
FROM
    services_weekly
GROUP BY month 
UNION ALL SELECT 
    'Refusals' AS metric, month, SUM(patients_refused) AS value
FROM
    services_weekly
GROUP BY month
ORDER BY month , metric;
```

### Daily Challenge
Create a comprehensive personnel and patient list showing: identifier (patient_id or staff_id), full name, type ('Patient' or 'Staff'), and associated service. Include only those in 'surgery' or 'emergency' services. Order by type, then service, then name.
### Ans:
```sql
SELECT 
    patient_id AS identifier,
    name AS full_name,
    'Patient' AS type,
    service
FROM
    patients
WHERE
    service IN ('surgery' , 'emergency') 
UNION SELECT 
    staff_id AS identifier,
    staff_name AS full_name,
    'Staff' AS type,
    service
FROM
    staff
WHERE
    service IN ('surgery' , 'emergency')
ORDER BY type , service , full_name;
```
