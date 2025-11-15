# Day 12 (15/11): NULL Values and IS NULL / IS NOT NULL

## Topics Covered
- Handling NULL  
- IS NULL  
- IS NOT NULL  
- COALESCE  

## Key Concepts
`NULL` represents **missing or unknown data** in SQL.  
It is **not** zero, not an empty string — it means “no value”.

### NULL Handling Syntax
```sql
IS NULL                     -- Check for NULL
IS NOT NULL                -- Check for non-NULL
COALESCE(column, value)    -- Replace NULL with default
```

-- Find rows where event is NULL
```sql
SELECT * 
FROM services_weekly 
WHERE event IS NULL;
```

-- Find rows where event is NOT NULL
```sql
SELECT * 
FROM services_weekly 
WHERE event IS NOT NULL;
```

-- Replace NULL with a fallback value
```sql
SELECT
    service,
    week,
    COALESCE(event, 'No Event') AS event_status
FROM services_weekly;
```

-- Count NULL vs non-NULL values
```sql
SELECT
    COUNT(*) AS total_rows,
    COUNT(event) AS non_null_events,
    COUNT(*) - COUNT(event) AS null_events
FROM services_weekly;
```

-- Exclude NULL and empty strings
```sql
SELECT *
FROM services_weekly
WHERE event IS NOT NULL 
  AND event <> '';
```

### Daily Challenge
Analyze the event impact by comparing weeks with events vs weeks without events. Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, and average staff morale. Order by average patient satisfaction descending.
### Ans:
```sql
SELECT CASE
         WHEN even IS NULL
               OR even = 'none' THEN 'No Event'
         ELSE 'With Event'
       END                       AS event_status,
       Count(*)                  AS total_weeks,
       Avg(patient_satisfaction) AS avg_sat,
       Avg(staff_morale)         AS avg_morale
FROM   services_weekly
GROUP  BY event_status
ORDER  BY avg_sat DESC; 
```
