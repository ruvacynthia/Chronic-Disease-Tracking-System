# Chronic Disease Tracking and Analytics
## Project Overview
This project implements a comprehensive database solution for tracking and analyzing chronic disease data, specifically focusing on urban populations. The system is designed to assist healthcare providers, researchers, and policymakers in monitoring diagnosis rates, treatment plans, hospital visits, medication usage, and patient outcomes related to chronic diseases such as diabetes, hypertension, asthma, and heart disease. By providing actionable insights, this system aims to support better resource allocation, preventive health programs, and targeted interventions to improve urban population health.

### The project includes:

An Online Transaction Processing (OLTP) database for daily operational tasks.

A Dimensional Model (Data Warehouse) for analytical querying and reporting.

ETL (Extract, Transform, Load) processes to move data from the OLTP to the Dimensional Model.

Analytical queries and visualizations to derive insights from the data.

#### Note on Data: The entire dataset used in this project is synthetic and artificially generated solely for demonstration purposes. It does not contain any real-world clinical data.

## Business Problem
Chronic diseases are a growing concern in urban areas due to various factors including lifestyle, environmental stressors, and healthcare disparities. Health organizations require robust systems to effectively track, analyze, and respond to these trends. This project addresses this need by providing a structured database solution that enables:

Tracking: Monitoring diagnosis rates, treatment plans, and medication usage.

Analysis: Identifying disease prevalence, treatment effectiveness, and demographic-specific health trends.

Intervention: Supporting data-driven decisions for resource allocation and preventive health programs.

## Database Architecture
The project utilizes a two-tiered database architecture:

## OLTP Database (PostgreSQL)
The OLTP database is designed for efficient handling of daily transactional operations. It is normalized to reduce data redundancy and ensure data integrity.

### Key Entities:

disease_type: Categories of diseases (e.g., Cardiovascular, Respiratory, Metabolic).

disease: Details about specific diseases, including intensity level.

location: Geographical data (city, state, country).

race: Racial categories of individuals.

person: Personal details and primary location.

race_disease_propensity: Relationship between race and predisposition to diseases.

diseased_patient: Links patients to diseases they have, including severity and dates.

medicine: Details about medications.

indication: Links medicines to diseases they treat, with effectiveness percentages.

### ER Diagram:
(Refer to ER_Diagram.png in the repository for a visual representation of the OLTP schema.)

### Integrity Constraints:
The OLTP database enforces various integrity constraints, including primary and foreign keys, to maintain data consistency. Examples of operations demonstrating these constraints are included in the SQL code.

## Dimensional Model (Data Warehouse - PostgreSQL)
The Dimensional Model is optimized for analytical queries and reporting. It follows a star schema design, making it easy to slice and dice data across various business dimensions.

Grain: The grain of the fact table is at the Person-Diagnosis-Date Level. Each record represents a single disease diagnosis for a patient on a specific date, including details like disease type, severity, treatment used, and effectiveness.

Fact Table:

fact_disease_diagnosis: Contains measures like severity_value and effectiveness_percent, linked to various dimensions.

## Dimension Tables:

dim_date: Provides date context (year, month, day, quarter).

dim_disease: Describes diseases (name, type, intensity).

dim_person: Identifies individuals (full name, gender, birth year).

dim_location: Provides geographic context (city, state, country).

dim_medicine: Captures medication details (name, active ingredient).

dim_race: Holds race/ethnicity context.

### Dimensional Model Diagram:
(Refer to Dimensional_Model_Diagram.png in the repository for a visual representation of the dimensional schema.)

### ETL Process
An ELT (Extract, Load, Transform) process is used to populate the Dimensional Model from the OLTP database.

Extract: Data is pulled from the normalized tables in the OLTP schema.

Load: The extracted data is loaded into the warehouse schema, which houses the dimensional model.

Transform: SQL scripts are used to join, enrich, and reshape the data, matching keys between fact and dimension tables, cleaning formats, and calculating aggregates.

### Analytical Queries and Visualizations
The Dimensional Model supports robust analytical queries to derive key insights. Examples of analytical queries include:

Which race is most affected by high-intensity diseases?

How effective are medicines by disease type?

Which city has the highest average disease severity?

These insights are further visualized in an analytical dashboard (e.g., using Tableau, as shown in the presentation slides) to provide a clear and actionable overview of chronic disease trends.

### Key Analysis Capabilities Visualized:

Age Distribution: Understanding disease impact across different age groups.

Disease Risk by Race (Propensity): Highlighting health disparities and susceptibilities.

Prevalent Diseases: Identifying the most common diseases in the population.

Diagnoses by Location: Pinpointing geographic hotspots for targeted interventions.

Average Effectiveness by Medicine: Supporting evidence-based treatment decisions.

## Other Contributors
Nicollette Mtisi and
Sharman T Koropa
