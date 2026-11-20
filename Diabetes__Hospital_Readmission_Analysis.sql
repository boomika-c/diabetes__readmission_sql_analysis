--display data
select * from diabetic_data;

--Total patient
select count(*) from diabetic_data;

--Age groups
select age from diabetic_data group by age order by age;

--Gender distribution
select gender,count(gender)as total_gender from diabetic_data 
group by gender order by gender;

--Patients by age group
select age,count(age)as total_patients from diabetic_data group by age 
order by age ;

--Hospital Readmission
select readmitted,count(readmitted) from diabetic_data group by readmitted;

--Insulin Treatment
select insulin,count(insulin) from diabetic_data group by insulin 
order by insulin;

--calculate total number of patients encounter
select count(encounter_id)from diabetic_data;

--calculate the total number of unique patients
select count(distinct patient_nbr)as unique_patients from diabetic_data;

--percentage of patients upon age group
select age,count(age) as total_patients,round(count(*)*100.0/(select count(*)
from diabetic_data),2)as percentage from diabetic_data 
group by age order by age;

--race distribution of the patients
select race,count(race)from diabetic_data group by race order by race;

----distribution among gender
select age,gender,count(*)from diabetic_data group by age,gender order by
age,gender;

--Total hospital admission
select admission_type_id,count(admission_type_id)as hospital_admissions 
from diabetic_data group by admission_type_id order by hospital_admissions; 

--number of patients admitted through each admission source
select admission_source_id,count(admission_source_id)as patients_admitted 
from diabetic_data group by admission_source_id order by patients_admitted;

--patients admission by age group
select age,admission_source_id,count(*)as patients_admission
from diabetic_data group by age,admission_source_id 
order by age,admission_source_id;

--average hospital stay for each age group
select age,avg(time_in_hospital)as average_hospital_stay from diabetic_data 
group by age,time_in_hospital order by age,time_in_hospital;

--max and min and average stay
select min(time_in_hospital)as lowest_stay,max(time_in_hospital)as 
highest_stay,round(avg(time_in_hospital),2)as avg_stay from diabetic_data;
select age,round(avg(time_in_hospital),1)as average_stay from diabetic_data
group by age order by average_stay desc fetch first 1 row only;

--hospital stays by gender
select gender,round(avg(time_in_hospital),2) as avg_hospital_stay,
max(time_in_hospital)as highest_stay,min(time_in_hospital)as lowest_stay 
from diabetic_data group by gender order by avg_hospital_stay desc;

--average number of lab procedure
select encounter_id,round(avg(num_lab_procedures),2)as avg_lab_procedures
from diabetic_data
group by encounter_id,num_lab_procedures order by num_lab_procedures;

--average number of procedures
select encounter_id,round(avg(num_procedures),2)as avg_procedures 
from diabetic_data group by encounter_id,num_procedures
order by num_procedures;

--unique gender values
select gender,count(distinct gender)as unique_gender from diabetic_data group by gender 
order by unique_gender;

--male and female encounters
select gender,count(*) from diabetic_data group by gender
order by gender;

--patients whose hospital_stay was more than 5 days
select time_in_hospital from diabetic_data where time_in_hospital>5;

--patient was readmitted within 30days
select encounter_id,readmitted from diabetic_data where readmitted='<30';

--female encounters in age group of 50-60
select encounter_id,age from diabetic_data where age='[50-60)';

--encounters with hospital_stay over 7 days and more than 10 medications
select encounter_id,time_in_hospital,num_medications 
from diabetic_data where time_in_hospital>7 and num_medications>10;

--encounters sorted by hospital_stay in descending order
select encounter_id,time_in_hospital
from diabetic_data order by time_in_hospital desc;

--encounters where insulin prescribed other than no
select encounter_id,insulin from diabetic_data where insulin<>'No';

--encounters  where diabetes medication was recorded as yes
select encounter_id,diabetesmed from diabetic_data where diabetesmed='Yes';

--encounters with an A1c result above 7
select encounter_id,a1cresult from diabetic_data where a1cresult='>7';

--total number of encounters in each readmission category
select readmitted,count(*)as total_encounters from diabetic_data
group by readmitted;

--average hospital stay for each gender
select gender,round(avg(time_in_hospital),2)as avg_stay from diabetic_data 
group by gender order by avg_stay;

--average number medications used in each age group
select age,round(avg(num_medications),2)as avg_medications from diabetic_data 
group by age order by avg_medications;

--Top 5 age groups with  highest number of encounters
select age,count(encounter_id)as total_encounters 
from diabetic_data group by age order by total_encounters desc
fetch first 5 rows only;

--percentage of encounters followed by readmission(<30 or 30)
select round(sum(case when readmitted in('>30','<30')then 1
else 0 end)*100/count(*),2)as readmission_percentage from diabetic_data; 

--number of unique patients with metformin recorded as something other than no
select count(distinct patient_nbr)as unique_patient from diabetic_data 
where metformin<>'no';

--average number of lab procedures in each readmission category
select readmitted,round(avg(num_lab_procedures),2)as avg_procedures
from diabetic_data group by readmitted order by avg_procedures;

--age group with the highest readmission encounter count
select age,total_readmission from(select age,count(age)as total_readmission from 
diabetic_data where readmitted in('>30','<30') group by age order by 
total_readmission desc)where rownum=1 ;

--compare average hospital stay for encounters with and without insulin
select case when insulin='No' then 'without insulin'
else 'with insulin' end as insulin_status,round(avg(time_in_hospital),2)as
avg_stay from diabetic_data group by case 
when insulin='No' then 'without insulin' else 'with insulin' end;

--top 5 medical specialty by encounter count
select medical_specialty,total_encountercount
from(select medical_specialty,count(*) as 
total_encountercount from diabetic_data where medical_specialty <>'?' 
group by medical_specialty order by
total_encountercount desc)where rownum<=5;

--assign row number for each encounter
select encounter_id,row_number()over(
order by encounter_id)as rownum_patients from diabetic_data; 

--rank age group based on highest number of hospital encounters
select age,count(*)as total_encounters,rank()over(
order by count(*)desc)as rank_agegroup
from diabetic_data group by age order by total_encounters;

--previous hospital stay of each patient
select patient_nbr,encounter_id,time_in_hospital,lag(time_in_hospital)over(
partition by patient_nbr order by encounter_id)as previous_stay from
diabetic_data;

--gender values in upper case 
select gender,upper(gender)as upper_gender from diabetic_data;

--first 3 characters of primary diagnosis
select diag_1,substr(diag_1,1,3)as dia_code from diabetic_data;

--replace unknown medical specialty values(?) with unknown 
select medical_specialty,NVL(nullif(medical_specialty,'?'),'unknown')
as specialty from diabetic_data;

--length of each medical specialty
select medical_specialty,length(medical_specialty) as len_specialty 
from diabetic_data;

--patients who have more than one hospital encounter using inner_join
select d.patient_nbr,d.encounter_id,d.readmitted from diabetic_data d
inner join (select patient_nbr from  diabetic_data group by
patient_nbr having count(*)>1)p on d.patient_nbr=p.patient_nbr;

--each encounter along with the total number of encounters for that patient
select d.patient_nbr,d.encounter_id from diabetic_data d left join
(select patient_nbr,count(*) as total_encounters
from diabetic_data group by patient_nbr)p on d.patient_nbr=p.patient_nbr;

--pairs of different encounters belonging to the same patient 
select a.patient_nbr,a.encounter_id as encounter1,
b.encounter_id as encounter2 from diabetic_data a
inner join diabetic_data b on a.patient_nbr=b.patient_nbr and
a.encounter_id=b.encounter_id;

--identifying missing values
select count(*)as total_records,sum(case when weight='?'
then 1 else 0 end)as missing_weight,
sum(case when medical_specialty='?' then 1 else 0 end)as missing_specialty,
sum(case when payer_code='?' then 1 else 0 end)as missing_payer,
sum(case when race='?' then 1 else 0 end)as missing_race
from diabetic_data;

--identifying null values
select count(*) as total_records,
sum(case when max_glu_serum is null then 1 else 0 end)as missing_glucose,
sum(case when a1cresult is null then 1 else 0 end)as missing_a1c 
from diabetic_data;

--replace question marks with null
create table diabetic_data_raw as select * from diabetic_data;
update diabetic_data set weight=nullif(weight,'?'),
medical_specialty=nullif(medical_specialty,'?'),
payer_code=nullif(payer_code,'?'),race=nullif(race,'?'),
diag_1=nullif(diag_1,'?'),diag_2=nullif(diag_2,'?'),
diag_3=nullif(diag_3,'?');

--handling null values
select medical_specialty,
coalesce(medical_specialty,'unknown')as specialty_status,payer_code,
coalesce(payer_code,'unknown')as code_status
from diabetic_data;

--identify the duplicates
select encounter_id,count(*) as total_count from diabetic_data 
group by encounter_id having count(*)>1 order by encounter_id;

--exact duplicate record check
select encounter_id,
patient_nbr,race,gender,age,weight,admission_type_id,discharge_disposition_id,
admission_source_id,time_in_hospital,payer_code,medical_specialty,
num_lab_procedures,num_procedures,num_medications,number_outpatient,
number_emergency,number_inpatient,diag_1,diag_2,diag_3,number_diagnoses,
max_glu_serum,a1cresult,metformin,repaglinide,nateglinide,chlorpropamide,
glimepiride,acetohexamide,glipizide,glyburide,tolbutamide,pioglitazone,
rosiglitazone,acarbose,miglitol,troglitazone,tolazamide,examide,citoglipton,
insulin,glyburide_metformin,glipizide_metformin,glimepiride_pioglitazone,
metformin_pioglitazone,metformin_rosiglitazone,change,diabetesmed,readmitted,
count(*) as duplicate_count from diabetic_data group by encounter_id,
patient_nbr,race,gender,age,weight,admission_type_id,discharge_disposition_id,
admission_source_id,time_in_hospital,payer_code,medical_specialty,
num_lab_procedures,num_procedures,num_medications,number_outpatient,
number_emergency,number_inpatient,diag_1,diag_2,diag_3,number_diagnoses,
max_glu_serum,a1cresult,metformin,repaglinide,nateglinide,chlorpropamide,
glimepiride,acetohexamide,glipizide,glyburide,tolbutamide,pioglitazone,
rosiglitazone,acarbose,miglitol,troglitazone,tolazamide,examide,citoglipton,
insulin,glyburide_metformin,glipizide_metformin,glimepiride_pioglitazone,
metformin_pioglitazone,metformin_rosiglitazone,change,diabetesmed,readmitted
having count(*)>1;