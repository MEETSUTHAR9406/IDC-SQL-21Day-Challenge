# Day 11 (14/11): DISTINCT and Handling Duplicates

## Topics Covered
- DISTINCT  
- Removing duplicates  
- Getting unique values  

## Key Concepts
`DISTINCT` removes duplicate rows from a result set and returns only **unique combinations** of the selected columns.

### Basic Syntax
```sql
SELECT DISTINCT column1, column2
FROM table_name;
```

-- Get unique services
```sql
SELECT DISTINCT service 
FROM patients;
```

-- Unique combinations of service and age group
```sql
SELECT DISTINCT
    service,
    CASE
        WHEN age < 18 THEN 'Pediatric'
        WHEN age BETWEEN 18 AND 65 THEN 'Adult'
        ELSE 'Senior'
    END AS age_group
FROM patients;
```

-- Count distinct values
```sql
SELECT COUNT(DISTINCT service) AS unique_services 
FROM patients;
```

-- DISTINCT with multiple columns
```sql
SELECT DISTINCT service, arrival_date
FROM patients
ORDER BY service, arrival_date;
```

### Daily Challenge
Find all unique combinations of service and event type from the services_weekly table where events are not null or none, along with the count of occurrences for each combination. Order by count descending.
### Ans:
```sql
SELECT DISTINCT service,
                even,
                Count(*) AS occurences
FROM   services_weekly
WHERE  even IS NOT NULL
       AND even <> ''
       AND even <> 'none'
GROUP  BY service,
          even
ORDER  BY occurences DESC; 
```
