SET @startDate = '{startDate}';
SET @endDate = '{endDate}';
SET @period = '{period}';

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "g09W6VBWek3" data_element,
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
(SELECT hts.patient_id FROM kenyaemr_etl.etl_hts_test hts 
WHERE hts.patient_given_result ='Yes'
AND hts.`test_type` = 1
AND hts.voided =0 AND hts.visit_date
BETWEEN DATE(@startDate) AND DATE(@endDate) GROUP BY hts.patient_id)
AND p.`patient_id` IN 
(SELECT b.patient_id FROM (SELECT gad.`patient_id`,
MID(MAX(CONCAT(gad.`visit_date`, gad.`assessment_outcome`)),11) assessment_outcome
FROM kenyaemr_etl.`etl_generalized_anxiety_disorder` gad
WHERE gad.visit_date BETWEEN DATE(@startDate) AND DATE(@endDate) GROUP BY gad.patient_id) b)
                                   ) tx GROUP BY tx.gender, tx.age_group;

