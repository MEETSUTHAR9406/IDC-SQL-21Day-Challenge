# Day 6 (09/11): GROUP BY Clause

## Topics Covered
- GROUP BY clause  
- Aggregating by categories  

## Key Concepts
The **GROUP BY** clause divides rows into groups based on column values, then applies aggregate functions (like COUNT, SUM, AVG) to each group.  
Each group produces one summarized row in the output.

### Basic Syntax
```sql
SELECT column1, aggregate_function(column2)
FROM table_name
GROUP BY column1;
```

-- Count patients per service
```sql
SELECT service, COUNT(*) AS patient_count
FROM patients
GROUP BY service;
```

-- Multiple aggregates per group
```sql
SELECT
    service,
    COUNT(*) AS total_patients,
    AVG(age) AS avg_age,
    AVG(satisfaction) AS avg_satisfaction
FROM patients
GROUP BY service
ORDER BY total_patients DESC;
```

-- Group by multiple columns
```sql
SELECT
    service,
    CASE 
        WHEN age >= 65 THEN 'Senior' 
        ELSE 'Adult' 
    END AS age_group,
    COUNT(*) AS count
FROM patients
GROUP BY service, age_group;
```

### Daily Challenge
For each hospital service, calculate the total number of patients admitted, total patients refused, and the admission rate (percentage of requests that were admitted). Order by admission rate descending.
### Ans:
```sql
SELECT
    service,
    SUM(patients_admitted) AS total_admitted,
    SUM(patients_refused) AS total_refused,
    (SUM(patients_admitted) / (SUM(patients_admitted) + SUM(patients_refused)) * 100) AS admission_rate
FROM services_weekly
GROUP BY service
ORDER BY admission_rate DESC;
```
