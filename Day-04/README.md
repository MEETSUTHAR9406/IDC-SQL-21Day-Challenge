# Day 4 (06/11): LIMIT and OFFSET

## Topics Covered
- LIMIT clause  
- OFFSET clause  
- Pagination concepts  

## Key Concepts
The **LIMIT** clause restricts how many rows are returned, while **OFFSET** skips a specific number of rows before starting to return results.  
These are commonly used together to implement pagination in SQL queries.

### Basic Syntax
```sql
SELECT columns
FROM table_name
LIMIT number_of_rows;

SELECT columns
FROM table_name
LIMIT number_of_rows OFFSET skip_rows;
```

-- First 10 records
```sql
SELECT * FROM patients LIMIT 10 OFFSET 0;
```

-- Next 10 records
```sql
SELECT * FROM patients LIMIT 10 OFFSET 10;
```

-- Next 10 records
```sql
SELECT * FROM patients LIMIT 10 OFFSET 20;
```

### Daily Challenge
Find the 3rd to 7th highest patient satisfaction scores from the patients table, showing patient_id, name, service, and satisfaction. Display only these 5 records.
### Ans:
```sql
SELECT 
    patient_id, name, service, satisfaction
FROM
    patients
ORDER BY satisfaction DESC
LIMIT 5 OFFSET 2
```
