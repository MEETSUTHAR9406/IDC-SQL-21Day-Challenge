## Topics Covered

* Filtering data using the **WHERE** clause  
* Using **comparison operators** (=, >, <, >=, <=, !=)  
* Combining conditions with **AND**, **OR**, and **NOT**  
* Pattern matching with **LIKE** and **IN**  
* Using **BETWEEN** for range filtering  

## Key Concepts

* **WHERE** filters records based on conditions  
* **Comparison operators** compare values in columns  
* **Logical operators** combine multiple conditions  
* **Strings use single quotes (‘ ’)**  
* Use **IS NULL** or **IS NOT NULL** to check for missing values  

## 💻 Basic Syntax Examples

```sql
-- Select patients older than 60
SELECT * 
FROM patients
WHERE age > 60;

-- Retrieve patients from 'Emergency' service
SELECT * 
FROM patients
WHERE service = 'Emergency';

-- Multiple conditions using AND
SELECT * 
FROM patients
WHERE age > 60 AND service = 'Cardiology';

-- Using IN for cleaner filtering
SELECT * 
FROM patients
WHERE service IN ('Emergency', 'Cardiology', 'Surgery');

-- Using BETWEEN for range
SELECT * 
FROM patients
WHERE age BETWEEN 18 AND 65;

```
## Daily Challenge 
Find all patients admitted to the 'Surgery' service with a satisfaction score below 70, showing their patient_id, name, age, and satisfaction.
## Ans:
SELECT patient_id, name, age, satisfaction
FROM patients
WHERE service = 'Surgery'
  AND satisfaction < 70