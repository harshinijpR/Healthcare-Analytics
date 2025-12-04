create database project;
use project;
select * from doctors;
select * from labresults;
select * from treatments;
select * from visits;


-- created a patient table

create table patient_1(
PatientID int primary key,
Gender varchar(20),
DateOfBirth datetime,
Age int,
PhoneNumber varchar(30),
Address varchar(250),
BloodType varchar(10),
EmergencyContact varchar(30),
InsuranceProvider varchar(100),
Sate varchar(30),
City varchar(30),
Country varchar(30),
PolicyNumber varchar(30),
MedicalHistory text,
Race varchar(30),
Ethnicity varchar(30),
MaritalStatus varchar(30),
FirstName varchar(50),
LastName varchar(50),
EmergencyNumber varchar(40),
ChronicConditions Text,
Allergies Text,
ContactNumber varchar(40)
);



-- importing a csv file (patients)
show global  variables like 'local_infile';
set global local_infile=1;

Load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Patient_1.csv'
 into table patient_1
 fields terminated by ','
 enclosed by '"'
 lines terminated by '\n'
 ignore 1 rows;
 
 ## Total Patients
 select * from patients;
 select count( distinct patientID) as Total_patients from patients;
 
 -- Total Doctors
 select count(distinct DoctorID) as Total_doctors from doctors;
 
 -- Total visits
 select count(visitID) as Total_visits from visits;
 
 
 -- Avg Age
 select round(avg(Age),0) as Average_age from patients ;
 
 
 -- Top 5 diagnosis condition
select diagnosis,count(diagnosis) as Count from visits group by diagnosis order by count desc;

-- Follow up rate
select
round((sum(case when `follow up required` ='yes' then 1 else 0 end ) / count(*))*100,1) as follow_Up_rate from visits;



-- Average treatmnet cost per treatment name
select round(avg(`treatment cost`),0) as Average_Cost, `treatment name` from treatments group by `treatment name`; 
 
 
 -- Total lab conducted
select count(`test result`) as `Total lab conducted`from labresults;

-- Percentage of abnormal lab result
select round((sum(case when(`Test result`)= 'abnormal' then 1 else 0 end) / count(*))*100,2) as Abnormal_Percentage from labresults;

-- Total number of (distinct) patients per doctor
SELECT
  d.DoctorID,
  d.doctor_name,
  COUNT(DISTINCT v.PatientID) AS total_patients
FROM doctors d
LEFT JOIN visits v ON d.DoctorID = v.DoctorID
GROUP BY d.DoctorID, d.doctor_name
ORDER BY total_patients desc;

-- Patients (visitdate, reason, medication, test, and result)
select Patients.firstName, visits.`visit Date`, 
	    visits.`Reason for Visit`, 
	    treatments.`Medication Prescribed`,
	    labresults.`Test Name`,
	    labresults.`Test Result`
	FROM Patients
JOIN visits ON Patients.PatientID = visits.PatientID
	LEFT JOIN treatments ON visits.visitID = treatments.visitID
	LEFT JOIN labResults ON visits.visitID = labResults.visitID;
    
 ------------------------------------------------ ******* ----------------------------------------------------------------------------







    
    
    
    
    