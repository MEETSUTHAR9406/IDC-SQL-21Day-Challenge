# Day 2 (04/11): Filtering Data with WHERE Clause

## Topics Covered
- Filtering data using WHERE  
- Comparison operators (=, >, <, >=, <=, !=)  
- Logical operators (AND, OR, NOT)  
- Pattern matching with LIKE and IN  
- Using BETWEEN for ranges  

## Key Concepts
The **WHERE** clause filters rows based on specified conditions before final output.  
You can combine multiple conditions using logical operators for precise queries.

### Basic Syntax
```sql
SELECT column1, column2
FROM table_name
WHERE condition;
```

-- Simple filtering
```sql
SELECT * FROM patients WHERE age > 60;
```

-- AND condition
```sql
SELECT * FROM patients WHERE age > 60 AND service = 'Cardiology';
```

-- OR condition
```sql
SELECT * FROM patients WHERE service = 'Emergency' OR service = 'Cardiology';
```

-- IN operator
```sql
SELECT * FROM patients WHERE service IN ('Emergency', 'Cardiology', 'Neurology');
```

-- BETWEEN for range filtering
```sql
SELECT * FROM patients WHERE age BETWEEN 18 AND 65;
```

### Daily Challenge
Find all patients admitted to 'Surgery' service with a satisfaction score below 70, showing their patient_id, name, age, and satisfaction score.
### Ans:
```sql
SELECT patient_id, name, age, satisfaction FROM patients WHERE service = 'Surgery' AND satisfaction < 70;
```
