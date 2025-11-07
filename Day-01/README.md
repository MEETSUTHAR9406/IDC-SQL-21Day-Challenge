# Day 1 (03/11): Introduction to SQL & SELECT Statement

## Topics Covered
- Basic SELECT  
- Column selection  
- Viewing data structure  

## Key Concepts
SQL (Structured Query Language) is the standard language used for managing and retrieving data from relational databases.  
The `SELECT` statement is your primary tool for fetching data from one or more tables.

### Basic Syntax
```sql
SELECT column1, column2, column3
FROM table_name;
```

-- Select all columns
```sql
SELECT * FROM patients;
```
-- Select specific columns
```sql
SELECT patient_id, name, age FROM patients;
```

-- Using column aliases for readability
```sql
SELECT name AS patient_name, age AS patient_age FROM patients;
```

-- Test with limited rows
```sql
SELECT * FROM patients LIMIT 5;
```

### Daily Challenge
List all unique hospital services available in the hospital.
### Ans:
```sql
SELECT service FROM services_weekly GROUP BY service;
```
