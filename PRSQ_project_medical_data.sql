select * from admissions;
select * from doctors;
select * from patients;
select * from province_names;

show tables;

-- first name, last name, and gender of patients whose gender is 'M'
SELECT first_name, last_name, gender
FROM patients
WHERE gender = 'M';


-- first name and last name of patients who do not have allergies
SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL;


-- first name of patients that start with the letter 'C'
SELECT first_name
FROM patients
WHERE first_name LIKE 'C%';


-- first name and last name of patients that weigh between 100 and 120 inclusive
SELECT first_name, last_name
FROM patients
WHERE weight BETWEEN 100 AND 120;


-- Update allergies column. Replace NULL allergies with 'NKA'
SELECT 
  first_name,
  last_name,
  COALESCE(allergies, 'NKA') AS allergies
FROM patients;


-- first name and last name concatenated into one column as full name
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;


-- first name, last name, and full province name of each patient
SELECT p.first_name, p.last_name, pr.province_name
FROM patients p
JOIN province_names pr
ON p.province_id = pr.province_id;


-- how many patients were born in the year 2010
SELECT COUNT(*) AS total_patients
FROM patients
WHERE YEAR(birth_date) = 2010;


-- first_name, last_name, and height of the tallest patient
SELECT first_name, last_name, height
FROM patients
WHERE height = (SELECT MAX(height) FROM patients);


-- all columns for patients with patient_ids 1, 45, 534, 879, 1000
SELECT *
FROM patients
WHERE patient_id IN (1, 45, 534, 879, 1000);


--  the total number of admissions
SELECT COUNT(*) AS total_admissions
FROM admissions;


-- all columns from admissions where patient was admitted and discharged on the same day
SELECT *
FROM admissions
WHERE admission_date = discharge_date;


-- the total number of admissions for patient_id 579
SELECT COUNT(*) AS total_admissions
FROM admissions
WHERE patient_id = 579;


-- unique cities that are in province_id 'NS'
SELECT DISTINCT city
FROM patients
WHERE province_id = 'NS';


-- first_name, last_name, and birth_date of patients with height > 160 and weight > 70
SELECT first_name, last_name, birth_date
FROM patients
WHERE height > 160
AND weight > 70;


-- unique birth years from patients ordered ascending
SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM patients
ORDER BY birth_year ASC;


-- Show unique first names that occur only once
SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(*) = 1;


-- patient_id and first_name where first_name starts and ends with 's' and is at least 6 characters long
SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE 's%s'
AND LENGTH(first_name) >= 6;


--  patient_id, first_name, last_name of patients diagnosed with 'Dementia'
SELECT p.patient_id, p.first_name, p.last_name
FROM patients p
JOIN admissions a
ON p.patient_id = a.patient_id
WHERE a.diagnosis = 'Dementia';


-- every patient's first_name ordered by length and alphabetically
SELECT first_name
FROM patients
ORDER BY LENGTH(first_name), first_name;


-- total male and female patients in the same row
SELECT
SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS male_count,
SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS female_count
FROM patients;


-- patients admitted multiple times for the same diagnosis
SELECT patient_id, diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;


-- city and total number of patients in each city
SELECT city, COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC, city ASC;


-- first name, last name and role of every patient and doctor
SELECT first_name, last_name, 'Patient' AS role
FROM patients
UNION
SELECT first_name, last_name, 'Doctor' AS role
FROM doctors;


-- all allergies ordered by popularity and remove NULL values
SELECT allergies, COUNT(*) AS popularity
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY popularity DESC;


-- patients born in the 1970s ordered by earliest birth_date
SELECT first_name, last_name, birth_date
FROM patients
WHERE birth_date BETWEEN '1970-01-01' AND '1979-12-31'
ORDER BY birth_date ASC;


-- full name as LASTNAME,firstname
SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS full_name
FROM patients
ORDER BY first_name DESC;


-- province_id and total height where sum(height) >= 7000
SELECT province_id, SUM(height) AS total_height
FROM patients
GROUP BY province_id
HAVING SUM(height) >= 7000;


--  difference between maximum and minimum weight for last name 'Maroni'
SELECT MAX(weight) - MIN(weight) AS weight_difference
FROM patients
WHERE last_name = 'Maroni';


-- each day of month and number of admissions on that day
SELECT DAY(admission_date) AS day_of_month,
COUNT(*) AS total_admissions
FROM admissions
GROUP BY DAY(admission_date)
ORDER BY total_admissions DESC;


-- Group patients into weight groups
SELECT
FLOOR(weight / 10) * 10 AS weight_group,
COUNT(*) AS total_patients
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;


--  patient_id, weight, height and obesity status
SELECT
patient_id,
weight,
height,
CASE
WHEN weight / POWER(height / 100, 2) >= 30 THEN 1
ELSE 0
END AS isObese
FROM patients;

SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    d.specialty
FROM patients p
JOIN admissions a
    ON p.patient_id = a.patient_id
JOIN doctors d
    ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy'
  AND d.first_name = 'Lisa';
  


