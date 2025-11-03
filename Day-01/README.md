## Topics Covered

Introduction to SQL (Structured Query Language) <br>
Basic SELECT statement <br>
Column selection <br>
Viewing data structure <br>

## Key Concepts

Tables store data in rows (records) and columns (fields) <br>
SELECT specifies which columns to retrieve <br>
FROM specifies the table to query <br>
SQL statements end with a semicolon (;) <br>

## Basic Syntax Examples

-- Select all columns <br>
SELECT * FROM patients;

-- Select specific columns <br>
SELECT patient_id, name, age FROM patients;

-- Using column aliases for readability <br>
SELECT name AS patient_name, age AS patient_age FROM patients;

-- Test with limited rows <br>
SELECT * FROM patients LIMIT 5;

## Daily Challenge

Question: List all unique hospital services available in the hospital
### Ans: 

SELECT service <br>
FROM services_weekly <br> 
GROUP BY service; <br>
