SET @startDate = '{startDate}';
SET @endDate = '{endDate}';
SET @period = '{period}';

-- PNC - ANC
INSERT INTO ldwh.dataset_values
SELECT "OkQBWF2SMP5" data_element,
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'TGfKuF6uiXM',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'aBcO3XRyTtW',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'FlrYUN2IzbB',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'he4Wo4feygv',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'zgXZH8BKLU2',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'MjiHoH7RFkb',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'm94g6BI73xo',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'oIQsUbqjAfJ',
	IF(tx.age_group = '50+yrs' AND tx.gender = 'F',   'jT57FCmiY63',  
	 NULL))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
FROM (
SELECT p.`patient_id`, p.`Gender`, p.`DOB`, TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) AS age, ou.organization_unit,
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 10 AND 14, '10-14yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 15 AND 19, '15-19yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 20 AND 24, '20-24yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 25 AND 29, '25-29yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 30 AND 34, '30-34yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 35 AND 39, '35-39yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 40 AND 44, '40-44yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 45 AND 49, '45-49yrs',
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) > 49, '50+yrs', NULL))))))))) age_group
FROM kenyaemr_etl.etl_patient_demographics p
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.patient_id IN
(SELECT hts.patient_id 
FROM kenyaemr_etl.etl_hts_test hts 
INNER JOIN kenyaemr_etl.`etl_hts_referral_and_linkage` l ON hts.`patient_id`=l.`patient_id`
WHERE hts.hts_entry_point IN (160538,160456,1623)
AND hts.test_strategy NOT IN (161557,166606)
AND l.`referral_facility` = 'Other health facility'
AND hts.`final_test_result`= 'Positive'
AND hts.patient_given_result ='Yes'
AND hts.voided =0 
AND hts.visit_date BETWEEN DATE(@startDate) AND DATE(@endDate) 
GROUP BY hts.patient_id)) tx GROUP BY tx.gender, tx.age_group;
