# Day 5 (07/11): Aggregate Functions (COUNT, SUM, AVG, MIN, MAX)

## Topics Covered
- COUNT(), SUM(), AVG(), MIN(), MAX() functions

## Key Concepts
Aggregate functions perform calculations on multiple rows and return a single summarized value.

### The Five Core Aggregates
```sql
COUNT(*)             -- Counts all rows
COUNT(column)        -- Counts non-NULL values
COUNT(DISTINCT col)  -- Counts unique non-NULL values
SUM(column)          -- Adds numeric values
AVG(column)          -- Calculates average
MIN(column)          -- Finds minimum value
MAX(column)          -- Finds maximum value
```

-- Single aggregate 
```sql
SELECT COUNT(*) AS total_patients FROM patients;
```

-- Multiple aggregates
```sql
SELECT
    COUNT(*) AS total,
    AVG(age) AS avg_age,
    MIN(age) AS youngest,
    MAX(age) AS oldest,
    SUM(satisfaction) AS total_satisfaction
FROM patients;
```

-- Aggregate with WHERE
```sql
SELECT AVG(satisfaction)
FROM patients
WHERE service = 'Cardiology';

COUNT(*) vs COUNT(column)

COUNT(*) → counts all rows (including NULLs)
COUNT(column) → counts only non-NULL values
```

### Daily Challenge
Calculate the total number of patients admitted, total patients refused, and the average patient satisfaction across all services and weeks. Round the average satisfaction to 2 decimal places.
### Ans:
```sql
SELECT 
    SUM(patients_admitted) AS total_admit,
    SUM(patients_refused) AS total_refused,
    ROUND(AVG(patient_satisfaction), 2) AS avg_satisfaction
FROM services_weekly;
```
