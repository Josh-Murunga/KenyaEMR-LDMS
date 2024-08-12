SET @startDate = '{startDate}';
SET @endDate = '{endDate}';
SET @period = '{period}';

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "cDTdMfB6blZ" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F',   'rFOhkHPpARV',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M',   'VyIyGjVgvl0',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F',   'JgW77QxdCUq',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M',   'PubE0maRFmv',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F',   'ygMOHePvJqU',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M',   'UbkzdDBhG03',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'HG5uKnkigyP',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'C8TpjhIgVGm',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'yZ1ueYAOBAz',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'cUDanZFcFHs',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'bgbnAttmLaK',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'BT8LtjbLSmx',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'KZVgEI9fy3R',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'RdjhE2N7PpO',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'tboRvTnEGV8',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'OXpA7W7gQcl',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'U3s5eJvkvqc',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'NyibeSvVSKt',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'ph2JQ7qHq8E',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'CTiD9t5UVbK',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'Wildsm0R6hM',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'oJrwRBpwGky',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'AQlXpKsfKR1',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'gWUAazZvVxJ',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'PnEQIWwuxZb',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'EjGkM8CODEe',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'vFEpWArrB94',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'BT3hUC1XZuC',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F',   'lBEkRBLpHQp',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M',   'Sd1H5Vh3ajC', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
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
WHERE p.patient_id IN
(SELECT hts.patient_id 
FROM kenyaemr_etl.etl_hts_test hts
INNER JOIN kenyaemr_etl.`etl_hts_referral_and_linkage` l ON hts.`patient_id`=l.`patient_id`
WHERE hts.hts_entry_point IN (160541) 
AND hts.test_strategy NOT IN (161557,166606)
AND hts.patient_given_result ='Yes'
AND hts.`final_test_result`='Positive'
AND l.`referral_facility` = 'This health facility'
AND hts.voided =0 
AND hts.visit_date BETWEEN DATE(@startDate) AND DATE(@endDate) 
GROUP BY hts.patient_id)
                                   ) tx GROUP BY tx.gender, tx.age_group

-- KP Section
UNION SELECT "r5HbZ0bx3AZ" data_element, (CASE t.key_population_type
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
WHERE hts.hts_entry_point IN (160541) 
AND hts.test_strategy NOT IN (161557,166606)
AND hts.patient_given_result ='Yes'
AND hts.`final_test_result`='Positive'
AND l.`referral_facility` = 'This health facility'
AND hts.voided =0 
AND hts.visit_date BETWEEN DATE(@startDate) AND DATE(@endDate) 
GROUP BY hts.patient_id) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type

-- PWID Section
UNION SELECT "GZTrsgmFrko" data_element, IF(t.key_population_type = 'People who inject drugs' AND t.Gender = 'F','UXCXK9rZDyA',
					IF(t.key_population_type = 'People who inject drugs' AND t.Gender = 'M', 'atUgyygz96r',
					NULL)) category_option, t.`organization_unit`, @period period,
		COUNT(t.key_population_type) `value` 
FROM (
SELECT hts.`patient_id`, ou.organization_unit, hts.key_population_type, p.`Gender`
FROM kenyaemr_etl.etl_hts_test hts 
INNER JOIN kenyaemr_etl.`etl_hts_referral_and_linkage` l ON hts.`patient_id`=l.`patient_id`
LEFT JOIN kenyaemr_etl.`etl_patient_demographics` p ON p.`patient_id` = hts.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE hts.hts_entry_point IN (160541) 
AND hts.test_strategy NOT IN (161557,166606)
AND hts.patient_given_result ='Yes'
AND hts.`final_test_result`='Positive'
AND l.`referral_facility` = 'This health facility'
AND hts.voided =0 
AND hts.visit_date BETWEEN DATE(@startDate) AND DATE(@endDate) 
GROUP BY hts.`patient_id` ) t WHERE t.key_population_type IS NOT NULL AND t.key_population_type='People who inject drugs' GROUP BY t.key_population_type;