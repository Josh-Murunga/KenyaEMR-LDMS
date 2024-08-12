SET @startDate = '{startDate}';
SET @endDate = '{endDate}';
SET @period = '{period}';

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "jkE5MiQ5Nsd" data_element,
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'MnNbWzKj92w',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'bMR6WehEkaL',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'IbwC98Y6wv9',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'hAQlJo0vnLI',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'BL7U0n5sCce',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'OMPEJ0X1UnT',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'UuOm2sjNOy0',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'XLAjkeDyJqd',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'HGt058gjl7V',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'GsWvYjMHdoG',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'kj4zDFNCRHu',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'lMrzUwAcvQp',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'N3WecmaiedE',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'hC1bOxRESGT',
	IF(tx.age_group = '50+yrs' AND tx.gender = 'F',   'uJqH0q2NLVC',  
	IF(tx.age_group = '50+yrs' AND tx.gender = 'M',   'ghjeGOM4BLW', NULL)))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
FROM (
SELECT p.`patient_id`, p.`Gender`, p.`DOB`, TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) AS age, ou.organization_unit,
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 15 AND 19, '15-19yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 20 AND 24, '20-24yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 25 AND 29, '25-29yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 30 AND 34, '30-34yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 35 AND 39, '35-39yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 40 AND 44, '40-44yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 45 AND 49, '45-49yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) > 49, '50+yrs', NULL)))))))) age_group
FROM kenyaemr_etl.etl_patient_demographics p
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.patient_id IN
(SELECT hts.patient_id 
FROM kenyaemr_etl.etl_hts_test hts 
WHERE hts.test_strategy = 166606 
AND hts.patient_given_result ='Yes'
AND hts.`final_test_result` = 'Positive'
AND hts.voided =0 
AND hts.visit_date BETWEEN DATE(@startDate) AND DATE(@endDate) 
GROUP BY hts.patient_id)
                                   ) tx GROUP BY tx.gender, tx.age_group

-- KP Section
UNION SELECT "Q47xXa78tsE" data_element, (CASE t.key_population_type
					WHEN 'Female sex worker' THEN 'gNjREqP1dq8'
					WHEN 'Men who have sex with men' THEN 'G0alyNeHzFt'
					WHEN 'Transgender' THEN 'ZFiEPANua6x'
					WHEN 'Fisher folk' THEN 'AbrdwgGtlZP'
					WHEN 'Prisoner' THEN 'hF8G1rUSaDu'
					END) category_option, t.`organization_unit`, @period period,
		COUNT(t.key_population_type) `value` 
FROM (
SELECT hts.`patient_id`, ou.organization_unit, hts.key_population_type
FROM kenyaemr_etl.etl_hts_test hts 
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE hts.test_strategy = 166606 
AND hts.patient_given_result ='Yes'
AND hts.`final_test_result` = 'Positive'
AND hts.voided =0 
AND hts.visit_date BETWEEN DATE(@startDate) AND DATE(@endDate)                                   
                                GROUP BY hts.`patient_id` ) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type

-- PWID Section
UNION SELECT "yJMONiQAMic" data_element, IF(t.key_population_type = 'People who inject drugs' AND t.Gender = 'F','UXCXK9rZDyA',
					IF(t.key_population_type = 'People who inject drugs' AND t.Gender = 'M', 'atUgyygz96r',
					NULL)) category_option, t.`organization_unit`, @period period,
		COUNT(t.key_population_type) `value` 
FROM (
SELECT hts.`patient_id`, ou.organization_unit, hts.key_population_type, p.`Gender`
FROM kenyaemr_etl.etl_hts_test hts 
INNER JOIN kenyaemr_etl.`etl_patient_demographics` p ON p.`patient_id` = hts.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE hts.test_strategy = 166606 
AND hts.patient_given_result ='Yes'
AND hts.`final_test_result` = 'Positive'
AND hts.voided =0 
AND hts.visit_date BETWEEN DATE(@startDate) AND DATE(@endDate)                                   
GROUP BY hts.`patient_id` ) t WHERE t.key_population_type IS NOT NULL AND t.key_population_type='People who inject drugs' GROUP BY t.key_population_type;