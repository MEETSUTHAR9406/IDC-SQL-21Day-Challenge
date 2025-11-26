# Day 20 (26/11) : Window Functions - Aggregate Window Functions

## Topics Covered
- SUM() OVER
- AVG() OVER
- Running totals
- Moving averages
- Window frame clauses

## Key Concepts
Aggregate window functions allow you to compute running totals, moving averages, cumulative stats, and comparisons without reducing rows.

These functions operate over a window of rows defined by OVER() and optionally refined using frame clauses.

### Basic Syntax
```sql
SUM(column)  OVER (...)     -- Running total
AVG(column)  OVER (...)     -- Moving average
COUNT(*)     OVER (...)     -- Running count
MIN(column)  OVER (...)     -- Running minimum
MAX(column)  OVER (...)     -- Running maximum
```

-- Running total of patients admitted per service
```sql
SELECT service,
       week,
       patients_admitted,
       SUM(patients_admitted) OVER (PARTITION BY service ORDER BY week) AS cumulative_admissions
FROM services_weekly
ORDER BY service, week;
```

-- 3-week moving average of satisfaction
```sql
SELECT service,
       week,
       patient_satisfaction,
       Round(Avg(patient_satisfaction)
               over (
                 PARTITION BY service
                 ORDER BY week ROWS BETWEEN 2 preceding AND CURRENT ROW ), 2) AS
       moving_avg_3week
FROM   services_weekly
ORDER  BY service,
          week;
```

-- Compare to service average
```sql
SELECT service,
       week,
       patients_admitted,
       Avg(patients_admitted)
         OVER (
           partition BY service)                     AS service_avg,
       patients_admitted - Avg(patients_admitted)
                             OVER (
                               partition BY service) AS diff_from_avg
FROM   services_weekly;
```

-- Running min/max
```sql
SELECT service,
       week,
       patient_satisfaction,
       Min(patient_satisfaction)
         OVER (
           partition BY service
           ORDER BY week ) AS min_so_far,
       Max(patient_satisfaction)
         OVER (
           partition BY service
           ORDER BY week ) AS max_so_far
FROM   services_weekly; 
```

### Daily Challenge
Create a trend analysis showing for each service and week: week number, patients_admitted, running total of patients admitted (cumulative), 3-week moving average of patient satisfaction (current week and 2 prior weeks), and the difference between current week admissions and the service average. Filter for weeks 10-20 only.
### Ans:
```sql
SELECT
    service,
    week,
    patients_admitted,

    SUM(patients_admitted) OVER (
        PARTITION BY service
        ORDER BY week
    ) AS running_total,

    AVG(patient_satisfaction) OVER (
        PARTITION BY service
        ORDER BY week
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_3weeks,

    patients_admitted -
    AVG(patients_admitted) OVER (
        PARTITION BY service
    ) AS diff_from_avg

FROM services_weekly
WHERE week BETWEEN 10 AND 20
ORDER BY service, week;
```
