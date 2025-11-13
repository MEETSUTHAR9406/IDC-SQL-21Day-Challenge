USE hospital;

SELECT * FROM   patients;
SELECT * FROM   services_weekly;
SELECT * FROM   staff;
SELECT * FROM   staff_schedule;

-- Convert patient names to uppercase
SELECT Upper(name) AS name_upper
FROM   patients;

-- Concatenate name and service
SELECT Concat(name, ' - ', service) AS patient_info
FROM   patients;

-- Names longer than 15 characters
SELECT name,
       Length(name) AS name_length
FROM   patients
WHERE  Length(name) > 15;

-- First 3 letters of name
SELECT Substring(name, 1, 3) AS name_abbr
FROM   patients;

-- Replace 'emergency' with 'ER'
SELECT REPLACE(service, 'emergency', 'ER') AS service_abbr
FROM   patients;

-- 1. Convert all patient names to uppercase.
SELECT Upper(name) AS upper_name
FROM   patients;

-- 2. Find the length of each staff member's name.
SELECT staff_name,
       Length(staff_name) AS name_length
FROM   staff;

-- 3. Concatenate staff_id and staff_name with a hyphen separator.
SELECT staff_id,
       staff_name,
       Concat(staff_id, ' - ', staff_name) AS staff_detail
FROM   staff;

-- Daily Challenge:
-- Question: Create a patient summary that shows patient_id, full name in uppercase, service in lowercase, age category (if age >= 65 then 'Senior', if age >= 18 then 'Adult', else 'Minor'), and name length. Only show patients whose name length is greater than 10 characters.
SELECT Upper(patient_id) AS upper_id,
       Upper(name)       AS upper_name,
       Lower(service)    AS lower_service,
       age,
       Length(name)      AS length_name,
       CASE
         WHEN age >= 65 THEN 'Senior'
         WHEN age >= 18 THEN 'Adult'
         ELSE 'Minor'
       end               AS age_verify
FROM   patients
WHERE  Length(name) > 10;


-- Extra Questions:


-- ASCII value of 'A'
SELECT Ascii('A');

-- Custom patient ID message
SELECT name,
       patient_id,
       Concat(Substring(name, 1, 5), ' has id - ', Substring(patient_id, 5, 8))
       AS
       service_required
FROM   patients;

-- Custom staff details
SELECT staff_name,
       staff_id,
       role,
       Concat_ws(' _ ', Substring(staff_id, 5, 8), staff_name, role) AS
       staff_detail
FROM   staff;

-- Length of string 'Meet'
SELECT Length('Meet');

-- Patient name and length
SELECT name,
       service,
       Length(name) AS name_length
FROM   patients;

-- Staff name in uppercase (grouped)
SELECT staff_name,
       Upper(staff_name) AS upper_name
FROM   staff_schedule
GROUP  BY staff_name;

-- Patient name in lowercase
SELECT name,
       Lower(name) AS lower_name
FROM   patients
GROUP  BY name;

-- Replace domain extension
SELECT REPLACE('google.in', 'in', 'com') AS name_replace;

-- Replace ICU with full form
SELECT name,
       service,
       REPLACE(service, 'ICU', 'Intensive Care Unit') AS service_replace
FROM   patients;

-- Reverse patient names
SELECT patient_id,
       Reverse(name) AS name_reverse
FROM   patients;

-- Extract arrival day and month
SELECT arrival_date,
       Substring(arrival_date, 9, 2) AS arr_date,
       Substring(arrival_date, 6, 2) AS arr_month
FROM   patients;

-- Trim spaces on both sides
SELECT Trim('        Larry         ') AS result;

-- Trim left spaces
SELECT Ltrim('        Larry         ') AS result;

-- Trim right spaces
SELECT Rtrim('        Larry         ') AS result;

-- Trim '#' from both sides
SELECT Trim('#' FROM '#Larry#') AS result;

-- Remove leading zeros
SELECT Trim(LEADING '0' FROM '000456') AS result;

-- Remove trailing '/'
SELECT Trim(TRAILING '/' FROM 'http://') AS result;

-- Substring of ID + first 2 letters of name
SELECT Substring(patient_id, 5, 8),
       LEFT(name, 2) AS result
FROM   patients;

-- Substring of ID + last 2 digits of date
SELECT Substring(patient_id, 5, 8),
       RIGHT(arrival_date, 2) AS result
FROM   patients; 