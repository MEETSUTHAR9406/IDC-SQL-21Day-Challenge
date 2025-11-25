# Day 16 (21/11): Subqueries (WHERE Clause)

## Topics Covered
- Subqueries in WHERE  
- Nested queries  
- Filtering with subqueries  

## Key Concepts
Subqueries are queries nested inside other queries.  
A subquery inside a **WHERE** clause allows you to filter rows based on results generated from another query.

### Basic Syntax
```sql
SELECT columns
FROM table1
WHERE column IN (
    SELECT column
    FROM table2
    WHERE condition
);
```

-- Patients in services with high average satisfaction
```sql
SELECT *
FROM patients
WHERE service IN (
    SELECT service
    FROM services_weekly
    GROUP BY service
    HAVING AVG(patient_satisfaction) > 80
);
```

-- Patients older than average age
```sql
SELECT name, age
FROM patients
WHERE age > (
    SELECT AVG(age)
    FROM patients
);
```

-- Services that had any week with refusals
```sql
SELECT DISTINCT service
FROM services_weekly sw1
WHERE EXISTS (
    SELECT 1
    FROM services_weekly sw2
    WHERE sw2.service = sw1.service
      AND sw2.patients_refused > 0
);
```

-- Patients NOT in services with staff shortages
```sql
SELECT *
FROM patients
WHERE service NOT IN (
    SELECT service
    FROM staff
    GROUP BY service
    HAVING COUNT(*) < 5
);
```

### Daily Challenge
Find all patients who were admitted to services that had at least one week where patients were refused AND the average patient satisfaction for that service was below the overall hospital average satisfaction. Show patient_id, name, service, and their personal satisfaction score.
### Ans:
```sql
SELECT 
    patient_id, name, service, satisfaction
FROM
    patients
WHERE
    service IN (SELECT 
            service
        FROM
            services_weekly
        WHERE
            patients_refused > 0)
        AND service IN (SELECT 
            service
        FROM
            services_weekly
        GROUP BY service
        HAVING AVG(patient_satisfaction) < (SELECT 
                AVG(patient_satisfaction)
            FROM
                services_weekly));
```
