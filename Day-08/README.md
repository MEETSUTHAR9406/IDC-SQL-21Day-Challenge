# Day 8 (11/11): String Functions

## Topics Covered
- UPPER  
- LOWER  
- LENGTH  
- CONCAT  
- SUBSTRING  

## Key Concepts
String functions are used to manipulate, transform, and analyze text data in SQL queries.  
They help format names, merge values, calculate lengths, or clean up strings.

### Common String Functions
```sql
UPPER(column)             -- Convert to uppercase
LOWER(column)             -- Convert to lowercase
LENGTH(column)            -- Get string length
CONCAT(str1, str2)        -- Combine strings
SUBSTRING(str, pos, len)  -- Extract substring
TRIM(column)              -- Remove leading/trailing spaces
REPLACE(str, old, new)    -- Replace text
```

-- Convert to uppercase
```sql
SELECT UPPER(name) AS name_upper FROM patients;
```

-- Concatenate columns
```sql
SELECT CONCAT(name, ' - ', service) AS patient_info FROM patients;
```

-- Get name length
```sql
SELECT name, LENGTH(name) AS name_length
FROM patients
WHERE LENGTH(name) > 15;
```

-- Extract substring (first 3 characters)
```sql
SELECT SUBSTRING(name, 1, 3) AS name_abbr FROM patients;
```

-- Replace text
```sql
SELECT REPLACE(service, 'Emergency', 'ER') AS service_abbr
FROM patients;
```

### Daily Challenge
Identify services that refused more than 100 patients in total and had an average patient satisfaction below 80. Show service name, total refused, and average satisfaction.
### Ans:
```sql
SELECT 
    patient_id,
    UPPER(name) AS full_name_uppercase,
    LOWER(service) AS service_lowercase,
    CASE
        WHEN age >= 65 THEN 'Senior'
        WHEN age >= 18 THEN 'Adult'
        ELSE 'Minor'
    END AS age_category,
    LENGTH(name) AS name_length
FROM patients
WHERE LENGTH(name) > 10;
```
