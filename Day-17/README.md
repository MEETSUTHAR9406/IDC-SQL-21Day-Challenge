# Day 17 (22/11): Subqueries in SELECT & FROM Clause

## Topics Covered
- Subqueries in SELECT
- Derived tables
- Inline views

## Key Concepts
Subqueries can also be placed inside the SELECT list (as calculated columns) and inside the FROM clause (as derived tables).
These help create dynamic values and organize complex logic into readable blocks.

### Basic Syntax
-- Subquery in SELECT
```sql
SELECT
    column1,
    (SELECT aggregate FROM table2 WHERE condition) AS calculated_column
FROM table1;
```

-- Subquery in FROM (Derived Table)
```sql
SELECT *
FROM (
    SELECT column1, column2
    FROM table
    WHERE condition
) AS subquery_alias;
```

-- Subquery in SELECT: Show each service's deviation from average
```sql
SELECT 
    service,
    COUNT(*) AS patient_count,
    COUNT(*) - (SELECT 
            AVG(service_count)
        FROM
            (SELECT 
                COUNT(*) AS service_count
            FROM
                patients
            GROUP BY service) AS sub) AS diff_from_avg
FROM
    patients
GROUP BY service;
```

-- Derived table: Service statistics
```sql
SELECT 
    service,
    total_admitted,
    CASE
        WHEN total_admitted > avg_admitted THEN 'Above Average'
        ELSE 'Below Average'
    END AS performance
FROM
    (SELECT 
        service,
            SUM(patients_admitted) AS total_admitted,
            (SELECT 
                    AVG(total)
                FROM
                    (SELECT 
                    SUM(patients_admitted) AS total
                FROM
                    services_weekly
                GROUP BY service) AS totals_table) AS avg_admitted
    FROM
        services_weekly
    GROUP BY service) AS service_stats;
```

-- Complex derived table with multiple calculations
```sql
SELECT 
    week_stats.*,
    overall.avg_satisfaction AS hospital_avg_satisfaction
FROM
    (SELECT 
        week,
            AVG(patient_satisfaction) AS weekly_avg_satisfaction,
            SUM(patients_admitted) AS weekly_admissions
    FROM
        services_weekly
    GROUP BY week) AS week_stats
        CROSS JOIN
    (SELECT 
        AVG(patient_satisfaction) AS avg_satisfaction
    FROM
        services_weekly) AS overall;
```

### Daily Challenge
Create a report showing each service with: service name, total patients admitted, the difference between their total admissions and the average admissions across all services, and a rank indicator ('Above Average', 'Average', 'Below Average'). Order by total patients admitted descending.
### Ans:
```sql
SELECT 
    stats.service,
    stats.total_admitted,
    stats.total_admitted - (SELECT 
            AVG(total_admitted)
        FROM
            (SELECT 
                service, SUM(patients_admitted) AS total_admitted
            FROM
                services_weekly
            GROUP BY service) AS avg_table) AS difference_from_avg,
    CASE
        WHEN
            stats.total_admitted > (SELECT 
                    AVG(total_admitted)
                FROM
                    (SELECT 
                        service, SUM(patients_admitted) AS total_admitted
                    FROM
                        services_weekly
                    GROUP BY service) AS avg_table)
        THEN
            'Above Average'
        WHEN
            stats.total_admitted = (SELECT 
                    AVG(total_admitted)
                FROM
                    (SELECT 
                        service, SUM(patients_admitted) AS total_admitted
                    FROM
                        services_weekly
                    GROUP BY service) AS avg_table)
        THEN
            'Average'
        ELSE 'Below Average'
    END AS rank_status
FROM
    (SELECT 
        service, SUM(patients_admitted) AS total_admitted
    FROM
        services_weekly
    GROUP BY service) AS stats
ORDER BY stats.total_admitted DESC;
```
