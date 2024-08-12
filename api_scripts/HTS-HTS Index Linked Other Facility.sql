SET @startDate = '{startDate}';
SET @endDate = '{endDate}';
SET @period = '{period}';

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "Gey6krEKg2R" data_element,
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F',   'f772RkF9HsQ',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M',   'k7obQaTU5Ec',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F',   'ZwFTjlnDnRY',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M',   'QoUFS3eTmSl',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'WdMEpuaaqCX',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'lBgueWKPID8',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'zamGNj4c9vW',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'ThoEFTzrR3O',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'MaysisG4TT4',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'XZAGKBG99PX',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'LdPlzaDJEfu',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'NLdSpdlYXUb',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'w7QMCmp4eoB',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'j2R8zXPoxCE',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'cJx7Gn2PqgS',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'cAaxoMrQ8Sb',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'xPK18RMY531',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'L1kzTQrBIFG',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'NWX4jSXVaso',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'e2bwRGKUFLs',
	IF(tx.age_group = '50+yrs' AND tx.gender = 'F',   'JJ3yep4K523',  
	IF(tx.age_group = '50+yrs' AND tx.gender = 'M',   'MxNiwRtDktP', NULL)))))))))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
FROM (
SELECT p.`patient_id`, p.`Gender`, p.`DOB`, TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) AS age, ou.organization_unit,
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
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) > 49, '50+yrs', NULL))))))))))) age_group
FROM kenyaemr_etl.etl_patient_demographics p
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.patient_id IN
(SELECT hts.patient_id 
FROM kenyaemr_etl.etl_hts_test hts
INNER JOIN kenyaemr_etl.`etl_hts_referral_and_linkage` l ON hts.`patient_id`=l.`patient_id`
WHERE hts.test_strategy = 161557
AND hts.patient_given_result ='Yes'
AND hts.`final_test_result`='Positive'
AND l.`referral_facility` = 'Other health facility'
AND hts.voided =0 
AND hts.visit_date BETWEEN DATE(@startDate) AND DATE(@endDate) 
GROUP BY hts.patient_id)
                                   ) tx GROUP BY tx.gender, tx.age_group

-- KP Section
UNION SELECT "NaCxoQZcpkS" data_element, (CASE t.key_population_type
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
INNER JOIN kenyaemr_etl.`etl_hts_referral_and_linkage` l ON hts.`patient_id`=l.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE hts.test_strategy = 161557
AND hts.patient_given_result ='Yes'
AND hts.`final_test_result`='Positive'
AND l.`referral_facility` = 'Other health facility'
AND hts.voided =0 
AND hts.visit_date BETWEEN DATE(@startDate) AND DATE(@endDate) 
GROUP BY hts.patient_id) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type

-- PWID Section
UNION SELECT "u2EoLif4vHL" data_element, IF(t.key_population_type = 'People who inject drugs' AND t.Gender = 'F','UXCXK9rZDyA',
					IF(t.key_population_type = 'People who inject drugs' AND t.Gender = 'M', 'atUgyygz96r',
					NULL)) category_option, t.`organization_unit`, @period period,
		COUNT(t.key_population_type) `value` 
FROM (
SELECT hts.`patient_id`, ou.organization_unit, hts.key_population_type, p.Gender
FROM kenyaemr_etl.etl_hts_test hts 
INNER JOIN kenyaemr_etl.`etl_hts_referral_and_linkage` l ON hts.`patient_id`=l.`patient_id`
LEFT JOIN kenyaemr_etl.`etl_patient_demographics` p ON p.`patient_id` = hts.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE hts.test_strategy = 161557
AND hts.patient_given_result ='Yes'
AND hts.`final_test_result`='Positive'
AND l.`referral_facility` = 'Other health facility'
AND hts.voided =0 
AND hts.visit_date BETWEEN DATE(@startDate) AND DATE(@endDate) 
GROUP BY hts.`patient_id` ) t WHERE t.key_population_type IS NOT NULL AND t.key_population_type='People who inject drugs' GROUP BY t.key_population_type;



