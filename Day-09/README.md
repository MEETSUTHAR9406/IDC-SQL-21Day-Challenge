# By mistake added of Day-10, will add of day-09 soon.
Here is of day-10:
[Day-10](https://github.com/MEETSUTHAR9406/IDC-SQL-21Day-Challenge/tree/main/Day-10)

# Day 10 (13/11): CASE Statements

## Topics Covered
- CASE WHEN  
- Conditional logic  
- Derived columns  

## Key Concepts
The **CASE** statement adds conditional logic to your SQL queries — similar to `if-else` in programming.  
It allows dynamic data transformation directly within queries.

### Two Syntaxes
```sql
-- Simple CASE
CASE column_name
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    ELSE default_result
END
```

```sql
-- Searched CASE (more flexible)
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE default_result
END
```

-- Categorize patient satisfaction
```sql
SELECT
    name,
    satisfaction,
    CASE
        WHEN satisfaction >= 90 THEN 'Excellent'
        WHEN satisfaction >= 75 THEN 'Good'
        WHEN satisfaction >= 60 THEN 'Fair'
        ELSE 'Needs Improvement'
    END AS satisfaction_category
FROM patients;
```

-- Create age groups
```sql
SELECT
    name,
    age,
    CASE
        WHEN age < 18 THEN 'Pediatric'
        WHEN age BETWEEN 18 AND 65 THEN 'Adult'
        ELSE 'Senior'
    END AS age_group
FROM patients;
```

-- Conditional aggregation
```sql
SELECT
    service,
    COUNT(*) AS total,
    SUM(CASE WHEN satisfaction >= 80 THEN 1 ELSE 0 END) AS high_satisfaction_count,
    SUM(CASE WHEN satisfaction < 60 THEN 1 ELSE 0 END) AS low_satisfaction_count
FROM patients
GROUP BY service;
```

### Daily Challenge
Create a service performance report showing service name, total patients admitted, and a performance category based on the following: 'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65, otherwise 'Needs Improvement'. Order by average satisfaction descending.
### Ans:
```sql
SELECT 
    service,
    SUM(patients_admitted) AS total_admitted,
    AVG(patient_satisfaction) AS avg_satisfaction,
    CASE
        WHEN AVG(patient_satisfaction) >= 85 THEN 'Excellent'
        WHEN AVG(patient_satisfaction) >= 75 THEN 'Good'
        WHEN AVG(patient_satisfaction) >= 65 THEN 'Fair'
        ELSE 'Needs Improvement'
    END AS performance_category
FROM services_weekly
GROUP BY service
ORDER BY avg_satisfaction DESC;
```
