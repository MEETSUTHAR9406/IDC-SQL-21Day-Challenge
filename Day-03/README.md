# Day 3 (05/11): Sorting Data with ORDER BY

## Topics Covered
- ORDER BY clause  
- ASC/DESC sorting  
- Multiple column sorting  

## Key Concepts
The **ORDER BY** clause is used to sort query results based on one or more columns.  
Sorting can be done in ascending (`ASC`) or descending (`DESC`) order.

### Basic Syntax
```sql
SELECT column1, column2
FROM table_name
ORDER BY column1 [ASC|DESC];
```

-- Single column sort
```sql
SELECT * FROM patients ORDER BY age DESC;
```
-- Multiple columns
```sql
SELECT * FROM patients ORDER BY age DESC;
```
-- Sort by column number (not recommended)
```sql
SELECT * FROM patients ORDER BY age DESC;
```

### Daily Challenge
Retrieve the top 5 weeks with the highest patient refusals across all services, showing week, service, patients_refused, and patients_request. Sort by patients_refused in descending order.
### Ans:
```sql
SELECT 
    week, service, patients_refused, patients_request
FROM
    services_weekly
ORDER BY patients_refused DESC
LIMIT 5;
```
