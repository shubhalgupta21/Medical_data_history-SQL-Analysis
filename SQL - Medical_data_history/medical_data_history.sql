create database Medical_data_history ; 
-- 1. Show first name, last name, and gender of patients who's gender is 'M'

-- 2. Show first name and last name of patients who does not have allergies.
-- 3. Show first name of patients that start with the letter 'C'
-- 4. Show first name and last name of patients that weight within the range of
-- 100 to 120 (inclusive)
-- 5. Update the patients table for the allergies column. If the patient's allergies is
-- null then replace it with 'NKA'
-- 6. Show first name and last name concatenated into one column to show their
-- full name.
/* 7. Show first name, last name, and the full province name of each
patient. 8. Show how many patients have a birth_date with 2010 as the
birth year.*/
/*9. Show the first_name, last_name, and height of the patient with the greatest
height.*/
/*10. Show all columns for patients who have one of the following patient_ids:
1,45,534,879,1000*/
-- 11. Show the total number of admissions
/*12. Show all the columns from admissions where the patient was admitted
and discharged on the same day.*/
-- 13. Show the total number of admissions for patient_id 579.
/*14. Based on the cities that our patients live in, show unique cities that are in
province_id 'NS'?*/
/*15. Write a query to find the first_name, last name and birth date of patients
who have height more than 160 and weight more than 70*/
/*16. Show unique birth years from patients and order them by ascending.*/
/*17. Show unique first names from the patients table which only occurs once in
the list.
For example, if two or more people are named 'John' in the first_name column
then don't include their name in the output list. If only 1 person is named 'Leo'
then include them in the output. Tip: HAVING clause was added to SQL
because the WHERE keyword cannot be used with aggregate functions. */
/*18. Show patient_id and first_name from patients where their first_name start
and ends with 's' and is at least 6 characters long. */
/*19. Show patient_id, first_name, last_name from patients whos diagnosis is
'Dementia'. Primary diagnosis is stored in the admissions table.*/
/*20. Display every patient's first_name. Order the list by the length of each
name and then by alphbetically. */
/*21. Show the total amount of male patients and the total amount of female
patients in the patients table. Display the two results in the same row. */
/*22. Show the total amount of male patients and the total amount of female
patients in the patients table. Display the two results in the same row. */
/*23. Show patient_id, diagnosis from admissions. Find patients admitted
multiple times for the same diagnosis. */
/*24. Show the city and the total number of patients in the city. Order from most
to least patients and then by city name ascending.*/
/*25. Show first name, last name and role of every person that is either patient or
doctor. The roles are either "Patient" or "Doctor"*/
-- 26. Show all allergies ordered by popularity. Remove NULL values from query.
/*27. Show all patient's first_name, last_name, and birth_date who were born in
the 1970s decade. Sort the list starting from the earliest birth_date. */
/*28. We want to display each patient's full name in a single column. Their
last_name in all upper letters must appear first, then first_name in all lower
case letters. Separate the last_name and first_name with a comma. Order the
list by the first_name in decending order EX: SMITH,jane */
/*29. Show the province_id(s), sum of height; where the total sum of its patient's
height is greater than or equal to 7,000. */
/*30. Show the difference between the largest weight and smallest weight for
patients with the last name 'Maroni'*/
/*31. Show all of the days of the month (1-31) and how many admission_dates
occurred on that day. Sort by the day with most admissions to least
admissions.*/
/*32. Show all of the patients grouped into weight groups. Show the total
amount of patients in each weight group. Order the list by the weight group
decending. e.g. if they weight 100 to 109 they are placed in the 100 weight
group, 110-119 = 110 weight group, etc.*/
/*33. Show patient_id, weight, height, isObese from the patients table. Display
isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m). Weight
is in units kg. Height is in units cm.*/
/*34. Show patient_id, first_name, last_name, and attending doctor's specialty.
Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first
name is 'Lisa'. Check patients, admissions, and doctors tables for required
information.
SQL Schema:
Note:- Change the column name attending_doctor_id to doctor_id of table admission
to merge with table doctors*/


USE Medical_data_history;
CREATE TABLE doctors (
    doctor_id   INT PRIMARY KEY,
    first_name  VARCHAR(50),
    last_name   VARCHAR(50),
    specialty   VARCHAR(100)
);
CREATE TABLE province_names (
    province_id   CHAR(2) PRIMARY KEY,
    province_name VARCHAR(100)
);
CREATE TABLE patients (
    patient_id  INT PRIMARY KEY,
    first_name  VARCHAR(50),
    last_name   VARCHAR(50),
    gender      CHAR(1),
    birth_date  DATE,
    city        VARCHAR(100),
    allergies   VARCHAR(100),
    height      INT,
    weight      INT,
    province_id CHAR(2)
);
CREATE TABLE admissions (
    patient_id     INT,
    admission_date DATE,
    discharge_date DATE,
    diagnosis      VARCHAR(255),
    doctor_id      INT
);

-- First name, last name, gender of male patients
SELECT first_name, last_name, gender
FROM patients
WHERE gender = 'M';

-- Patients with no allergies  (run BEFORE query 5, which fills the NULLs)
SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL;

-- First names starting with 'C'
SELECT FIRST_NAME FROM PATIENTS WHERE FIRST_NAME LIKE "C%";

-- Weight between 100 and 120 (inclusive)
SELECT first_name, last_name
FROM patients
WHERE weight BETWEEN 100 AND 120;

--  Replace NULL allergies with 'NKA'
SET SQL_SAFE_UPDATES = 0;
UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;

--  Full name in one column
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;

-- First name, last name and full province name
SELECT p.first_name, p.last_name, pn.province_name
FROM patients p
JOIN province_names pn ON p.province_id = pn.province_id;

-- Patients born in 2010
SELECT COUNT(*) AS total_patients
FROM patients
WHERE YEAR(birth_date) = 2010;

-- Patient with the greatest height (WHERE form also returns ties)
SELECT first_name, last_name, height
FROM patients
WHERE height = (SELECT MAX(height) FROM patients);

--  Specific patient_ids
SELECT *
FROM patients
WHERE patient_id IN (1, 45, 534, 879, 1000);

-- Total number of admissions
SELECT COUNT(*) AS total_admissions
FROM admission;

-- Admitted and discharged on the same day
SELECT *
FROM admission
WHERE admission_date = discharge_date;

-- Total admissions for patient_id 579
SELECT COUNT(*) AS total_admissions
FROM admission
WHERE patient_id = 579;

-- Unique cities in province 'NS'
SELECT DISTINCT city
FROM patients
WHERE province_id = 'NS';

--  Height > 160 and weight > 70
SELECT first_name, last_name, birth_date
FROM patients
WHERE height > 160 AND weight > 70;

-- Unique birth years, ascending
SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM patients
ORDER BY birth_year ASC;

--  First names that occur only once
SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1;

-- First name starts and ends with 's', at least 6 characters
SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE 's%s'
  AND LENGTH(first_name) >= 6;
  
--  Patients whose diagnosis is 'Dementia'
SELECT p.patient_id, p.first_name, p.last_name
FROM patients p
JOIN admission a ON p.patient_id = a.patient_id
WHERE a.diagnosis = 'Dementia';

--  First names ordered by length, then alphabetically
SELECT first_name
FROM patients
ORDER BY LENGTH(first_name), first_name;

--  Male and female patient totals in the same row
SELECT
    SUM(gender = 'M') AS male_count,
    SUM(gender = 'F') AS female_count
FROM patients;

-- count of male and female 
SELECT
    COUNT(CASE WHEN gender = 'M' THEN 1 END) AS male_count,
    COUNT(CASE WHEN gender = 'F' THEN 1 END) AS female_count
FROM patients;

-- Patients admitted multiple times for the same diagnosis
SELECT patient_id, diagnosis
FROM admission
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;

--  Patients per city, most to least, then city A-Z
SELECT city, COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC, city ASC;

--  Every patient and doctor with their role
SELECT first_name, last_name, 'Patient' AS role FROM patients
UNION ALL
SELECT first_name, last_name, 'Doctor' AS role FROM doctors;

-- Allergies by popularity, no NULLs
SELECT allergies, COUNT(*) AS total
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY total DESC;

-- Born in the 1970s, earliest first
SELECT first_name, last_name, birth_date
FROM patients
WHERE YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date ASC;

-- LASTNAME,firstname ordered by first_name descending
SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS full_name
FROM patients
ORDER BY first_name DESC;

--  Provinces where the total height is >= 7000
SELECT province_id, SUM(height) AS sum_height
FROM patients
GROUP BY province_id
HAVING SUM(height) >= 7000;

-- Weight range for last name 'Maroni'
SELECT MAX(weight) - MIN(weight) AS weight_difference
FROM patients
WHERE last_name = 'Maroni';

-- Admissions per day of month (1-31), busiest first
SELECT DAY(admission_date) AS day_of_month, COUNT(*) AS total_admissions
FROM admission
GROUP BY DAY(admission_date)
ORDER BY total_admissions DESC;

-- Patients per weight group (100 = 100-109, 110 = 110-119 ...)
SELECT FLOOR(weight / 10) * 10 AS weight_group, COUNT(*) AS total_patients
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

--  isObese as 0/1  (BMI = weight kg / (height m)^2, obese if BMI >= 30)
SELECT patient_id, weight, height,
       CASE WHEN weight / POWER(height / 100, 2) >= 30 THEN 1 ELSE 0 END AS isObese
FROM patients;

-- Epilepsy patients whose doctor's first name is 'Lisa'
SELECT p.patient_id, p.first_name, p.last_name, d.specialty
FROM patients p
JOIN admission a ON p.patient_id = a.patient_id
JOIN doctors d    ON a.doctor_id  = d.doctor_id
WHERE a.diagnosis = 'Epilepsy'
  AND d.first_name = 'Lisa';


 
 