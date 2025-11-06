## Topics Covered  
- LIMIT clause  
- OFFSET clause  
- Pagination concepts  

## Key Concepts  
- `LIMIT` restricts the number of rows returned  
- `OFFSET` skips a specified number of rows before returning results  
- Commonly used together for **pagination**  
- `LIMIT` is applied **after ORDER BY**  
- Syntax varies slightly across database systems  

## Examples  
```sql
-- Show first 5 patients
SELECT * FROM patients LIMIT 5;

-- Show patients 11–20
SELECT * FROM patients LIMIT 10 OFFSET 10;

-- Get 10 most recent patient admissions
SELECT * FROM patients
ORDER BY arrival_date DESC
LIMIT 10;

-- Pagination with ORDER BY
SELECT * FROM patients
ORDER BY patient_id
LIMIT 10 OFFSET 20;
```

## Daily Challenge
Question: Find the 3rd to 7th highest patient satisfaction scores from the patients table, showing patient_id, name, service, and satisfaction. Display only these 5 records.
## Ans:
USE hospital;

SELECT patient_id, name, service, satisfaction
FROM patients
ORDER BY satisfaction DESC
LIMIT 5 OFFSET 2;
