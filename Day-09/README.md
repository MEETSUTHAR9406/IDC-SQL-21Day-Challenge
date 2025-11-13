# Day 9 (12/11): String Functions

## Topics Covered
- DATE functions  
- Date arithmetic  
- EXTRACT / strftime  
- Date filtering 

## Key Concepts
Date functions help manipulate and analyze date/time values in SQL.  
Different SQL databases have different date functions, but the concepts remain the same.

### Common String Functions
```sql
CURDATE()                           -- Current date
NOW()                               -- Current date & time
DATEDIFF(date2, date1)              -- Difference in days
DATE_ADD(date, INTERVAL n DAY)      -- Add days
DATE_SUB(date, INTERVAL n DAY)      -- Subtract days
YEAR(date)                          -- Extract year
MONTH(date)                         -- Extract month (1–12)
DAY(date)                           -- Extract day (1–31)
WEEK(date)                          -- Extract week number
```

-- Calculate length of stay in days
```sql
SELECT patient_id,
       NAME,
       arrival_date,
       departure_date,
       Datediff(departure_date, arrival_date)
FROM   patients;
```

-- Extract year from date
```sql
SELECT *
FROM   patients
WHERE  arrival_date BETWEEN '2024-01-01' AND '2024-12-31';
```

-- Find patients admitted in specific month
```sql
SELECT name, LENGTH(name) AS name_length
FROM patients
WHERE LENGTH(name) > 15;
```

-- Extract substring (first 3 characters)
```sql
SELECT *
FROM   patients
WHERE  Month(arrival_date) = 6;
```

-- Replace text
```sql
SELECT REPLACE(service, 'Emergency', 'ER') AS service_abbr
FROM patients;
```

### Daily Challenge
Calculate the average length of stay (in days) for each service, showing only services where the average stay is more than 7 days. Also show the count of patients and order by average stay descending.
### Ans:
```sql
SELECT service,
       Count(*)                                    AS total,
       Avg(Datediff(departure_date, arrival_date)) AS stay
FROM   patients
GROUP  BY service
HAVING Avg(Datediff(departure_date, arrival_date)) > 7
ORDER  BY Avg(Datediff(departure_date, arrival_date)) DESC; 
```
