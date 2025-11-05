## Topics Covered
- ORDER BY clause  
- ASC/DESC sorting  
- Multiple column sorting  

## Key Concepts
- `ORDER BY` arranges results by one or more columns  
- `ASC` → ascending (default), `DESC` → descending  
- You can sort by columns not in SELECT  
- `ORDER BY` is usually the last clause (before LIMIT)  

## Examples
```sql
-- Sort by age (descending)
SELECT * FROM patients ORDER BY age DESC;

-- Multi-column sort (age ↓, name ↑)
SELECT * FROM patients ORDER BY age DESC, name ASC;

-- Sort by satisfaction for top results
SELECT name, age FROM patients ORDER BY satisfaction DESC LIMIT 10;
