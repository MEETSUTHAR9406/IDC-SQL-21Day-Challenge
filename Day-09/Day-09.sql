USE hospital;

SELECT * FROM   patients;

-- Calculate length of stay in days
SELECT patient_id,
       NAME,
       arrival_date,
       departure_date,
       Datediff(departure_date, arrival_date)
FROM   patients;

-- Extract year from date
SELECT patient_id,
       Year(arrival_date)  AS arrival_year,
       Month(arrival_date) AS arrival_month,
       Day(arrival_date)   AS arrival_date
FROM   patients;

-- Filter by date range
SELECT *
FROM   patients
WHERE  arrival_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Find patients admitted in specific month
SELECT *
FROM   patients
WHERE  Month(arrival_date) = 6;

-- 1. Extract the year from all patient arrival dates.
SELECT patient_id,
       NAME,
       Year(arrival_date) AS arrival_year
FROM   patients;

-- 2. Calculate the length of stay for each patient (departure_date - arrival_date).
SELECT patient_id,
       NAME,
       Datediff(departure_date, arrival_date) AS stay
FROM   patients;

-- 3. Find all patients who arrived in a specific month.
SELECT patient_id,
       NAME,
       Month(arrival_date) AS arrival_month
FROM   patients
WHERE  Month(arrival_date) = 6;

-- Daily Challenge:
-- Question: Calculate the average length of stay (in days) for each service, showing only services where the average stay is more than 7 days. Also show the count of patients and order by average stay descending.
SELECT service,
       Count(*)                                    AS total,
       Avg(Datediff(departure_date, arrival_date)) AS stay
FROM   patients
GROUP  BY service
HAVING Avg(Datediff(departure_date, arrival_date)) > 7
ORDER  BY Avg(Datediff(departure_date, arrival_date)) DESC; 