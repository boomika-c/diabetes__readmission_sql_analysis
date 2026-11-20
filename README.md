# Diabetes Hospital Readmission Analysis (SQL)

An end-to-end SQL analysis of 100,000+ hospital encounters of diabetic patients. The project answers business-style questions about patient demographics, hospital stays, treatments and readmissions, and includes data cleaning and quality checks.

## Project Objective

To explore a real-world healthcare dataset using SQL and answer questions that help a hospital understand:

- Who its diabetic patients are (age, gender, race)
- How long patients stay and how they are admitted
- Which treatments (insulin, metformin) are common
- How often patients are readmitted, and in which groups

## Dataset

- **Source:** Diabetes 130-US hospitals dataset (1999–2008), `diabetic_data.csv`
- **Size:** 101,766 encounters, 71,518 unique patients, 50 columns
- **Key columns:** `encounter_id`, `patient_nbr`, `race`, `gender`, `age`, `time_in_hospital`, `num_lab_procedures`, `num_procedures`, `num_medications`, `insulin`, `metformin`, `A1Cresult`, `diabetesMed`, `readmitted`
- **Readmitted values:** `NO`, `>30` (readmitted after 30 days), `<30` (readmitted within 30 days)
- **Data quality notes:** missing values are stored as `?` (for example `weight`, `payer_code`, `medical_specialty`, `race`, `diag_1/2/3`)

## Tools Used

- SQL (Oracle SQL syntax: `FETCH FIRST`, `ROWNUM`, `NVL`)
- Table: `diabetic_data` (loaded from the CSV)

## SQL Concepts Demonstrated

| Concept | Where it is used |
|---|---|
| Filtering and sorting (`WHERE`, `ORDER BY`) | Long stays, insulin prescribed, A1c above 7 |
| Aggregation (`COUNT`, `AVG`, `MIN`, `MAX`, `SUM`) | Patient counts, average stay, medications per age group |
| `GROUP BY` / `HAVING` | Age, gender, readmission and duplicate checks |
| `CASE WHEN` | Readmission percentage, insulin vs no insulin comparison |
| Subqueries | Age percentage share, top-N queries, repeat patients |
| Window functions (`ROW_NUMBER`, `RANK`, `LAG`) | Row numbering, age-group ranking, previous hospital stay |
| String functions (`UPPER`, `SUBSTR`, `LENGTH`) | Gender case, diagnosis code prefix, specialty length |
| NULL handling (`NULLIF`, `NVL`, `COALESCE`) | Replacing `?` with NULL or "unknown" |
| Joins (inner, left, self) | Patients with multiple encounters, encounters per patient |
| Data cleaning | Missing values, backup table, duplicate detection |

## Questions Answered

### 1. Patient Overview
- How many records and unique patients are in the data?
- What are the age groups, and what percentage of patients falls in each?
- What is the gender and race distribution?
- How are patients distributed by age and gender together?

### 2. Admissions and Hospital Stay
- How many admissions are there by admission type and admission source?
- Which age groups come through which admission sources?
- What are the minimum, maximum and average hospital stay?
- Which age group has the longest average stay?
- How does the average stay differ by gender?
- Which encounters had a stay of more than 5 days, or more than 7 days with over 10 medications?

### 3. Treatment and Medication
- How many encounters used insulin (No, Steady, Up, Down)?
- Which encounters had insulin prescribed, or diabetes medication recorded as "Yes"?
- Which encounters had an A1c result above 7?
- How many unique patients were on metformin?
- Does average hospital stay differ with and without insulin?
- What is the average number of medications per age group?

### 4. Readmission Analysis
- How many encounters fall in each readmission category?
- What percentage of encounters ended in readmission (`<30` or `>30`)?
- Which age group has the highest number of readmissions?
- How do lab procedures differ across readmission categories?
- Which encounters were readmitted within 30 days?

### 5. Ranking and Window Functions
- Top 5 age groups by number of encounters
- Top 5 medical specialties by encounters
- Rank of age groups by encounter volume
- Previous hospital stay of each patient using `LAG`
- Row number assigned to each encounter

### 6. Data Cleaning and Quality Checks
- Counting missing values (`?`) in weight, specialty and race
- Counting NULLs in glucose serum and A1c result
- Creating a raw backup table before cleaning (`diabetic_data_raw`)
- Replacing `?` with NULL, then NULL with "unknown"
- Finding duplicate encounters and exact duplicate records

## Key Findings

- The dataset has **101,766 encounters** from **71,518 unique patients**.
- About **46%** of encounters were followed by a readmission (35,545 after 30 days and 11,357 within 30 days).
- Most patients are aged **60–90**; the **70–80** group is the largest (26,068 encounters).
- Average hospital stay is roughly **4.4 days**, ranging from 1 to 14 days.
- Slightly more than half of the encounters are female (54,708 female vs 47,055 male).
- Roughly **53%** of encounters involved insulin in some form (Steady, Up or Down).
- `weight` is missing in about **97%** of records, so it is not reliable for analysis.

## Repository Structure

```
├── README.md
├── Diabetes__Hospital_Readmission_Analysis.sql   # all queries with comments
└── diabetic_data.csv                             # dataset
```

## How to Run

1. Create a table named `diabetic_data` and import `diabetic_data.csv` into it.
2. Open `Diabetes__Hospital_Readmission_Analysis.sql` in Oracle SQL Developer (or a similar tool).
3. Run the queries one by one. Each query has a comment above it describing the question.
4. Run the cleaning section last, because it modifies the table (a backup table is created first).

## What I Learned

- Writing SQL to answer business questions step by step, from simple counts to window functions
- Cleaning real-world healthcare data with missing values and checking for duplicates
- Turning raw data into insights about readmissions, treatment and patient groups

## Author

**C. Boomika**
Data Analyst | Power BI Developer | MIS
