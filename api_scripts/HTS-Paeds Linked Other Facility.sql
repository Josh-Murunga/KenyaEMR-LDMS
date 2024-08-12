SET @startDate = '{startDate}';
SET @endDate = '{endDate}';
SET @period = '{period}';

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "Su9h5KD9b4z" data_element,
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F',   'DsflOPtoZnn',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M',   'R0GVz4NZhvW',
	 NULL)) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
FROM (
SELECT p.`patient_id`, p.`Gender`, p.`DOB`, TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) AS age, ou.organization_unit,
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) BETWEEN 1 AND 4, '1-4yrs',
	NULL) age_group
FROM kenyaemr_etl.etl_patient_demographics p
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.patient_id IN
(SELECT hts.patient_id 
FROM kenyaemr_etl.etl_hts_test hts
INNER JOIN kenyaemr_etl.`etl_hts_referral_and_linkage` l ON hts.`patient_id`=l.`patient_id`
WHERE hts.hts_entry_point IN (162181) 
AND hts.test_strategy NOT IN (161557,166606)
AND hts.patient_given_result ='Yes'
AND hts.`final_test_result`='Positive'
AND l.`referral_facility` = 'Other health facility'
AND hts.voided =0 
AND hts.visit_date BETWEEN DATE(@startDate) AND DATE(@endDate) 
GROUP BY hts.patient_id)
                                   ) tx GROUP BY tx.gender, tx.age_group;
