SET @startDate = '{startDate}';
SET @endDate = '{endDate}';
SET @period = '{period}';

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "Cmipfw1GJss" data_element,
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
(SELECT t.patient_id
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
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
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t)
AND p.`patient_id` IN 
(SELECT b.patient_id FROM (SELECT ds.`patient_id`,
MID(MAX(CONCAT(ds.`visit_date`, ds.`PHQ_9_rating`)),11) PHQ_9_rating
FROM kenyaemr_etl.`etl_depression_screening` ds
WHERE ds.visit_date BETWEEN DATE(@startDate) AND DATE(@endDate) GROUP BY ds.patient_id
HAVING PHQ_9_rating = 126627) b)
                                   ) tx GROUP BY tx.gender, tx.age_group;

