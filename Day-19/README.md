# Day 19 (25/11): Window Functions - ROW_NUMBER, RANK, DENSE_RANK

## Topics Covered
- Window Functions
- OVER clause
- ROW_NUMBER()
- RANK()
- DENSE_RANK()

## Key Concepts
Window functions perform calculations across related rows without reducing the number of rows like GROUP BY.
They are extremely useful for ranking, numbering, and performing analytics on partitions of data.

### Basic Syntax
```sql
window_function() OVER (
    [PARTITION BY column]
    [ORDER BY column]
)
```

-- Number patients within each service
```sql
SELECT patient_id,
       NAME,
       service,
       satisfaction,
       Row_number()
         OVER (
           partition BY service
           ORDER BY satisfaction DESC) AS row_num
FROM   patients; 
```

-- Rank patients by satisfaction (with ties)
```sql
SELECT   patient_id,
         name,
         satisfaction,
         Rank() over (ORDER BY satisfaction DESC)       AS `rank`,
         dense_rank() over (ORDER BY satisfaction DESC) AS `dense_rank`
FROM     patients;
```

-- Top 3 weeks by satisfaction per service
```sql
SELECT *
FROM   (SELECT service,
               week,
               patient_satisfaction,
               Rank()
                 OVER (
                   partition BY service
                   ORDER BY patient_satisfaction DESC) AS sat_rank
        FROM   services_weekly) AS ranked
WHERE  sat_rank <= 3
ORDER  BY service,
          sat_rank; 
```

-- Rank services by total admissions
```sql
SELECT 
  service, 
  Sum(patients_admitted) AS total_admitted, 
  Rank() OVER (
    ORDER BY 
      Sum(patients_admitted) DESC
  ) AS admission_rank 
FROM 
  services_weekly 
GROUP BY 
  service;
```

### Daily Challenge
For each service, rank the weeks by patient satisfaction score (highest first). Show service, week, patient_satisfaction, patients_admitted, and the rank. Include only the top 3 weeks per service.
### Ans:
```sql
WITH ranked_weeks AS (
    SELECT
        service,
        week,
        patient_satisfaction,
        patients_admitted,
        RANK() OVER (
            PARTITION BY service 
            ORDER BY patient_satisfaction DESC
        ) AS satisfaction_rank
    FROM services_weekly
)
SELECT 
    service,
    week,
    patient_satisfaction,
    patients_admitted,
    satisfaction_rank
FROM ranked_weeks
WHERE satisfaction_rank <= 3
ORDER BY service, satisfaction_rank;
```
