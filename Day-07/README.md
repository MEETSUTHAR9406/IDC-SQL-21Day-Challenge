# Day 7 (10/11): HAVING Clause

## Topics Covered
- HAVING clause  
- Filtering aggregated results  

## Key Concepts
The **HAVING** clause filters groups created by `GROUP BY`, just like `WHERE` filters individual rows.  
It allows you to use aggregate functions (like COUNT, AVG, SUM) in conditions.

### Basic Syntax
```sql
SELECT column1, aggregate_function(column2)
FROM table_name
GROUP BY column1
HAVING aggregate_condition;
```

-- Services with more than 100 patients
```sql
SELECT service, COUNT(*) AS patient_count
FROM patients
GROUP BY service
HAVING COUNT(*) > 100;
```

-- Combining WHERE and HAVING
```sql
SELECT service, COUNT(*) AS elderly_count
FROM patients
WHERE age >= 65              -- Filter rows first
GROUP BY service
HAVING COUNT(*) > 20;        -- Filter groups after
```

-- Multiple HAVING conditions
```sql
SELECT
    service,
    AVG(satisfaction) AS avg_sat,
    COUNT(*) AS count
FROM patients
GROUP BY service
HAVING AVG(satisfaction) > 80 AND COUNT(*) > 50;
```

### Daily Challenge
Identify services that refused more than 100 patients in total and had an average patient satisfaction below 80. Show service name, total refused, and average satisfaction.
### Ans:
```sql
SELECT 
    service,
    SUM(patients_refused) AS total_refused,
    AVG(patient_satisfaction) AS avg_sat
FROM
    services_weekly
WHERE
    patients_refused > 100
GROUP BY service
HAVING AVG(patient_satisfaction) < 80;
```
