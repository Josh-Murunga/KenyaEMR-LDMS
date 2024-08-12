SET @startDate = '{startDate}';
SET @endDate = '{endDate}';
SET @period = '{period}';

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "P7iapDztmV1" data_element,
	IF(tx.age_group = '< 10yrs' AND tx.gender = 'F',  'TyVXbgponQ9',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'ggihUYFY4mz',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'bhbdJICD6JL',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'lXwkJAoHWwR',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'GOgpeujeCSq',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'MXOKS3jDsGk',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'kQ3j1Mqt0BJ',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'gRRvzw920Kk',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'P8MTgwuL1E3',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'muKlCDbozi5',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'R2L5JkCRE8g',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'EsR6b0k5V8P',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F',   'Qw1EUTy2Kfx',  
	 NULL))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
FROM (
SELECT p.`patient_id`, p.`Gender`, p.`DOB`, TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) AS age, ou.organization_unit,
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) < 10, '< 10yrs',
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
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) > 64, '65+yrs', NULL))))))))))))) age_group
FROM kenyaemr_etl.etl_patient_demographics p
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.patient_id IN
(SELECT first_anc.patient_id FROM (SELECT anc1.patient_id, MIN(anc1.visit_date) visit_date FROM
(SELECT t.patient_id, t.visit_date
FROM kenyaemr_etl.etl_hts_test t
INNER JOIN kenyaemr_etl.`etl_hts_referral_and_linkage` l ON t.`patient_id`=l.`patient_id`
WHERE t.test_type = 1
AND t.patient_given_result ='Yes'
AND t.`final_test_result`= 'Positive'
AND l.`referral_facility` = 'Other health facility'
AND t.hts_entry_point = 160538
AND t.test_strategy NOT IN (161557,166606)) anc1 
GROUP BY anc1.patient_id
HAVING visit_date BETWEEN DATE(@startDate) AND DATE(@endDate)) first_anc)) tx GROUP BY tx.gender, tx.age_group;