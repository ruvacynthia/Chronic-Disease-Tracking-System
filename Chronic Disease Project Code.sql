--creating OLTP Database
CREATE TABLE disease_type (
    disease_type_code CHAR(5) PRIMARY KEY,
    disease_type_description VARCHAR(1000),
    exclusions_note TEXT
);


CREATE TABLE disease (
    disease_id SERIAL PRIMARY KEY,
    disease_name VARCHAR(100),
    intensity_level INT DEFAULT 1,
    disease_type_cd CHAR(5) REFERENCES disease_type(disease_type_code),
    source_disease_cd INT REFERENCES disease(disease_id)
);

CREATE TABLE location (
    location_id SERIAL PRIMARY KEY,
    city_name VARCHAR(100),
    state_province_name VARCHAR(100),
    country_name VARCHAR(100),
    developing_flag CHAR(1),
    wealth_rank_number INT
);

CREATE TABLE race (
    race_code CHAR(5) PRIMARY KEY,
    race_description VARCHAR(100)
);

CREATE TABLE person (
    person_id SERIAL PRIMARY KEY,
    last_name VARCHAR(50),
    first_name VARCHAR(50),
    gender CHAR(1),
    primary_location_id INT REFERENCES location(location_id),
    race_cd CHAR(5) REFERENCES race(race_code)
);

CREATE TABLE race_disease_propensity (
    race_code CHAR(5) REFERENCES race(race_code),
    disease_id INT REFERENCES disease(disease_id),
    propensity_value INT,
    PRIMARY KEY (race_code, disease_id)
);

CREATE TABLE diseased_patient (
    person_id INT REFERENCES person(person_id),
    disease_id INT REFERENCES disease(disease_id),
    severity_value INT DEFAULT 1,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (person_id, disease_id)
);

CREATE TABLE medicine (
    medicine_id SERIAL PRIMARY KEY,
    standard_industry_number VARCHAR(25),
    name VARCHAR(250),
    company VARCHAR(150),
    active_ingredient_name VARCHAR(150)
);

CREATE TABLE indication (
    medicine_id INT REFERENCES medicine(medicine_id),
    disease_id INT REFERENCES disease(disease_id),
    indication_date DATE,
    effectiveness_percent FLOAT,
    PRIMARY KEY (medicine_id, disease_id)
);

--Populating the tables with data
-- 1. Insert into disease_type
INSERT INTO disease_type (disease_type_code, disease_type_description, exclusions_note) VALUES
('CD', 'Cardiovascular Disease', 'None'),
('RD', 'Respiratory Disease', 'Exclude allergy-based conditions'),
('MD', 'Metabolic Disease', NULL);

-- 2. Insert into race
INSERT INTO race (race_code, race_description) VALUES
('AFR', 'African'),
('ASN', 'Asian'),
('EUR', 'European'),
('LAT', 'Latino');

-- 3. Insert into location (New York-based only)
INSERT INTO location (city_name, state_province_name, country_name, developing_flag, wealth_rank_number) VALUES
('Bronx', 'New York', 'USA', 'N', 4),
('Brooklyn', 'New York', 'USA', 'N', 6),
('Manhattan', 'New York', 'USA', 'N', 9),
('Queens', 'New York', 'USA', 'N', 7),
('Staten Island', 'New York', 'USA', 'N', 8),
('Harlem', 'New York', 'USA', 'N', 5),
('Upper East Side', 'New York', 'USA', 'N', 9),
('SoHo', 'New York', 'USA', 'N', 9),
('Williamsburg', 'New York', 'USA', 'N', 6),
('Long Island City', 'New York', 'USA', 'N', 7);

-- 4. Insert into person
INSERT INTO person (last_name, first_name, gender, primary_location_id, race_cd) VALUES
('Garcia', 'Elena', 'F', 1, 'LAT'),
('Johnson', 'Mike', 'M', 2, 'AFR'),
('Nguyen', 'Linh', 'F', 3, 'ASN'),
('Rodriguez', 'Luis', 'M', 4, 'LAT'),
('White', 'Sarah', 'F', 5, 'EUR'),
('Ali', 'Kareem', 'M', 6, 'AFR'),
('Chen', 'Wei', 'F', 7, 'ASN'),
('Brown', 'James', 'M', 8, 'EUR'),
('Kim', 'Jiwoo', 'F', 9, 'ASN'),
('Walker', 'Tina', 'F', 10, 'AFR');

-- 5. Insert into disease
INSERT INTO disease (disease_name, intensity_level, disease_type_cd, source_disease_cd) VALUES
('Hypertension', 6, 'CD', NULL),
('Asthma', 7, 'RD', NULL),
('Diabetes', 8, 'MD', NULL),
('Heart Failure', 9, 'CD', NULL),
('Bronchitis', 5, 'RD', NULL),
('Obesity', 4, 'MD', NULL),
('Coronary Artery Disease', 8, 'CD', NULL),
('COPD', 7, 'RD', NULL),
('Type 2 Diabetes', 8, 'MD', NULL),
('Stroke', 10, 'CD', NULL);

-- 6. Insert into medicine
INSERT INTO medicine (standard_industry_number, name, company, active_ingredient_name) VALUES
('A100', 'CardioMax', 'PharmaPlus', 'Lisinopril'),
('A101', 'BreathEZ', 'MedAir', 'Albuterol'),
('A102', 'GlucoFix', 'HealCo', 'Insulin'),
('A103', 'HeartSafe', 'CardioGen', 'Ramipril'),
('A104', 'BronchoCare', 'PulmoMed', 'Theophylline'),
('A105', 'SlimAid', 'NutriPharm', 'Orlistat'),
('A106', 'CholestoGo', 'BioHeart', 'Atorvastatin'),
('A107', 'AirRelief', 'RespirTech', 'Tiotropium'),
('A108', 'GlucoBalance', 'MetaHealth', 'Sitagliptin'),
('A109', 'NeuroShield', 'NeuroMed', 'Clopidogrel');

-- 7. Insert into indication
INSERT INTO indication (medicine_id, disease_id, indication_date, effectiveness_percent) VALUES
(1, 1, '2023-01-01', 70.0),
(2, 2, '2023-01-02', 71.5),
(3, 3, '2023-01-03', 73.0),
(4, 4, '2023-01-04', 74.5),
(5, 5, '2023-01-05', 76.0),
(6, 6, '2023-01-06', 77.5),
(7, 7, '2023-01-07', 79.0),
(8, 8, '2023-01-08', 80.5),
(9, 9, '2023-01-09', 82.0),
(10, 10, '2023-01-10', 83.5);

-- 8. Insert into diseased_patient
INSERT INTO diseased_patient (person_id, disease_id, severity_value, start_date, end_date) VALUES
(1, 1, 5, '2022-01-01', NULL),
(2, 2, 6, '2022-01-02', NULL),
(3, 3, 7, '2022-01-03', NULL),
(4, 4, 8, '2022-01-04', NULL),
(5, 5, 9, '2022-01-05', NULL),
(6, 6, 10, '2022-01-06', NULL),
(7, 7, 5, '2022-01-07', NULL),
(8, 8, 6, '2022-01-08', NULL),
(9, 9, 7, '2022-01-09', NULL),
(10, 10, 8, '2022-01-10', NULL);

-- 9. Insert into race_disease_propensity
INSERT INTO race_disease_propensity (race_code, disease_id, propensity_value) VALUES
('AFR', 1, 8),
('AFR', 2, 7),
('ASN', 3, 6),
('EUR', 4, 6),
('LAT', 5, 7),
('EUR', 6, 5),
('LAT', 7, 8),
('ASN', 8, 6),
('AFR', 9, 9),
('EUR', 10, 7);

select * from person

--Analytical queries on OLTP 
 --Patients with Highest Disease Severity in New York
 SELECT 
    p.first_name || ' ' || p.last_name AS patient_name,
    d.disease_name,
    dp.severity_value,
    l.city_name,
    r.race_description
FROM diseased_patient dp
JOIN person p ON dp.person_id = p.person_id
JOIN disease d ON dp.disease_id = d.disease_id
JOIN location l ON p.primary_location_id = l.location_id
JOIN race r ON p.race_cd = r.race_code
ORDER BY dp.severity_value DESC
LIMIT 10;

--Most Common Diseases by Race
SELECT 
    r.race_description,
    d.disease_name,
    COUNT(*) AS patient_count
FROM diseased_patient dp
JOIN person p ON dp.person_id = p.person_id
JOIN race r ON p.race_cd = r.race_code
JOIN disease d ON dp.disease_id = d.disease_id
GROUP BY r.race_description, d.disease_name
ORDER BY r.race_description, patient_count DESC;

--Medicine Effectiveness by Disease
SELECT 
    d.disease_name,
    m.name AS medicine_name,
    i.effectiveness_percent
FROM indication i
JOIN medicine m ON i.medicine_id = m.medicine_id
JOIN disease d ON i.disease_id = d.disease_id
ORDER BY effectiveness_percent DESC;

--List all Patients and their Diagnosed Diseases
SELECT 
    p.first_name || ' ' || p.last_name AS patient_name,
    d.disease_name,
    dp.start_date,
    dp.end_date,
    dp.severity_value
FROM 
    person p
JOIN 
    diseased_patient dp ON p.person_id = dp.person_id
JOIN 
    disease d ON dp.disease_id = d.disease_id
ORDER BY 
    p.last_name;
	
--Find all Medicines and the Diseases they Treat
SELECT 
    m.name AS medicine_name,
    d.disease_name,
    i.effectiveness_percent
FROM 
    medicine m
JOIN 
    indication i ON m.medicine_id = i.medicine_id
JOIN 
    disease d ON i.disease_id = d.disease_id
ORDER BY 
    effectiveness_percent DESC;

--Find number of Patients per City
SELECT 
    l.city_name,
    COUNT(p.person_id) AS number_of_patients
FROM 
    location l
JOIN 
    person p ON l.location_id = p.primary_location_id
GROUP BY 
    l.city_name
ORDER BY 
    number_of_patients DESC;

--Find diseases with the highest severity recorded
SELECT 
    d.disease_name,
    MAX(dp.severity_value) AS max_severity
FROM 
    disease d
JOIN 
    diseased_patient dp ON d.disease_id = dp.disease_id
GROUP BY 
    d.disease_name
ORDER BY 
    max_severity DESC;

--Find propensity of diseases by Race
SELECT 
    r.race_description,
    d.disease_name,
    rdp.propensity_value
FROM 
    race r
JOIN 
    race_disease_propensity rdp ON r.race_code = rdp.race_code
JOIN 
    disease d ON rdp.disease_id = d.disease_id
ORDER BY 
    r.race_description;

--patient_disease_view
CREATE VIEW patient_disease_view AS
SELECT 
    p.person_id,
    p.first_name || ' ' || p.last_name AS full_name,
    d.disease_name,
    dp.start_date,
    dp.severity_value
FROM 
    person p
JOIN 
    diseased_patient dp ON p.person_id = dp.person_id
JOIN 
    disease d ON dp.disease_id = d.disease_id;

SELECT * FROM patient_disease_view

--Checking For integrity constraints
--Update a Patient’s Disease Severity
UPDATE diseased_patient
SET severity_value = 9
WHERE person_id = 1 AND disease_id = 1;

--Insert a New Indication
INSERT INTO indication (medicine_id, disease_id, indication_date, effectiveness_percent)
VALUES (2, 4, '2024-04-01', 78.3);

-- First, get the location_id for Harlem
SELECT location_id FROM location WHERE city_name = 'Harlem';

-- Adding a new patient named “Edwards” (race = European, location = Harlem):
INSERT INTO person (last_name, first_name, gender, primary_location_id, race_cd)
VALUES ('Edwards', 'Thomas', 'M', 6, 'EUR');

--Assume “Edwards” is diagnosed with Diabetes (disease_id = 3):
SELECT person_id FROM person WHERE last_name = 'Edwards' AND first_name = 'Thomas';

-- Suppose his person_id is 11
INSERT INTO diseased_patient (person_id, disease_id, severity_value, start_date, end_date)
VALUES (11, 3, 6, CURRENT_DATE, NULL);

--Mark Edwards’ diabetes treatment as completed
UPDATE diseased_patient
SET end_date = CURRENT_DATE
WHERE person_id = 11 AND disease_id = 3;

--Delete Duplicate or Incorrect Visit Record
DELETE FROM diseased_patient
WHERE person_id = 5 AND disease_id = 5;  --This respects ON DELETE CASCADE by removing the disease reference only, without affecting the person.

--Assume you want to update Mike Johnson’s location to “Manhattan”:
SELECT location_id FROM location WHERE city_name = 'Manhattan';

UPDATE person
SET primary_location_id = 3
WHERE last_name = 'Johnson' AND first_name = 'Mike';

--trying to delete a disease(should fail because of the foreign key constraint)
DELETE FROM disease
WHERE disease_id = 1;

--Try inserting a person with a nonexistent race code XYZ (will fail)
INSERT INTO person (last_name, first_name, gender, primary_location_id, race_cd)
VALUES ('Doe', 'Jane', 'F', 2, 'XYZ');  -- Will raise FOREIGN KEY VIOLATION




--Dimensional Model

CREATE SCHEMA warehouse;
SET search_path TO warehouse;

CREATE TABLE dim_date (
    date_key SERIAL PRIMARY KEY,
    full_date DATE,
    year INT,
    month INT,
    day INT,
    quarter INT
);

CREATE TABLE dim_disease (
    disease_key SERIAL PRIMARY KEY,
    disease_name VARCHAR(100),
    disease_type VARCHAR(1000),
    intensity_level INT
);

CREATE TABLE dim_person (
    person_key SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    gender CHAR(1),
    birth_year INT
);

CREATE TABLE dim_location (
    location_key SERIAL PRIMARY KEY,
    city_name VARCHAR(100),
    state_province_name VARCHAR(100),
    country_name VARCHAR(100),
    developing_flag CHAR(1)
);

CREATE TABLE dim_medicine (
    medicine_key SERIAL PRIMARY KEY,
    medicine_name VARCHAR(250),
    active_ingredient_name VARCHAR(150)
);

CREATE TABLE dim_race (
    race_key SERIAL PRIMARY KEY,
    race_description VARCHAR(100)
);


CREATE TABLE fact_disease_diagnosis (
    fact_id SERIAL PRIMARY KEY,
    person_key INT REFERENCES dim_person(person_key),
    disease_key INT REFERENCES dim_disease(disease_key),
    medicine_key INT REFERENCES dim_medicine(medicine_key),
    race_key INT REFERENCES dim_race(race_key),
    location_key INT REFERENCES dim_location(location_key),
    diagnosis_date_key INT REFERENCES dim_date(date_key),
    severity_value INT,
    effectiveness_percent DOUBLE PRECISION
);

 --ETL TRANSFORMATION: OLTP to DIMENSIONAL MODEL
INSERT INTO warehouse.dim_disease (disease_name, disease_type, intensity_level)
SELECT 
    d.disease_name,
    dt.disease_type_description,
    d.intensity_level
FROM public.disease d
JOIN public.disease_type dt ON d.disease_type_cd = dt.disease_type_code;

INSERT INTO warehouse.dim_person (full_name, gender, birth_year)
SELECT 
    p.first_name || ' ' || p.last_name AS full_name,
    p.gender,
    EXTRACT(YEAR FROM CURRENT_DATE) - FLOOR(RANDOM() * 30 + 20) AS birth_year
FROM public.person p;

INSERT INTO warehouse.dim_location (city_name, state_province_name, country_name, developing_flag)
SELECT 
    city_name,
    state_province_name,
    country_name,
    developing_flag
FROM public.location;

INSERT INTO warehouse.dim_medicine (medicine_name, active_ingredient_name)
SELECT 
    name,
    active_ingredient_name
FROM public.medicine;

INSERT INTO warehouse.dim_race (race_description)
SELECT DISTINCT race_description
FROM public.race;

INSERT INTO warehouse.dim_date (full_date, year, month, day, quarter)
SELECT 
    DISTINCT dp.start_date,
    EXTRACT(YEAR FROM dp.start_date),
    EXTRACT(MONTH FROM dp.start_date),
    EXTRACT(DAY FROM dp.start_date),
    EXTRACT(QUARTER FROM dp.start_date)
FROM public.diseased_patient dp
WHERE dp.start_date IS NOT NULL;


INSERT INTO warehouse.fact_disease_diagnosis (
    person_key, disease_key, medicine_key, race_key, location_key,
    diagnosis_date_key, severity_value, effectiveness_percent
)
SELECT 
    dpn.person_key,
    dd.disease_key,
    dm.medicine_key,
    dr.race_key,
    dl.location_key,
    ddte.date_key,
    dp.severity_value,
    i.effectiveness_percent
FROM public.diseased_patient dp
JOIN public.person p ON dp.person_id = p.person_id
JOIN warehouse.dim_person dpn ON dpn.full_name = p.first_name || ' ' || p.last_name

JOIN public.disease d ON dp.disease_id = d.disease_id
JOIN warehouse.dim_disease dd ON dd.disease_name = d.disease_name

LEFT JOIN public.indication i ON i.disease_id = d.disease_id
LEFT JOIN public.medicine m ON i.medicine_id = m.medicine_id
LEFT JOIN warehouse.dim_medicine dm ON dm.medicine_name = m.name

JOIN public.race r ON p.race_cd = r.race_code
JOIN warehouse.dim_race dr ON dr.race_description = r.race_description

JOIN public.location l ON p.primary_location_id = l.location_id
JOIN warehouse.dim_location dl ON dl.city_name = l.city_name

JOIN warehouse.dim_date ddte ON ddte.full_date = dp.start_date;


--Checking Count
SELECT 
    r.race_description,
    COUNT(f.fact_id) AS total_cases
FROM 
    warehouse.fact_disease_diagnosis f
JOIN 
    warehouse.dim_race r ON f.race_key = r.race_key
GROUP BY 
    r.race_description
ORDER BY 
    total_cases DESC;

--Analytical queries showcasing data

--Which race is most affected by high-intensity diseases?
SELECT dr.race_description, dd.intensity_level, COUNT(*) AS case_count
FROM warehouse.fact_disease_diagnosis f
JOIN warehouse.dim_disease dd ON f.disease_key = dd.disease_key
JOIN warehouse.dim_race dr ON f.race_key = dr.race_key
WHERE dd.intensity_level >= 8
GROUP BY dr.race_description, dd.intensity_level
ORDER BY case_count DESC;


--How effective are medicines by disease type?
SELECT dd.disease_type, dm.medicine_name, AVG(f.effectiveness_percent) AS avg_effectiveness
FROM warehouse.fact_disease_diagnosis f
JOIN warehouse.dim_disease dd ON f.disease_key = dd.disease_key
JOIN warehouse.dim_medicine dm ON f.medicine_key = dm.medicine_key
GROUP BY dd.disease_type, dm.medicine_name
ORDER BY avg_effectiveness DESC;


--Which city has the highest average disease severity?
SELECT dl.city_name, AVG(f.severity_value) AS avg_severity
FROM warehouse.fact_disease_diagnosis f
JOIN warehouse.dim_location dl ON f.location_key = dl.location_key
GROUP BY dl.city_name
ORDER BY avg_severity DESC;


	