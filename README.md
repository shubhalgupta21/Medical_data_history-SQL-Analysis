# Medical_data_history
# Medical Data History – SQL Database

## Objective
A small relational database (MySQL Workbench model, schema `medical_data_history`) that stores hospital patient records, admissions, and doctors. It is designed for practice and analysis of healthcare data using SQL: joins, aggregations, filtering, and date-based queries.

## Schema (4 tables)

| Table | Purpose | Key columns |
|---|---|---|
| `patients` | Patient demographics and body measurements | `patient_id`, `first_name`, `last_name`, `gender`, `birth_date`, `city`, `province_id`, `allergies`, `height`, `weight` |
| `admission` | Hospital admission history | `patient_id`, `admission_date`, `discharge_date`, `diagnosis`, `attending_doctor_id` |
| `doctors` | Doctor information | `doctor_id`, `first_name`, `last_name`, `specialty` |
| `province_names` | Lookup table for provinces | `province_id`, `province_name` |

## Relationships
- `admission.patient_id` → `patients.patient_id`
- `admission.attending_doctor_id` → `doctors.doctor_id`
- `patients.province_id` → `province_names.province_id`

> Note: these links are logical only. The model defines no primary or foreign key constraints.

## Analysis Possibilities
- **Patient demographics:** counts by gender, age group, city, or province
- **Admissions:** volume over time, average length of stay (discharge minus admission date)
- **Diagnoses:** most common diagnoses and how they vary by province or gender
- **Doctor workload:** admissions per doctor and per specialty
- **Health indicators:** BMI from height and weight, allergy frequency

## Example Query
```sql
-- Admissions per doctor specialty
SELECT d.specialty, COUNT(*) AS total_admissions
FROM admission a
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
GROUP BY d.specialty
ORDER BY total_admissions DESC;
```



## Files
- `medical_data_history_sql.mwb` – MySQL Workbench model
