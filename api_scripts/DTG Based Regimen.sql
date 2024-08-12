SET @startDate = '{startDate}';
SET @endDate = '{endDate}';
SET @period = '{period}';

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "sA9CY63iv5s" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F',   'Ft93NNKkWme',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M',   'Jp8ZIoKLJwW',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F',   'CieTKhUIGjs',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M',   'yYc9iOWITrc',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F',   'pLywOH8O48k',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M',   'tDUzndQEmL8',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'VVNnFy7SGk5',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'WrJ0CPxhIWq',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'XIPuEdpeRX3',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'WBTfIkNyq1E',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'Ls7TGuvSOEy',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'NLkwUyu3O6E',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'ctfrE6Njpxd',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'zY5eOmeLaHL',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'fA5Fm3f5KLz',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'zf4OMh4tSWW',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'Gs8o9k24XXN',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'bxY6F09TQ94',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'E0q5vFzeMFN',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'l9aAOQpTkZx',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'F9AHOPw2810',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'rzvWcDCYR2K',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'M2Bh90QuBMJ',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'Pi0Xqa2roIs',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'KLWszO9JrOK',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'Mm8Y6DvQOoa',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'SOz5CbN2oEf',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'fotihruAZJE',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F',   'hwI6pBBhJKh',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M',   'ZrmzCKFBIFD', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
FROM (
SELECT p.`patient_id`, p.`Gender`, p.`DOB`, TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) AS age, ou.organization_unit,
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) < 1, '< 1yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 1 AND 4, '1-4yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 5 AND 9, '5-9yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 10 AND 14, '10-14yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 15 AND 19, '15-19yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 20 AND 24, '20-24yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 25 AND 29, '25-29yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 30 AND 34, '30-34yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 35 AND 39, '35-39yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 40 AND 44, '40-44yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 45 AND 49, '45-49yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 50 AND 54, '50-54yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 55 AND 59, '55-59yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 60 AND 64, '60-64yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) > 64, '65+yrs', NULL))))))))))))))) age_group
FROM kenyaemr_etl.etl_patient_demographics p
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(de.visit_date,regimen)),11) AS current_regimen,
                           d.patient_id AS disc_patient,
                           d.effective_disc_date AS effective_disc_date,
                           MAX(d.visit_date) AS date_discontinued,
                           de.patient_id AS started_on_drugs
                    FROM kenyaemr_etl.etl_patient_hiv_followup fup
                           JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup.patient_id
                           JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id=e.patient_id
                           LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program='HIV' AND DATE(date_started) <= DATE(@endDate)
                           LEFT OUTER JOIN
                             (SELECT patient_id, COALESCE(DATE(effective_discontinuation_date),visit_date) visit_date,MAX(DATE(effective_discontinuation_date)) AS effective_disc_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                              WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                              GROUP BY patient_id
                             ) d ON d.patient_id = fup.patient_id
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND current_regimen LIKE '%DTG%' AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t)     
 ) tx GROUP BY tx.gender, tx.age_group
;