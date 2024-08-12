SET @startDate = '{startDate}';
SET @endDate = '{endDate}';
SET @period = '{period}';

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "ko6YlFAF1d3" data_element,
	IF(tx.age_group = '0-14yrs'  AND tx.gender = 'F', 'qN4tqYpVM6r',
	IF(tx.age_group = '0-14yrs'  AND tx.gender = 'M', 'GBJi2g9zJl9',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'DXWpMdyGXfU',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'dt8EQAcPvUj',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'OR2O5PxgTvH',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'ib8sdklDEWv',
	IF(tx.age_group = '25+yrs'   AND tx.gender = 'F', 'lUvTF6rt4yg',
	IF(tx.age_group = '25+yrs'   AND tx.gender = 'M', 'P0yVd4aCBlb', NULL)))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
FROM (
SELECT p.`patient_id`, p.`Gender`, p.`DOB`, TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) AS age, ou.organization_unit,
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) < 15, '0-14yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 15 AND 19, '15-19yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 20 AND 24, '20-24yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) > 24, '25+yrs', NULL)))) age_group
FROM kenyaemr_etl.etl_patient_demographics p
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT net.patient_id  
FROM (  
SELECT e.patient_id,e.date_started,  
e.gender, 
e.dob, 
d.visit_date AS dis_date,  
IF(d.visit_date IS NOT NULL, 1, 0) AS TOut, 
e.regimen, e.regimen_line, e.alternative_regimen,  
MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11) AS latest_tca,  
MAX(IF(enr.date_started_art_at_transferring_facility IS NOT NULL AND enr.facility_transferred_from IS NOT NULL, 1, 0)) AS TI_on_art, 
MAX(IF(enr.transfer_in_date IS NOT NULL, 1, 0)) AS TIn,  
MAX(fup.visit_date) AS latest_vis_date 
FROM (SELECT e.patient_id,p.dob,p.Gender,MIN(e.date_started) AS date_started,  
MID(MIN(CONCAT(e.date_started,e.regimen_name)),11) AS regimen,  
MID(MIN(CONCAT(e.date_started,e.regimen_line)),11) AS regimen_line,  
MAX(IF(discontinued,1,0))AS alternative_regimen  
FROM kenyaemr_etl.etl_drug_event e
JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=e.patient_id
WHERE e.program = 'HIV'
GROUP BY e.patient_id) e  
INNER JOIN kenyaemr_etl.etl_hiv_enrollment enr ON enr.patient_id=e.patient_id  
LEFT OUTER JOIN kenyaemr_etl.etl_patient_program_discontinuation d ON d.patient_id=e.patient_id AND d.program_name='HIV' 
LEFT OUTER JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.patient_id=e.patient_id  
WHERE DATE(e.date_started) BETWEEN DATE(@startDate) AND DATE(@endDate)
GROUP BY e.patient_id  
HAVING TI_on_art=0 
)net)
AND p.`patient_id` IN 
(SELECT b.patient_id FROM (SELECT gad.`patient_id`,
MID(MAX(CONCAT(gad.`visit_date`, gad.`assessment_outcome`)),11) assessment_outcome
FROM kenyaemr_etl.`etl_generalized_anxiety_disorder` gad
WHERE gad.visit_date BETWEEN DATE(@startDate) AND DATE(@endDate) GROUP BY gad.patient_id
HAVING assessment_outcome = 1499) b)
                                   ) tx GROUP BY tx.gender, tx.age_group;

