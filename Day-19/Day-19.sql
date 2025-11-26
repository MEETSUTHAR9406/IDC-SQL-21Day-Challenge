USE hospital;

-- Number patients within each service
SELECT patient_id,
       NAME,
       service,
       satisfaction,
       Row_number()
         OVER (
           partition BY service
           ORDER BY satisfaction DESC) AS row_num
FROM   patients; 

-- Rank patients by satisfaction (with ties)
SELECT   patient_id,
         name,
         satisfaction,
         Rank() over (ORDER BY satisfaction DESC)       AS `rank`,
         dense_rank() over (ORDER BY satisfaction DESC) AS `dense_rank`
FROM     patients;
    
-- Top 3 weeks by satisfaction per service
SELECT *
FROM   (SELECT service,
               week,
               patient_satisfaction,
               Rank()
                 OVER (
                   partition BY service
                   ORDER BY patient_satisfaction DESC) AS sat_rank
        FROM   services_weekly) AS ranked
WHERE  sat_rank <= 3
ORDER  BY service,
          sat_rank; 

-- Rank services by total admissions
SELECT 
  service, 
  Sum(patients_admitted) AS total_admitted, 
  Rank() OVER (
    ORDER BY 
      Sum(patients_admitted) DESC
  ) AS admission_rank 
FROM 
  services_weekly 
GROUP BY 
  service;
  
-- 1. Rank patients by satisfaction score within each service.
SELECT 
    patient_id,
    name,
    service,
    satisfaction,
    RANK() OVER (PARTITION BY service ORDER BY satisfaction DESC) AS service_rank
FROM patients;

-- 2. Assign row numbers to staff ordered by their name.
SELECT 
    staff_id,
    staff_name,
    ROW_NUMBER() OVER (ORDER BY staff_name) AS row_num
FROM staff;

-- 3. Rank services by total patients admitted.
SELECT 
    service,
    SUM(patients_admitted) AS total_admitted,
    RANK() OVER (ORDER BY SUM(patients_admitted) DESC) AS admission_rank
FROM services_weekly
GROUP BY service;

-- Daily Challenge:
-- Question: For each service, rank the weeks by patient satisfaction score (highest first). Show service, week, patient_satisfaction, patients_admitted, and the rank. Include only the top 3 weeks per service.
WITH ranked_weeks AS (
    SELECT
        service,
        week,
        patient_satisfaction,
        patients_admitted,
        RANK() OVER (
            PARTITION BY service 
            ORDER BY patient_satisfaction DESC
        ) AS satisfaction_rank
    FROM services_weekly
)
SELECT 
    service,
    week,
    patient_satisfaction,
    patients_admitted,
    satisfaction_rank
FROM ranked_weeks
WHERE satisfaction_rank <= 3
ORDER BY service, satisfaction_rank;