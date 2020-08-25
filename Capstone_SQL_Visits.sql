--practice query--Length of days a patient stay----
select case_creation_date, fa_program_tracker, fa_program_tracker_status, fa_case_status, fa_flags,patient_visit.admit_date, patient_visit.discharge_date, 
patient_visit.discharge_date - patient_visit.admit_date as los
from patient_finance
join patient_visit on patient_visit.id = patient_finance.pt_fa_id
order by los desc
-----------------------------------------


--identify visits that with cases created--

select  case_creation_date, fa_program_tracker, fa_program_tracker_status, fa_case_status, fa_flags,
patient_visit.admit_date, patient_visit.discharge_date, 
patient_visit.discharge_date - patient_finance.case_creation_date as case_time
from patient_finance
join patient_visit on patient_visit.id = patient_finance.pt_fa_id
where patient_visit.discharge_date - patient_finance.case_creation_date is not null
order by case_time asc
--57 cases were identified--

-------------------------------successful----------------------

--- Identify visits with cases created within less than 30 days ---
select case_creation_date, patient_visit.admit_date, patient_visit.discharge_date, 
patient_visit.discharge_date - patient_finance.case_creation_date as "case_time"
from patient_finance
join patient_visit on patient_visit.id = patient_finance.pt_fa_id
where patient_visit.discharge_date - patient_finance.case_creation_date =<30 --NOT SUCCESSFULL--



select case_creation_date, patient_visit.admit_date, patient_visit.discharge_date,
patient_visit.discharge_date - patient_finance.case_creation_date as "case_time"
from patient_finance
join patient_visit on patient_visit.id = patient_finance.pt_fa_id
where patient_visit.discharge_date - patient_finance.case_creation_date = <30 
group by case_creation_date, patient_visit.admit_date, patient_visit.discharge_date,
patient_visit.discharge_date - patient_finance.case_creation_date; ---NOT SUCCESSFULL--


select  patient.visit_number, patient.patient_first_name, patient.patient_last_name, 
fa_program_tracker, fa_program_tracker_status, fa_case_status, fa_flags, 
case_creation_date, patient_visit.admit_date, patient_visit.discharge_date,
patient_visit.discharge_date - patient_finance.case_creation_date as "case_time"
from patient_finance
join patient_visit on patient_visit.id = patient_finance.pt_fa_id
join patient on patient.pt_id = patient_finance.pt_fa_id
where patient_visit.discharge_date - patient_finance.case_creation_date  <=30
GROUP BY patient.visit_number, patient.patient_first_name, patient.patient_last_name, 
fa_program_tracker, fa_program_tracker_status, fa_case_status, fa_flags, 
case_creation_date, patient_visit.admit_date, patient_visit.discharge_date,
patient_visit.discharge_date - patient_finance.case_creation_date
order by patient_visit.discharge_date - patient_finance.case_creation_date, 
fa_program_tracker, fa_program_tracker_status, fa_case_status, fa_flags, 
patient.visit_number, patient.patient_first_name, patient.patient_last_name desc
----successfull--- 43 rows were found with cases less than or equal to 30; Overview: 43 visits were screened
----within 30 days from the discharge date. Indicating that these patients have seen a Financial Counselor for Financial Assistance.


---Identify visits without cases created---
select  patient.visit_number, patient.patient_first_name, patient.patient_last_name, 
fa_program_tracker, fa_program_tracker_status, fa_case_status, fa_flags, 
case_creation_date, patient_visit.admit_date, patient_visit.discharge_date,
patient_visit.discharge_date - patient_finance.case_creation_date as "case_time"
from patient_finance
join patient_visit on patient_visit.id = patient_finance.pt_fa_id
join patient on patient.pt_id = patient_finance.pt_fa_id
where patient_visit.discharge_date - patient_finance.case_creation_date is null
GROUP BY patient.visit_number, patient.patient_first_name, patient.patient_last_name, 
fa_program_tracker, fa_program_tracker_status, fa_case_status, fa_flags, 
case_creation_date, patient_visit.admit_date, patient_visit.discharge_date,
patient_visit.discharge_date - patient_finance.case_creation_date
order by patient_visit.discharge_date - patient_finance.case_creation_date, 
fa_program_tracker, fa_program_tracker_status, fa_case_status, fa_flags, 
patient.visit_number, patient.patient_first_name, patient.patient_last_name
-- 12 visits were found without a case created by the discharge date--




-- alter table patient_visit
-- alter column admit_date type date USING admit_date::date

-- alter table patient_visit
-- alter column discharge_date type date USING discharge_date::date

-- alter table patient_finance
-- alter column case_creation_date type date USING case_creation_date::date

-- alter table patient_finance
-- alter column fa_tracker_status_date_change type date USING fa_tracker_status_date_change::date

--alter table patient_finance
--alter column total_account_charges type numeric USING total_account_charges::numeric
