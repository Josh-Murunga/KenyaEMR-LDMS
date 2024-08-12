SET @startDate = '{startDate}';
SET @endDate = '{endDate}';
SET @period = '{period}';

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "qnMKgQz3JAV" data_element,
	IF(tx.age_group = '0-9yrs' AND tx.gender = 'F',   'usNNrhxHdZc',
	IF(tx.age_group = '0-9yrs' AND tx.gender = 'M',   'xHRlXtDJ5wf',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'ufIPqBtL6BK',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'I8CCab2Y3yW',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'oE125dQe74X',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'PY7Qkpcb2KR',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'HSg5pVxRP33',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'aHZRG4botaW',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'ZnBPohBY8Ku',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'oJXoA0OQcPi',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'MNehldmptgV',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'evZ1wDJmyOh',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'diFfRSbYXws',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'Q8ZLx821pmn',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'xndVJx59Qml',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'x31R2dZO7El',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'ExDqiGdo860',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'idxnPIdXj1A',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'CLnD3fzgqQz',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'H7VYSkXhgAu',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'UxQe1Tr1x8Q',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'ho3R0uXG84x',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'AICIyVGjxWw',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'xh2Vl7tkrgB',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F',   'BbJa9jO9wE9',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M',   'o8u22I1zS2E', NULL)))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
FROM (
SELECT p.`patient_id`, p.`Gender`, p.`DOB`, TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) AS age, ou.organization_unit,
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) < 10, '0-9yrs',
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
WHERE p.`patient_id` IN
(SELECT a.patient_id
FROM (SELECT r.patient_id,
r.app_visit,
r.return_date,
r.next_appointment_date                                                        AS next_appointment_date,
d.patient_id                                                                   AS disc_patient,
d.visit_date                                                                   AS disc_date,
IF(r.app_visit = r.return_date, 'Never Returned', (CASE
            WHEN 0 > DATEDIFF(return_date, r.next_appointment_date)
                THEN 'Returned early'
            WHEN 0 = DATEDIFF(return_date, r.next_appointment_date)
                THEN 'Honoured'
            WHEN 0 < DATEDIFF(return_date, r.next_appointment_date)
                THEN 'Missed' END)) AS Appointment_status FROM (
-- Returned on or after next appointment date
         SELECT f4.patient_id      AS patient_id,
                f6.app_date           app_visit,
                MIN(f4.visit_date) AS return_date,
                f6.tca             AS next_appointment_date
         FROM kenyaemr_etl.etl_patient_hiv_followup f4
                  LEFT JOIN (SELECT f5.patient_id,
                                    MAX(f5.visit_date)                                            AS app_date,
                                    MID(MAX(CONCAT(f5.visit_date, f5.next_appointment_date)), 11) AS tca
                             FROM kenyaemr_etl.etl_patient_hiv_followup f5
                                      LEFT JOIN kenyaemr_etl.etl_patient_hiv_followup f ON f5.patient_id = f.patient_id
                             WHERE f5.next_appointment_date BETWEEN DATE(@startDate) AND DATE(@endDate)
                             GROUP BY f5.patient_id) f6 ON f4.patient_id = f6.patient_id
         WHERE f4.visit_date > f6.app_date
         GROUP BY f6.patient_id
UNION SELECT f0.patient_id  AS patient_id,
f0.visit_date  AS app_visit, f7.return_date AS return_date, f7.latest_appointment
FROM kenyaemr_etl.etl_patient_hiv_followup f0 LEFT JOIN (SELECT f7.patient_id,
f7.visit_date, f7.next_appointment_date,
MAX(f7.visit_date)                                            AS return_date,
MID(MAX(CONCAT(f7.visit_date, f7.next_appointment_date)), 11) AS latest_appointment
FROM kenyaemr_etl.etl_patient_hiv_followup f7 GROUP BY f7.patient_id) f7
ON f0.patient_id = f7.patient_id
WHERE f0.next_appointment_date BETWEEN DATE(@startDate) AND DATE(@endDate)
AND f7.return_date = f0.visit_date GROUP BY f7.patient_id
HAVING latest_appointment BETWEEN DATE(@startDate) AND DATE(@endDate)) r
INNER JOIN kenyaemr_etl.etl_hiv_enrollment e ON r.patient_id = e.patient_id
LEFT OUTER JOIN (SELECT patient_id, COALESCE(MAX(DATE(effective_discontinuation_date)),
MAX(DATE(visit_date)))              visit_date,
MAX(DATE(effective_discontinuation_date)) AS effective_disc_date, discontinuation_reason
FROM kenyaemr_etl.etl_patient_program_discontinuation WHERE DATE(visit_date) <= DATE(@endDate)
AND program_name = 'HIV' GROUP BY patient_id) d ON d.patient_id = r.patient_id
GROUP BY r.patient_id HAVING (MAX(e.visit_date) >= DATE(d.visit_date) OR d.patient_id IS NULL OR
DATE(d.visit_date) >= DATE(@endDate))) a)     
 ) tx GROUP BY tx.gender, tx.age_group

-- KP Section
UNION SELECT "jIZtrFTU5M6" data_element, (CASE t.key_population_type
					WHEN 'Female sex worker' THEN 'gNjREqP1dq8'
					WHEN 'Men who have sex with men' THEN 'G0alyNeHzFt'
					WHEN 'People who inject drugs' THEN 'rQud3arnRmr'
					WHEN 'Transgender' THEN 'ZFiEPANua6x'
					WHEN 'Fisher folk' THEN 'AbrdwgGtlZP'
					WHEN 'Prisoner' THEN 'hF8G1rUSaDu'
					END) category_option, t.`organization_unit`, @period period,
		COUNT(t.key_population_type) `value` 
FROM (SELECT p.`patient_id`,
MID(MAX(CONCAT(fup.visit_date,(CASE key_population_type WHEN 105 THEN 'People who inject drugs'
								WHEN 160578 THEN 'Men who have sex with men'
								WHEN 160579 THEN 'Female sex worker'
								WHEN 165100 THEN 'Transgender'
								WHEN 5622 THEN 'Other'
								WHEN 159674 THEN 'Fisher folk'
								WHEN 162198 THEN 'Truck driver'
								WHEN 160549 THEN 'Adolescent and young girls'
								WHEN 162277 THEN 'Prisoner'
								WHEN 165192 THEN 'Military and other uniformed services' END))),11) key_population_type, ou.organization_unit

FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT a.patient_id
FROM (SELECT r.patient_id,
r.app_visit,
r.return_date,
r.next_appointment_date                                                        AS next_appointment_date,
d.patient_id                                                                   AS disc_patient,
d.visit_date                                                                   AS disc_date,
IF(r.app_visit = r.return_date, 'Never Returned', (CASE
            WHEN 0 > DATEDIFF(return_date, r.next_appointment_date)
                THEN 'Returned early'
            WHEN 0 = DATEDIFF(return_date, r.next_appointment_date)
                THEN 'Honoured'
            WHEN 0 < DATEDIFF(return_date, r.next_appointment_date)
                THEN 'Missed' END)) AS Appointment_status FROM (
-- Returned on or after next appointment date
         SELECT f4.patient_id      AS patient_id,
                f6.app_date           app_visit,
                MIN(f4.visit_date) AS return_date,
                f6.tca             AS next_appointment_date
         FROM kenyaemr_etl.etl_patient_hiv_followup f4
                  LEFT JOIN (SELECT f5.patient_id,
                                    MAX(f5.visit_date)                                            AS app_date,
                                    MID(MAX(CONCAT(f5.visit_date, f5.next_appointment_date)), 11) AS tca
                             FROM kenyaemr_etl.etl_patient_hiv_followup f5
                                      LEFT JOIN kenyaemr_etl.etl_patient_hiv_followup f ON f5.patient_id = f.patient_id
                             WHERE f5.next_appointment_date BETWEEN DATE(@startDate) AND DATE(@endDate)
                             GROUP BY f5.patient_id) f6 ON f4.patient_id = f6.patient_id
         WHERE f4.visit_date > f6.app_date
         GROUP BY f6.patient_id
UNION SELECT f0.patient_id  AS patient_id,
f0.visit_date  AS app_visit, f7.return_date AS return_date, f7.latest_appointment
FROM kenyaemr_etl.etl_patient_hiv_followup f0 LEFT JOIN (SELECT f7.patient_id,
f7.visit_date, f7.next_appointment_date,
MAX(f7.visit_date)                                            AS return_date,
MID(MAX(CONCAT(f7.visit_date, f7.next_appointment_date)), 11) AS latest_appointment
FROM kenyaemr_etl.etl_patient_hiv_followup f7 GROUP BY f7.patient_id) f7
ON f0.patient_id = f7.patient_id
WHERE f0.next_appointment_date BETWEEN DATE(@startDate) AND DATE(@endDate)
AND f7.return_date = f0.visit_date GROUP BY f7.patient_id
HAVING latest_appointment BETWEEN DATE(@startDate) AND DATE(@endDate)) r
INNER JOIN kenyaemr_etl.etl_hiv_enrollment e ON r.patient_id = e.patient_id
LEFT OUTER JOIN (SELECT patient_id, COALESCE(MAX(DATE(effective_discontinuation_date)),
MAX(DATE(visit_date)))              visit_date,
MAX(DATE(effective_discontinuation_date)) AS effective_disc_date, discontinuation_reason
FROM kenyaemr_etl.etl_patient_program_discontinuation WHERE DATE(visit_date) <= DATE(@endDate)
AND program_name = 'HIV' GROUP BY patient_id) d ON d.patient_id = r.patient_id
GROUP BY r.patient_id HAVING (MAX(e.visit_date) >= DATE(d.visit_date) OR d.patient_id IS NULL OR
DATE(d.visit_date) >= DATE(@endDate))) a)                                 
GROUP BY fup.`patient_id` ) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type

-- PG Section
UNION SELECT "jIZtrFTU5M6" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value` 
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT a.patient_id
FROM (SELECT r.patient_id,
r.app_visit,
r.return_date,
r.next_appointment_date                                                        AS next_appointment_date,
d.patient_id                                                                   AS disc_patient,
d.visit_date                                                                   AS disc_date,
IF(r.app_visit = r.return_date, 'Never Returned', (CASE
            WHEN 0 > DATEDIFF(return_date, r.next_appointment_date)
                THEN 'Returned early'
            WHEN 0 = DATEDIFF(return_date, r.next_appointment_date)
                THEN 'Honoured'
            WHEN 0 < DATEDIFF(return_date, r.next_appointment_date)
                THEN 'Missed' END)) AS Appointment_status FROM (
-- Returned on or after next appointment date
         SELECT f4.patient_id      AS patient_id,
                f6.app_date           app_visit,
                MIN(f4.visit_date) AS return_date,
                f6.tca             AS next_appointment_date
         FROM kenyaemr_etl.etl_patient_hiv_followup f4
                  LEFT JOIN (SELECT f5.patient_id,
                                    MAX(f5.visit_date)                                            AS app_date,
                                    MID(MAX(CONCAT(f5.visit_date, f5.next_appointment_date)), 11) AS tca
                             FROM kenyaemr_etl.etl_patient_hiv_followup f5
                                      LEFT JOIN kenyaemr_etl.etl_patient_hiv_followup f ON f5.patient_id = f.patient_id
                             WHERE f5.next_appointment_date BETWEEN DATE(@startDate) AND DATE(@endDate)
                             GROUP BY f5.patient_id) f6 ON f4.patient_id = f6.patient_id
         WHERE f4.visit_date > f6.app_date
         GROUP BY f6.patient_id
UNION SELECT f0.patient_id  AS patient_id,
f0.visit_date  AS app_visit, f7.return_date AS return_date, f7.latest_appointment
FROM kenyaemr_etl.etl_patient_hiv_followup f0 LEFT JOIN (SELECT f7.patient_id,
f7.visit_date, f7.next_appointment_date,
MAX(f7.visit_date)                                            AS return_date,
MID(MAX(CONCAT(f7.visit_date, f7.next_appointment_date)), 11) AS latest_appointment
FROM kenyaemr_etl.etl_patient_hiv_followup f7 GROUP BY f7.patient_id) f7
ON f0.patient_id = f7.patient_id
WHERE f0.next_appointment_date BETWEEN DATE(@startDate) AND DATE(@endDate)
AND f7.return_date = f0.visit_date GROUP BY f7.patient_id
HAVING latest_appointment BETWEEN DATE(@startDate) AND DATE(@endDate)) r
INNER JOIN kenyaemr_etl.etl_hiv_enrollment e ON r.patient_id = e.patient_id
LEFT OUTER JOIN (SELECT patient_id, COALESCE(MAX(DATE(effective_discontinuation_date)),
MAX(DATE(visit_date)))              visit_date,
MAX(DATE(effective_discontinuation_date)) AS effective_disc_date, discontinuation_reason
FROM kenyaemr_etl.etl_patient_program_discontinuation WHERE DATE(visit_date) <= DATE(@endDate)
AND program_name = 'HIV' GROUP BY patient_id) d ON d.patient_id = r.patient_id
GROUP BY r.patient_id HAVING (MAX(e.visit_date) >= DATE(d.visit_date) OR d.patient_id IS NULL OR
DATE(d.visit_date) >= DATE(@endDate))) a)     
GROUP BY fup.`patient_id`) t WHERE t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status

-- BF Section
UNION SELECT "jIZtrFTU5M6" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT a.patient_id
FROM (SELECT r.patient_id,
r.app_visit,
r.return_date,
r.next_appointment_date                                                        AS next_appointment_date,
d.patient_id                                                                   AS disc_patient,
d.visit_date                                                                   AS disc_date,
IF(r.app_visit = r.return_date, 'Never Returned', (CASE
            WHEN 0 > DATEDIFF(return_date, r.next_appointment_date)
                THEN 'Returned early'
            WHEN 0 = DATEDIFF(return_date, r.next_appointment_date)
                THEN 'Honoured'
            WHEN 0 < DATEDIFF(return_date, r.next_appointment_date)
                THEN 'Missed' END)) AS Appointment_status FROM (
-- Returned on or after next appointment date
         SELECT f4.patient_id      AS patient_id,
                f6.app_date           app_visit,
                MIN(f4.visit_date) AS return_date,
                f6.tca             AS next_appointment_date
         FROM kenyaemr_etl.etl_patient_hiv_followup f4
                  LEFT JOIN (SELECT f5.patient_id,
                                    MAX(f5.visit_date)                                            AS app_date,
                                    MID(MAX(CONCAT(f5.visit_date, f5.next_appointment_date)), 11) AS tca
                             FROM kenyaemr_etl.etl_patient_hiv_followup f5
                                      LEFT JOIN kenyaemr_etl.etl_patient_hiv_followup f ON f5.patient_id = f.patient_id
                             WHERE f5.next_appointment_date BETWEEN DATE(@startDate) AND DATE(@endDate)
                             GROUP BY f5.patient_id) f6 ON f4.patient_id = f6.patient_id
         WHERE f4.visit_date > f6.app_date
         GROUP BY f6.patient_id
UNION SELECT f0.patient_id  AS patient_id,
f0.visit_date  AS app_visit, f7.return_date AS return_date, f7.latest_appointment
FROM kenyaemr_etl.etl_patient_hiv_followup f0 LEFT JOIN (SELECT f7.patient_id,
f7.visit_date, f7.next_appointment_date,
MAX(f7.visit_date)                                            AS return_date,
MID(MAX(CONCAT(f7.visit_date, f7.next_appointment_date)), 11) AS latest_appointment
FROM kenyaemr_etl.etl_patient_hiv_followup f7 GROUP BY f7.patient_id) f7
ON f0.patient_id = f7.patient_id
WHERE f0.next_appointment_date BETWEEN DATE(@startDate) AND DATE(@endDate)
AND f7.return_date = f0.visit_date GROUP BY f7.patient_id
HAVING latest_appointment BETWEEN DATE(@startDate) AND DATE(@endDate)) r
INNER JOIN kenyaemr_etl.etl_hiv_enrollment e ON r.patient_id = e.patient_id
LEFT OUTER JOIN (SELECT patient_id, COALESCE(MAX(DATE(effective_discontinuation_date)),
MAX(DATE(visit_date)))              visit_date,
MAX(DATE(effective_discontinuation_date)) AS effective_disc_date, discontinuation_reason
FROM kenyaemr_etl.etl_patient_program_discontinuation WHERE DATE(visit_date) <= DATE(@endDate)
AND program_name = 'HIV' GROUP BY patient_id) d ON d.patient_id = r.patient_id
GROUP BY r.patient_id HAVING (MAX(e.visit_date) >= DATE(d.visit_date) OR d.patient_id IS NULL OR
DATE(d.visit_date) >= DATE(@endDate))) a)     
GROUP BY fup.`patient_id`) t WHERE t.breastfeeding = 'Yes' GROUP BY t.breastfeeding;