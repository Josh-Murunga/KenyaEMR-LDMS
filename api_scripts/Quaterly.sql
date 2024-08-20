SET @startDate = '{startQtr}';
SET @endDate = '{endQtr}';
SET @period = '{period}';

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "VUWYNsSSaKw" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F', 'M9WgZF3M1Ns',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M', 'UqhM8q5yX5s',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F', 'vBvWYKAplHX',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M', 'ST3sM0JpQMh',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F', 'EXjtAMYfZtB',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M', 'torkJKBt01E',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'ObtuPZxOt8Z',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'njp0MCdLV3g',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'eOCFWXD88Xj',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'PjxW3Ujsbio',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'VoRXHRvLOdE',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'dJZL6FHiCPr',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'gnrJY8ul7Gh',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'hwOe0NmqWDI',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'x20GH1rWFbS',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'RfaqUUfk8Rn',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'T87UeqXlwhZ',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'mKZfhqCgwTw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'mfQZLqO0wpt',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'kaYhcZFuprR',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'BQ0Ubzm7U9I',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'RaM5sQ7kves',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'UY5FvxvXnt6',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PIv36iYFL92',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'BDinRla76BQ',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'SqyjUPzpeA7',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'xUsD5LKc48C',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'A8tEnB77K4R',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F', 'rYKjhnWcBXR',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M', 'Pv5KPmGLJ37', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
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
WHERE p.`patient_id` IN
(SELECT a.`patient_id` FROM kenyaemr_etl.`etl_patient_demographics` a WHERE a.`patient_id` IN
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
AND a.`patient_id` NOT IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t))
AND p.`patient_id` IN
(SELECT a.patient_id
                FROM (SELECT e.patient_id,
                             e.patient_type,
                             MAX(IF(e.date_started_art_at_transferring_facility IS NOT NULL AND e.facility_transferred_from IS NOT NULL,
                                    1, 0)) AS TI
                      FROM kenyaemr_etl.etl_hiv_enrollment e
                      WHERE COALESCE(e.transfer_in_date, e.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)
                      GROUP BY e.patient_id) a
                WHERE a.patient_type = 160563
                   OR a.TI = 1)
                                   ) tx GROUP BY tx.gender, tx.age_group
                                   
-- KP Section
UNION SELECT "bcequbnMugb" data_element, (CASE t.key_population_type
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
(SELECT a.`patient_id` FROM kenyaemr_etl.`etl_patient_demographics` a WHERE a.`patient_id` IN
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
AND a.`patient_id` NOT IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t))
AND p.`patient_id` IN
(SELECT a.patient_id
                FROM (SELECT e.patient_id,
                             e.patient_type,
                             MAX(IF(e.date_started_art_at_transferring_facility IS NOT NULL AND e.facility_transferred_from IS NOT NULL,
                                    1, 0)) AS TI
                      FROM kenyaemr_etl.etl_hiv_enrollment e
                      WHERE COALESCE(e.transfer_in_date, e.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)
                      GROUP BY e.patient_id) a
                WHERE a.patient_type = 160563
                   OR a.TI = 1)

GROUP BY fup.`patient_id` ) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type

-- PG Section
UNION SELECT "bcequbnMugb" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value` 
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT a.`patient_id` FROM kenyaemr_etl.`etl_patient_demographics` a WHERE a.`patient_id` IN
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
AND a.`patient_id` NOT IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t))
AND p.`patient_id` IN
(SELECT a.patient_id
                FROM (SELECT e.patient_id,
                             e.patient_type,
                             MAX(IF(e.date_started_art_at_transferring_facility IS NOT NULL AND e.facility_transferred_from IS NOT NULL,
                                    1, 0)) AS TI
                      FROM kenyaemr_etl.etl_hiv_enrollment e
                      WHERE COALESCE(e.transfer_in_date, e.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)
                      GROUP BY e.patient_id) a
                WHERE a.patient_type = 160563
                   OR a.TI = 1)

GROUP BY fup.`patient_id`) t WHERE t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status

-- BF Section
UNION SELECT "bcequbnMugb" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT a.`patient_id` FROM kenyaemr_etl.`etl_patient_demographics` a WHERE a.`patient_id` IN
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
AND a.`patient_id` NOT IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t))
AND p.`patient_id` IN
(SELECT a.patient_id
                FROM (SELECT e.patient_id,
                             e.patient_type,
                             MAX(IF(e.date_started_art_at_transferring_facility IS NOT NULL AND e.facility_transferred_from IS NOT NULL,
                                    1, 0)) AS TI
                      FROM kenyaemr_etl.etl_hiv_enrollment e
                      WHERE COALESCE(e.transfer_in_date, e.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)
                      GROUP BY e.patient_id) a
                WHERE a.patient_type = 160563
                   OR a.TI = 1)

GROUP BY fup.`patient_id`) t WHERE t.breastfeeding = 'Yes' GROUP BY t.breastfeeding;

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "jsScKjxMQ3P" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F', 'M9WgZF3M1Ns',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M', 'UqhM8q5yX5s',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F', 'vBvWYKAplHX',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M', 'ST3sM0JpQMh',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F', 'EXjtAMYfZtB',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M', 'torkJKBt01E',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'ObtuPZxOt8Z',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'njp0MCdLV3g',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'eOCFWXD88Xj',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'PjxW3Ujsbio',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'VoRXHRvLOdE',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'dJZL6FHiCPr',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'gnrJY8ul7Gh',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'hwOe0NmqWDI',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'x20GH1rWFbS',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'RfaqUUfk8Rn',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'T87UeqXlwhZ',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'mKZfhqCgwTw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'mfQZLqO0wpt',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'kaYhcZFuprR',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'BQ0Ubzm7U9I',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'RaM5sQ7kves',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'UY5FvxvXnt6',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PIv36iYFL92',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'BDinRla76BQ',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'SqyjUPzpeA7',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'xUsD5LKc48C',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'A8tEnB77K4R',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F', 'rYKjhnWcBXR',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M', 'Pv5KPmGLJ37', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, tx.entry_value
FROM (SELECT t.patient_id, gender, age_group, COUNT(t.age_group) entry_value, t.mfl, ou.`organization_unit`
 FROM(
     SELECT p.`Gender`, p.`DOB`, TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) AS age, fi.`siteCode` mfl,
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
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) > 64, '65+yrs', NULL))))))))))))))) age_group,    
     fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date,
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
              JOIN kenyaemr_etl.`etl_default_facility_info` fi
     WHERE fup.visit_date <= DATE(@endDate)
     GROUP BY patient_id
     HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
         (
             ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
               AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
             )
         )
     ) t LEFT JOIN ldwh.`facility_info` ou ON ou.`mfl`=t.mfl
     WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT e.patient_id
                FROM (
                     SELECT fup_prev_period.patient_id,
                            MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                            MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                            MAX(d.visit_date) AS date_discontinued,
                            d.patient_id AS disc_patient,
                            fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT
                     FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                            JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(@endDate , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                            LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                     WHERE fup_prev_period.visit_date < DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH)
                     GROUP BY patient_id
                     HAVING
                         ((DATE(prev_period_latest_tca) < DATE(@endDate) AND DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca))) AND ((DATE(prev_period_latest_tca) > DATE(date_discontinued) AND DATE(prev_period_latest_vis_date) > DATE(date_discontinued)) OR disc_patient IS NULL) AND
                         TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30 AND TIMESTAMPDIFF(MONTH, DATE(prev_period_latest_tca),DATE(first_visit_after_IIT)) < 3
                     )e)GROUP BY t.gender, t.age_group) tx

-- KP section
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "i7xoaadS5QM" data_element, (CASE t.key_population_type
					WHEN 'Female sex worker' THEN 'gNjREqP1dq8'
					WHEN 'Men who have sex with men' THEN 'G0alyNeHzFt'
					WHEN 'People who inject drugs' THEN 'rQud3arnRmr'
					WHEN 'Transgender' THEN 'ZFiEPANua6x'
					WHEN 'Fisher folk' THEN 'AbrdwgGtlZP'
					WHEN 'Prisoner' THEN 'hF8G1rUSaDu'
					END) category_option, t.`organization_unit`, @period period,
		COUNT(t.key_population_type) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,(CASE key_population_type WHEN 105 THEN 'People who inject drugs'
								WHEN 160578 THEN 'Men who have sex with men'
								WHEN 160579 THEN 'Female sex worker'
								WHEN 165100 THEN 'Transgender'
								WHEN 5622 THEN 'Other'
								WHEN 159674 THEN 'Fisher folk'
								WHEN 162198 THEN 'Truck driver'
								WHEN 160549 THEN 'Adolescent and young girls'
								WHEN 162277 THEN 'Prisoner'
								WHEN 165192 THEN 'Military and other uniformed services' END))),11) key_population_type,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT e.patient_id
                FROM (
                     SELECT fup_prev_period.patient_id,
                            MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                            MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                            MAX(d.visit_date) AS date_discontinued,
                            d.patient_id AS disc_patient,
                            fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT
                     FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                            JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(@endDate , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                            LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                     WHERE fup_prev_period.visit_date < DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH)
                     GROUP BY patient_id
                     HAVING
                         ((DATE(prev_period_latest_tca) < DATE(@endDate) AND DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca))) AND ((DATE(prev_period_latest_tca) > DATE(date_discontinued) AND DATE(prev_period_latest_vis_date) > DATE(date_discontinued)) OR disc_patient IS NULL) AND
                         TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30 AND TIMESTAMPDIFF(MONTH, DATE(prev_period_latest_tca),DATE(first_visit_after_IIT)) < 3
                     )e)
                     AND t.key_population_type IS NOT NULL GROUP BY t.key_population_type) rtt

-- PG section	
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "i7xoaadS5QM" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT e.patient_id
                FROM (
                     SELECT fup_prev_period.patient_id,
                            MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                            MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                            MAX(d.visit_date) AS date_discontinued,
                            d.patient_id AS disc_patient,
                            fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT
                     FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                            JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(@endDate , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                            LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                     WHERE fup_prev_period.visit_date < DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH)
                     GROUP BY patient_id
                     HAVING
                         ((DATE(prev_period_latest_tca) < DATE(@endDate) AND DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca))) AND ((DATE(prev_period_latest_tca) > DATE(date_discontinued) AND DATE(prev_period_latest_vis_date) > DATE(date_discontinued)) OR disc_patient IS NULL) AND
                         TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30 AND TIMESTAMPDIFF(MONTH, DATE(prev_period_latest_tca),DATE(first_visit_after_IIT)) < 3
                     )e)
                     AND t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status) rtt

-- BF section	
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "i7xoaadS5QM" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT e.patient_id
                FROM (
                     SELECT fup_prev_period.patient_id,
                            MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                            MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                            MAX(d.visit_date) AS date_discontinued,
                            d.patient_id AS disc_patient,
                            fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT
                     FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                            JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(@endDate , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                            LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                     WHERE fup_prev_period.visit_date < DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH)
                     GROUP BY patient_id
                     HAVING
                         ((DATE(prev_period_latest_tca) < DATE(@endDate) AND DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca))) AND ((DATE(prev_period_latest_tca) > DATE(date_discontinued) AND DATE(prev_period_latest_vis_date) > DATE(date_discontinued)) OR disc_patient IS NULL) AND
                         TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30 AND TIMESTAMPDIFF(MONTH, DATE(prev_period_latest_tca),DATE(first_visit_after_IIT)) < 3
                     )e)
                     AND t.breastfeeding = 'Yes' GROUP BY t.breastfeeding) rtt;

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "An2vqKQnbWN" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F', 'M9WgZF3M1Ns',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M', 'UqhM8q5yX5s',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F', 'vBvWYKAplHX',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M', 'ST3sM0JpQMh',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F', 'EXjtAMYfZtB',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M', 'torkJKBt01E',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'ObtuPZxOt8Z',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'njp0MCdLV3g',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'eOCFWXD88Xj',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'PjxW3Ujsbio',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'VoRXHRvLOdE',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'dJZL6FHiCPr',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'gnrJY8ul7Gh',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'hwOe0NmqWDI',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'x20GH1rWFbS',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'RfaqUUfk8Rn',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'T87UeqXlwhZ',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'mKZfhqCgwTw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'mfQZLqO0wpt',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'kaYhcZFuprR',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'BQ0Ubzm7U9I',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'RaM5sQ7kves',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'UY5FvxvXnt6',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PIv36iYFL92',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'BDinRla76BQ',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'SqyjUPzpeA7',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'xUsD5LKc48C',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'A8tEnB77K4R',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F', 'rYKjhnWcBXR',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M', 'Pv5KPmGLJ37', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, tx.entry_value
FROM (SELECT t.patient_id, gender, age_group, COUNT(t.age_group) entry_value, t.mfl, ou.`organization_unit`
 FROM(
     SELECT p.`Gender`, p.`DOB`, TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) AS age, fi.`siteCode` mfl,
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
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) > 64, '65+yrs', NULL))))))))))))))) age_group,    
     fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date,
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
              JOIN kenyaemr_etl.`etl_default_facility_info` fi
     WHERE fup.visit_date <= DATE(@endDate)
     GROUP BY patient_id
     HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
         (
             ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
               AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
             )
         )
     ) t LEFT JOIN ldwh.`facility_info` ou ON ou.`mfl`=t.mfl
     WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT e.patient_id
                FROM (
                     SELECT fup_prev_period.patient_id,
                            MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                            MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                            MAX(d.visit_date) AS date_discontinued,
                            d.patient_id AS disc_patient,
                            fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT
                     FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                            JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(@endDate , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                            LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                     WHERE fup_prev_period.visit_date < DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH)
                     GROUP BY patient_id
                     HAVING
                         ((DATE(prev_period_latest_tca) < DATE(@endDate) AND DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca))) AND ((DATE(prev_period_latest_tca) > DATE(date_discontinued) AND DATE(prev_period_latest_vis_date) > DATE(date_discontinued)) OR disc_patient IS NULL) AND
                         TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30 AND TIMESTAMPDIFF(MONTH, DATE(prev_period_latest_tca),DATE(first_visit_after_IIT)) BETWEEN 3 AND 5
                     )e)GROUP BY t.gender, t.age_group) tx

-- KP section
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "HLS5oNmbyLv" data_element, (CASE t.key_population_type
					WHEN 'Female sex worker' THEN 'gNjREqP1dq8'
					WHEN 'Men who have sex with men' THEN 'G0alyNeHzFt'
					WHEN 'People who inject drugs' THEN 'rQud3arnRmr'
					WHEN 'Transgender' THEN 'ZFiEPANua6x'
					WHEN 'Fisher folk' THEN 'AbrdwgGtlZP'
					WHEN 'Prisoner' THEN 'hF8G1rUSaDu'
					END) category_option, t.`organization_unit`, @period period,
		COUNT(t.key_population_type) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,(CASE key_population_type WHEN 105 THEN 'People who inject drugs'
								WHEN 160578 THEN 'Men who have sex with men'
								WHEN 160579 THEN 'Female sex worker'
								WHEN 165100 THEN 'Transgender'
								WHEN 5622 THEN 'Other'
								WHEN 159674 THEN 'Fisher folk'
								WHEN 162198 THEN 'Truck driver'
								WHEN 160549 THEN 'Adolescent and young girls'
								WHEN 162277 THEN 'Prisoner'
								WHEN 165192 THEN 'Military and other uniformed services' END))),11) key_population_type,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT e.patient_id
                FROM (
                     SELECT fup_prev_period.patient_id,
                            MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                            MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                            MAX(d.visit_date) AS date_discontinued,
                            d.patient_id AS disc_patient,
                            fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT
                     FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                            JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(@endDate , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                            LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                     WHERE fup_prev_period.visit_date < DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH)
                     GROUP BY patient_id
                     HAVING
                         ((DATE(prev_period_latest_tca) < DATE(@endDate) AND DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca))) AND ((DATE(prev_period_latest_tca) > DATE(date_discontinued) AND DATE(prev_period_latest_vis_date) > DATE(date_discontinued)) OR disc_patient IS NULL) AND
                         TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30 AND TIMESTAMPDIFF(MONTH, DATE(prev_period_latest_tca),DATE(first_visit_after_IIT)) BETWEEN 3 AND 5
                     )e)
                     AND t.key_population_type IS NOT NULL GROUP BY t.key_population_type) rtt

-- PG section	
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "HLS5oNmbyLv" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT e.patient_id
                FROM (
                     SELECT fup_prev_period.patient_id,
                            MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                            MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                            MAX(d.visit_date) AS date_discontinued,
                            d.patient_id AS disc_patient,
                            fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT
                     FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                            JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(@endDate , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                            LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                     WHERE fup_prev_period.visit_date < DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH)
                     GROUP BY patient_id
                     HAVING
                         ((DATE(prev_period_latest_tca) < DATE(@endDate) AND DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca))) AND ((DATE(prev_period_latest_tca) > DATE(date_discontinued) AND DATE(prev_period_latest_vis_date) > DATE(date_discontinued)) OR disc_patient IS NULL) AND
                         TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30 AND TIMESTAMPDIFF(MONTH, DATE(prev_period_latest_tca),DATE(first_visit_after_IIT)) BETWEEN 3 AND 5
                     )e)
                     AND t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status) rtt

-- BF section	
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "HLS5oNmbyLv" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT e.patient_id
                FROM (
                     SELECT fup_prev_period.patient_id,
                            MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                            MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                            MAX(d.visit_date) AS date_discontinued,
                            d.patient_id AS disc_patient,
                            fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT
                     FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                            JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(@endDate , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                            LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                     WHERE fup_prev_period.visit_date < DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH)
                     GROUP BY patient_id
                     HAVING
                         ((DATE(prev_period_latest_tca) < DATE(@endDate) AND DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca))) AND ((DATE(prev_period_latest_tca) > DATE(date_discontinued) AND DATE(prev_period_latest_vis_date) > DATE(date_discontinued)) OR disc_patient IS NULL) AND
                         TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30 AND TIMESTAMPDIFF(MONTH, DATE(prev_period_latest_tca),DATE(first_visit_after_IIT)) BETWEEN 3 AND 5
                     )e)
                     AND t.breastfeeding = 'Yes' GROUP BY t.breastfeeding) rtt;

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "hz27H88QXi5" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F', 'M9WgZF3M1Ns',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M', 'UqhM8q5yX5s',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F', 'vBvWYKAplHX',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M', 'ST3sM0JpQMh',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F', 'EXjtAMYfZtB',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M', 'torkJKBt01E',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'ObtuPZxOt8Z',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'njp0MCdLV3g',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'eOCFWXD88Xj',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'PjxW3Ujsbio',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'VoRXHRvLOdE',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'dJZL6FHiCPr',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'gnrJY8ul7Gh',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'hwOe0NmqWDI',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'x20GH1rWFbS',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'RfaqUUfk8Rn',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'T87UeqXlwhZ',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'mKZfhqCgwTw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'mfQZLqO0wpt',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'kaYhcZFuprR',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'BQ0Ubzm7U9I',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'RaM5sQ7kves',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'UY5FvxvXnt6',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PIv36iYFL92',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'BDinRla76BQ',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'SqyjUPzpeA7',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'xUsD5LKc48C',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'A8tEnB77K4R',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F', 'rYKjhnWcBXR',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M', 'Pv5KPmGLJ37', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, tx.entry_value
FROM (SELECT t.patient_id, gender, age_group, COUNT(t.age_group) entry_value, t.mfl, ou.`organization_unit`
 FROM(
     SELECT p.`Gender`, p.`DOB`, TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) AS age, fi.`siteCode` mfl,
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
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) > 64, '65+yrs', NULL))))))))))))))) age_group,    
     fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date,
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
              JOIN kenyaemr_etl.`etl_default_facility_info` fi
     WHERE fup.visit_date <= DATE(@endDate)
     GROUP BY patient_id
     HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
         (
             ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
               AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
             )
         )
     ) t LEFT JOIN ldwh.`facility_info` ou ON ou.`mfl`=t.mfl
     WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id NOT IN (SELECT t.patient_id
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
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT e.patient_id
                FROM (
                     SELECT fup_prev_period.patient_id,
                            MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                            MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                            MAX(d.visit_date) AS date_discontinued,
                            d.patient_id AS disc_patient,
                            fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT
                     FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                            JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(@endDate , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                            LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                     WHERE fup_prev_period.visit_date < DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH)
                     GROUP BY patient_id
                     HAVING
                         ((DATE(prev_period_latest_tca) < DATE(@endDate) AND DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca))) AND ((DATE(prev_period_latest_tca) > DATE(date_discontinued) AND DATE(prev_period_latest_vis_date) > DATE(date_discontinued)) OR disc_patient IS NULL) AND
                         TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30 AND TIMESTAMPDIFF(MONTH, DATE(prev_period_latest_tca),DATE(first_visit_after_IIT)) < 3
                     )e))
                     AND t.patient_id NOT IN (SELECT t.patient_id
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
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT e.patient_id
                FROM (
                     SELECT fup_prev_period.patient_id,
                            MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                            MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                            MAX(d.visit_date) AS date_discontinued,
                            d.patient_id AS disc_patient,
                            fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT
                     FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                            JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(@endDate , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                            LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                     WHERE fup_prev_period.visit_date < DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH)
                     GROUP BY patient_id
                     HAVING
                         ((DATE(prev_period_latest_tca) < DATE(@endDate) AND DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca))) AND ((DATE(prev_period_latest_tca) > DATE(date_discontinued) AND DATE(prev_period_latest_vis_date) > DATE(date_discontinued)) OR disc_patient IS NULL) AND
                         TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30 AND TIMESTAMPDIFF(MONTH, DATE(prev_period_latest_tca),DATE(first_visit_after_IIT)) BETWEEN 3 AND 5
                     )e)) GROUP BY t.gender, t.age_group) tx

-- KP section
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "WwpiS7m6zHN" data_element, (CASE t.key_population_type
					WHEN 'Female sex worker' THEN 'gNjREqP1dq8'
					WHEN 'Men who have sex with men' THEN 'G0alyNeHzFt'
					WHEN 'People who inject drugs' THEN 'rQud3arnRmr'
					WHEN 'Transgender' THEN 'ZFiEPANua6x'
					WHEN 'Fisher folk' THEN 'AbrdwgGtlZP'
					WHEN 'Prisoner' THEN 'hF8G1rUSaDu'
					END) category_option, t.`organization_unit`, @period period,
		COUNT(t.key_population_type) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,(CASE key_population_type WHEN 105 THEN 'People who inject drugs'
								WHEN 160578 THEN 'Men who have sex with men'
								WHEN 160579 THEN 'Female sex worker'
								WHEN 165100 THEN 'Transgender'
								WHEN 5622 THEN 'Other'
								WHEN 159674 THEN 'Fisher folk'
								WHEN 162198 THEN 'Truck driver'
								WHEN 160549 THEN 'Adolescent and young girls'
								WHEN 162277 THEN 'Prisoner'
								WHEN 165192 THEN 'Military and other uniformed services' END))),11) key_population_type,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id NOT IN (SELECT t.patient_id
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
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT e.patient_id
                FROM (
                     SELECT fup_prev_period.patient_id,
                            MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                            MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                            MAX(d.visit_date) AS date_discontinued,
                            d.patient_id AS disc_patient,
                            fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT
                     FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                            JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(@endDate , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                            LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                     WHERE fup_prev_period.visit_date < DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH)
                     GROUP BY patient_id
                     HAVING
                         ((DATE(prev_period_latest_tca) < DATE(@endDate) AND DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca))) AND ((DATE(prev_period_latest_tca) > DATE(date_discontinued) AND DATE(prev_period_latest_vis_date) > DATE(date_discontinued)) OR disc_patient IS NULL) AND
                         TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30 AND TIMESTAMPDIFF(MONTH, DATE(prev_period_latest_tca),DATE(first_visit_after_IIT)) < 3
                     )e))
                     AND t.patient_id NOT IN (SELECT t.patient_id
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
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT e.patient_id
                FROM (
                     SELECT fup_prev_period.patient_id,
                            MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                            MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                            MAX(d.visit_date) AS date_discontinued,
                            d.patient_id AS disc_patient,
                            fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT
                     FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                            JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(@endDate , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                            LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                     WHERE fup_prev_period.visit_date < DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH)
                     GROUP BY patient_id
                     HAVING
                         ((DATE(prev_period_latest_tca) < DATE(@endDate) AND DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca))) AND ((DATE(prev_period_latest_tca) > DATE(date_discontinued) AND DATE(prev_period_latest_vis_date) > DATE(date_discontinued)) OR disc_patient IS NULL) AND
                         TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30 AND TIMESTAMPDIFF(MONTH, DATE(prev_period_latest_tca),DATE(first_visit_after_IIT)) BETWEEN 3 AND 5
                     )e)) 
                     AND t.key_population_type IS NOT NULL GROUP BY t.key_population_type) rtt

-- PG section	
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "WwpiS7m6zHN" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id NOT IN (SELECT t.patient_id
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
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT e.patient_id
                FROM (
                     SELECT fup_prev_period.patient_id,
                            MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                            MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                            MAX(d.visit_date) AS date_discontinued,
                            d.patient_id AS disc_patient,
                            fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT
                     FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                            JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(@endDate , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                            LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                     WHERE fup_prev_period.visit_date < DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH)
                     GROUP BY patient_id
                     HAVING
                         ((DATE(prev_period_latest_tca) < DATE(@endDate) AND DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca))) AND ((DATE(prev_period_latest_tca) > DATE(date_discontinued) AND DATE(prev_period_latest_vis_date) > DATE(date_discontinued)) OR disc_patient IS NULL) AND
                         TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30 AND TIMESTAMPDIFF(MONTH, DATE(prev_period_latest_tca),DATE(first_visit_after_IIT)) < 3
                     )e))
                     AND t.patient_id NOT IN (SELECT t.patient_id
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
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT e.patient_id
                FROM (
                     SELECT fup_prev_period.patient_id,
                            MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                            MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                            MAX(d.visit_date) AS date_discontinued,
                            d.patient_id AS disc_patient,
                            fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT
                     FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                            JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(@endDate , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                            LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                     WHERE fup_prev_period.visit_date < DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH)
                     GROUP BY patient_id
                     HAVING
                         ((DATE(prev_period_latest_tca) < DATE(@endDate) AND DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca))) AND ((DATE(prev_period_latest_tca) > DATE(date_discontinued) AND DATE(prev_period_latest_vis_date) > DATE(date_discontinued)) OR disc_patient IS NULL) AND
                         TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30 AND TIMESTAMPDIFF(MONTH, DATE(prev_period_latest_tca),DATE(first_visit_after_IIT)) BETWEEN 3 AND 5
                     )e))
                     AND t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status) rtt

-- BF section	
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "WwpiS7m6zHN" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id NOT IN (SELECT t.patient_id
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
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT e.patient_id
                FROM (
                     SELECT fup_prev_period.patient_id,
                            MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                            MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                            MAX(d.visit_date) AS date_discontinued,
                            d.patient_id AS disc_patient,
                            fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT
                     FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                            JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(@endDate , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                            LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                     WHERE fup_prev_period.visit_date < DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH)
                     GROUP BY patient_id
                     HAVING
                         ((DATE(prev_period_latest_tca) < DATE(@endDate) AND DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca))) AND ((DATE(prev_period_latest_tca) > DATE(date_discontinued) AND DATE(prev_period_latest_vis_date) > DATE(date_discontinued)) OR disc_patient IS NULL) AND
                         TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30 AND TIMESTAMPDIFF(MONTH, DATE(prev_period_latest_tca),DATE(first_visit_after_IIT)) < 3
                     )e))
                     AND t.patient_id NOT IN (SELECT t.patient_id
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
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT e.patient_id
                FROM (
                     SELECT fup_prev_period.patient_id,
                            MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                            MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                            MAX(d.visit_date) AS date_discontinued,
                            d.patient_id AS disc_patient,
                            fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT
                     FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                            JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(@endDate , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                            LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                     WHERE fup_prev_period.visit_date < DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH)
                     GROUP BY patient_id
                     HAVING
                         ((DATE(prev_period_latest_tca) < DATE(@endDate) AND DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca))) AND ((DATE(prev_period_latest_tca) > DATE(date_discontinued) AND DATE(prev_period_latest_vis_date) > DATE(date_discontinued)) OR disc_patient IS NULL) AND
                         TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30 AND TIMESTAMPDIFF(MONTH, DATE(prev_period_latest_tca),DATE(first_visit_after_IIT)) BETWEEN 3 AND 5
                     )e))
                     AND t.breastfeeding = 'Yes' GROUP BY t.breastfeeding) rtt;


-- GP section
INSERT INTO ldwh.dataset_values
SELECT "WkfUEL1j0e4" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F', 'M9WgZF3M1Ns',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M', 'UqhM8q5yX5s',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F', 'vBvWYKAplHX',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M', 'ST3sM0JpQMh',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F', 'EXjtAMYfZtB',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M', 'torkJKBt01E',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'ObtuPZxOt8Z',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'njp0MCdLV3g',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'eOCFWXD88Xj',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'PjxW3Ujsbio',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'VoRXHRvLOdE',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'dJZL6FHiCPr',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'gnrJY8ul7Gh',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'hwOe0NmqWDI',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'x20GH1rWFbS',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'RfaqUUfk8Rn',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'T87UeqXlwhZ',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'mKZfhqCgwTw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'mfQZLqO0wpt',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'kaYhcZFuprR',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'BQ0Ubzm7U9I',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'RaM5sQ7kves',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'UY5FvxvXnt6',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PIv36iYFL92',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'BDinRla76BQ',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'SqyjUPzpeA7',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'xUsD5LKc48C',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'A8tEnB77K4R',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F', 'rYKjhnWcBXR',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M', 'Pv5KPmGLJ37', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
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
WHERE p.`patient_id` IN
(SELECT d.patient_id
                FROM kenyaemr_etl.etl_patient_demographics d
                         LEFT JOIN (SELECT dt.patient_id
                                    FROM kenyaemr_etl.etl_ccc_defaulter_tracing dt
                                    WHERE dt.is_final_trace = 1267
                                      AND dt.true_status = 164435
                                      AND DATE(dt.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dt
                                   ON d.patient_id = dt.patient_id
                         LEFT JOIN
                     (SELECT dc.patient_id
                      FROM kenyaemr_etl.etl_patient_program_discontinuation dc
                      WHERE dc.discontinuation_reason = 164349
                        AND DATE(dc.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dc ON d.patient_id = dc.patient_id
                WHERE dt.patient_id IS NOT NULL
                   OR dc.patient_id IS NOT NULL)
AND p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
) tx GROUP BY tx.gender, tx.age_group
                                   
-- KP Section
UNION SELECT "NcoDDlDOMtU" data_element, (CASE t.key_population_type
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
(SELECT d.patient_id
                FROM kenyaemr_etl.etl_patient_demographics d
                         LEFT JOIN (SELECT dt.patient_id
                                    FROM kenyaemr_etl.etl_ccc_defaulter_tracing dt
                                    WHERE dt.is_final_trace = 1267
                                      AND dt.true_status = 164435
                                      AND DATE(dt.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dt
                                   ON d.patient_id = dt.patient_id
                         LEFT JOIN
                     (SELECT dc.patient_id
                      FROM kenyaemr_etl.etl_patient_program_discontinuation dc
                      WHERE dc.discontinuation_reason = 164349
                        AND DATE(dc.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dc ON d.patient_id = dc.patient_id
                WHERE dt.patient_id IS NOT NULL
                   OR dc.patient_id IS NOT NULL)
AND p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
GROUP BY fup.`patient_id` ) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type

-- PG Section
UNION SELECT "NcoDDlDOMtU" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value` 
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT d.patient_id
                FROM kenyaemr_etl.etl_patient_demographics d
                         LEFT JOIN (SELECT dt.patient_id
                                    FROM kenyaemr_etl.etl_ccc_defaulter_tracing dt
                                    WHERE dt.is_final_trace = 1267
                                      AND dt.true_status = 164435
                                      AND DATE(dt.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dt
                                   ON d.patient_id = dt.patient_id
                         LEFT JOIN
                     (SELECT dc.patient_id
                      FROM kenyaemr_etl.etl_patient_program_discontinuation dc
                      WHERE dc.discontinuation_reason = 164349
                        AND DATE(dc.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dc ON d.patient_id = dc.patient_id
                WHERE dt.patient_id IS NOT NULL
                   OR dc.patient_id IS NOT NULL)
AND p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
GROUP BY fup.`patient_id`) t WHERE t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status

-- BF Section
UNION SELECT "NcoDDlDOMtU" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT d.patient_id
                FROM kenyaemr_etl.etl_patient_demographics d
                         LEFT JOIN (SELECT dt.patient_id
                                    FROM kenyaemr_etl.etl_ccc_defaulter_tracing dt
                                    WHERE dt.is_final_trace = 1267
                                      AND dt.true_status = 164435
                                      AND DATE(dt.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dt
                                   ON d.patient_id = dt.patient_id
                         LEFT JOIN
                     (SELECT dc.patient_id
                      FROM kenyaemr_etl.etl_patient_program_discontinuation dc
                      WHERE dc.discontinuation_reason = 164349
                        AND DATE(dc.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dc ON d.patient_id = dc.patient_id
                WHERE dt.patient_id IS NOT NULL
                   OR dc.patient_id IS NOT NULL)
AND p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
GROUP BY fup.`patient_id`) t WHERE t.breastfeeding = 'Yes' GROUP BY t.breastfeeding;

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "nN72gWGjsAP" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F', 'M9WgZF3M1Ns',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M', 'UqhM8q5yX5s',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F', 'vBvWYKAplHX',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M', 'ST3sM0JpQMh',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F', 'EXjtAMYfZtB',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M', 'torkJKBt01E',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'ObtuPZxOt8Z',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'njp0MCdLV3g',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'eOCFWXD88Xj',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'PjxW3Ujsbio',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'VoRXHRvLOdE',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'dJZL6FHiCPr',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'gnrJY8ul7Gh',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'hwOe0NmqWDI',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'x20GH1rWFbS',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'RfaqUUfk8Rn',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'T87UeqXlwhZ',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'mKZfhqCgwTw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'mfQZLqO0wpt',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'kaYhcZFuprR',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'BQ0Ubzm7U9I',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'RaM5sQ7kves',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'UY5FvxvXnt6',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PIv36iYFL92',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'BDinRla76BQ',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'SqyjUPzpeA7',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'xUsD5LKc48C',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'A8tEnB77K4R',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F', 'rYKjhnWcBXR',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M', 'Pv5KPmGLJ37', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
FROM (
SELECT p.`Gender`, p.`DOB`, TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) AS age, ou.organization_unit,
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
FROM kenyaemr_etl.etl_patient_program_discontinuation d
JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = d.patient_id
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                                    WHERE d.program_name = 'HIV'
                                          AND DATE(d.effective_discontinuation_date)
                                          BETWEEN DATE(@startDate)
                                          AND DATE(@endDate)
                                          AND d.discontinuation_reason = 159492 AND d.trf_out_verified =1065) tx GROUP BY tx.gender, tx.age_group

-- KP Section
UNION SELECT "jb1Ej9v0o7a" data_element, (CASE t.key_population_type
					WHEN 'Female sex worker' THEN 'gNjREqP1dq8'
					WHEN 'Men who have sex with men' THEN 'G0alyNeHzFt'
					WHEN 'People who inject drugs' THEN 'rQud3arnRmr'
					WHEN 'Transgender' THEN 'ZFiEPANua6x'
					WHEN 'Fisher folk' THEN 'AbrdwgGtlZP'
					WHEN 'Prisoner' THEN 'hF8G1rUSaDu'
					END) category_option, t.`organization_unit`, @period period,
		COUNT(t.key_population_type) `value` 
FROM (SELECT 
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

FROM kenyaemr_etl.etl_patient_program_discontinuation d
JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = d.patient_id
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = d.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                                    WHERE d.program_name = 'HIV'
                                          AND DATE(d.effective_discontinuation_date)
                                          BETWEEN DATE(@startDate)
                                          AND DATE(@endDate)
                                          AND d.discontinuation_reason = 159492 AND d.trf_out_verified =1065) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type

-- PG Section
UNION SELECT "jb1Ej9v0o7a" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value` 
FROM (SELECT 
MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status, ou.organization_unit
FROM kenyaemr_etl.etl_patient_program_discontinuation d
JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = d.patient_id
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = d.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE d.program_name = 'HIV'
      AND DATE(d.effective_discontinuation_date)
      BETWEEN DATE(@startDate)
      AND DATE(@endDate)
      AND d.discontinuation_reason = 159492 AND d.trf_out_verified =1065) t WHERE t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status

-- BF Section
UNION SELECT "jb1Ej9v0o7a" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
FROM (SELECT 
MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding, ou.organization_unit
FROM kenyaemr_etl.etl_patient_program_discontinuation d
JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = d.patient_id
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = d.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE d.program_name = 'HIV'
      AND DATE(d.effective_discontinuation_date)
      BETWEEN DATE(@startDate)
      AND DATE(@endDate)
      AND d.discontinuation_reason = 159492 AND d.trf_out_verified =1065) t WHERE t.breastfeeding = 'Yes' GROUP BY t.breastfeeding;

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "nkiyooCWYv4" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F', 'M9WgZF3M1Ns',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M', 'UqhM8q5yX5s',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F', 'vBvWYKAplHX',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M', 'ST3sM0JpQMh',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F', 'EXjtAMYfZtB',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M', 'torkJKBt01E',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'ObtuPZxOt8Z',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'njp0MCdLV3g',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'eOCFWXD88Xj',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'PjxW3Ujsbio',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'VoRXHRvLOdE',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'dJZL6FHiCPr',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'gnrJY8ul7Gh',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'hwOe0NmqWDI',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'x20GH1rWFbS',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'RfaqUUfk8Rn',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'T87UeqXlwhZ',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'mKZfhqCgwTw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'mfQZLqO0wpt',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'kaYhcZFuprR',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'BQ0Ubzm7U9I',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'RaM5sQ7kves',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'UY5FvxvXnt6',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PIv36iYFL92',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'BDinRla76BQ',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'SqyjUPzpeA7',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'xUsD5LKc48C',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'A8tEnB77K4R',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F', 'rYKjhnWcBXR',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M', 'Pv5KPmGLJ37', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
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
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT e.patient_id FROM (SELECT e.patient_id,MIN(DATE(e.date_started)) AS date_started FROM kenyaemr_etl.etl_drug_event e WHERE e.program ='HIV' AND DATE(e.date_started) <= DATE(@endDate)
                                GROUP BY e.patient_id HAVING TIMESTAMPDIFF(MONTH,date_started,DATE(@endDate)) < 3)e)
AND p.`patient_id` NOT IN
(SELECT p.`patient_id` FROM kenyaemr_etl.`etl_patient_demographics` p WHERE p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d
                                    WHERE d.program_name = 'HIV'
                                          AND DATE(d.effective_discontinuation_date)
                                          BETWEEN DATE(@startDate)
                                          AND DATE(@endDate)
                                          AND d.discontinuation_reason = 159492 AND d.trf_out_verified =1065)
OR p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034)

OR p.`patient_id` IN
(SELECT d.patient_id
                FROM kenyaemr_etl.etl_patient_demographics d
                         LEFT JOIN (SELECT dt.patient_id
                                    FROM kenyaemr_etl.etl_ccc_defaulter_tracing dt
                                    WHERE dt.is_final_trace = 1267
                                      AND dt.true_status = 164435
                                      AND DATE(dt.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dt
                                   ON d.patient_id = dt.patient_id
                         LEFT JOIN
                     (SELECT dc.patient_id
                      FROM kenyaemr_etl.etl_patient_program_discontinuation dc
                      WHERE dc.discontinuation_reason = 164349
                        AND DATE(dc.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dc ON d.patient_id = dc.patient_id
                WHERE dt.patient_id IS NOT NULL
                   OR dc.patient_id IS NOT NULL))
) tx GROUP BY tx.gender, tx.age_group

-- KP Section 
 UNION SELECT "ICVrvHsSGBw" data_element, (CASE t.key_population_type
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
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT e.patient_id FROM (SELECT e.patient_id,MIN(DATE(e.date_started)) AS date_started FROM kenyaemr_etl.etl_drug_event e WHERE e.program ='HIV' AND DATE(e.date_started) <= DATE(@endDate)
                                GROUP BY e.patient_id HAVING TIMESTAMPDIFF(MONTH,date_started,DATE(@endDate)) < 3)e)
AND p.`patient_id` NOT IN
(SELECT p.`patient_id` FROM kenyaemr_etl.`etl_patient_demographics` p WHERE p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d
                                    WHERE d.program_name = 'HIV'
                                          AND DATE(d.effective_discontinuation_date)
                                          BETWEEN DATE(@startDate)
                                          AND DATE(@endDate)
                                          AND d.discontinuation_reason = 159492 AND d.trf_out_verified =1065)
OR p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034)

OR p.`patient_id` IN
(SELECT d.patient_id
                FROM kenyaemr_etl.etl_patient_demographics d
                         LEFT JOIN (SELECT dt.patient_id
                                    FROM kenyaemr_etl.etl_ccc_defaulter_tracing dt
                                    WHERE dt.is_final_trace = 1267
                                      AND dt.true_status = 164435
                                      AND DATE(dt.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dt
                                   ON d.patient_id = dt.patient_id
                         LEFT JOIN
                     (SELECT dc.patient_id
                      FROM kenyaemr_etl.etl_patient_program_discontinuation dc
                      WHERE dc.discontinuation_reason = 164349
                        AND DATE(dc.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dc ON d.patient_id = dc.patient_id
                WHERE dt.patient_id IS NOT NULL
                   OR dc.patient_id IS NOT NULL))                                    
                               GROUP BY fup.`patient_id`) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type

-- PG Section
UNION SELECT "ICVrvHsSGBw" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value` 
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT e.patient_id FROM (SELECT e.patient_id,MIN(DATE(e.date_started)) AS date_started FROM kenyaemr_etl.etl_drug_event e WHERE e.program ='HIV' AND DATE(e.date_started) <= DATE(@endDate)
                                GROUP BY e.patient_id HAVING TIMESTAMPDIFF(MONTH,date_started,DATE(@endDate)) < 3)e)
AND p.`patient_id` NOT IN
(SELECT p.`patient_id` FROM kenyaemr_etl.`etl_patient_demographics` p WHERE p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d
                                    WHERE d.program_name = 'HIV'
                                          AND DATE(d.effective_discontinuation_date)
                                          BETWEEN DATE(@startDate)
                                          AND DATE(@endDate)
                                          AND d.discontinuation_reason = 159492 AND d.trf_out_verified =1065)
OR p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034)

OR p.`patient_id` IN
(SELECT d.patient_id
                FROM kenyaemr_etl.etl_patient_demographics d
                         LEFT JOIN (SELECT dt.patient_id
                                    FROM kenyaemr_etl.etl_ccc_defaulter_tracing dt
                                    WHERE dt.is_final_trace = 1267
                                      AND dt.true_status = 164435
                                      AND DATE(dt.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dt
                                   ON d.patient_id = dt.patient_id
                         LEFT JOIN
                     (SELECT dc.patient_id
                      FROM kenyaemr_etl.etl_patient_program_discontinuation dc
                      WHERE dc.discontinuation_reason = 164349
                        AND DATE(dc.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dc ON d.patient_id = dc.patient_id
                WHERE dt.patient_id IS NOT NULL
                   OR dc.patient_id IS NOT NULL))
GROUP BY fup.`patient_id`) t WHERE t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status

-- BF Section
UNION SELECT "ICVrvHsSGBw" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT e.patient_id FROM (SELECT e.patient_id,MIN(DATE(e.date_started)) AS date_started FROM kenyaemr_etl.etl_drug_event e WHERE e.program ='HIV' AND DATE(e.date_started) <= DATE(@endDate)
                                GROUP BY e.patient_id HAVING TIMESTAMPDIFF(MONTH,date_started,DATE(@endDate)) < 3)e)
AND p.`patient_id` NOT IN
(SELECT p.`patient_id` FROM kenyaemr_etl.`etl_patient_demographics` p WHERE p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d
                                    WHERE d.program_name = 'HIV'
                                          AND DATE(d.effective_discontinuation_date)
                                          BETWEEN DATE(@startDate)
                                          AND DATE(@endDate)
                                          AND d.discontinuation_reason = 159492 AND d.trf_out_verified =1065)
OR p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034)

OR p.`patient_id` IN
(SELECT d.patient_id
                FROM kenyaemr_etl.etl_patient_demographics d
                         LEFT JOIN (SELECT dt.patient_id
                                    FROM kenyaemr_etl.etl_ccc_defaulter_tracing dt
                                    WHERE dt.is_final_trace = 1267
                                      AND dt.true_status = 164435
                                      AND DATE(dt.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dt
                                   ON d.patient_id = dt.patient_id
                         LEFT JOIN
                     (SELECT dc.patient_id
                      FROM kenyaemr_etl.etl_patient_program_discontinuation dc
                      WHERE dc.discontinuation_reason = 164349
                        AND DATE(dc.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dc ON d.patient_id = dc.patient_id
                WHERE dt.patient_id IS NOT NULL
                   OR dc.patient_id IS NOT NULL))
GROUP BY fup.`patient_id`) t WHERE t.breastfeeding = 'Yes' GROUP BY t.breastfeeding;

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "MHavAnZCOOJ" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F', 'M9WgZF3M1Ns',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M', 'UqhM8q5yX5s',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F', 'vBvWYKAplHX',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M', 'ST3sM0JpQMh',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F', 'EXjtAMYfZtB',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M', 'torkJKBt01E',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'ObtuPZxOt8Z',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'njp0MCdLV3g',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'eOCFWXD88Xj',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'PjxW3Ujsbio',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'VoRXHRvLOdE',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'dJZL6FHiCPr',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'gnrJY8ul7Gh',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'hwOe0NmqWDI',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'x20GH1rWFbS',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'RfaqUUfk8Rn',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'T87UeqXlwhZ',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'mKZfhqCgwTw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'mfQZLqO0wpt',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'kaYhcZFuprR',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'BQ0Ubzm7U9I',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'RaM5sQ7kves',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'UY5FvxvXnt6',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PIv36iYFL92',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'BDinRla76BQ',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'SqyjUPzpeA7',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'xUsD5LKc48C',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'A8tEnB77K4R',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F', 'rYKjhnWcBXR',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M', 'Pv5KPmGLJ37', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
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
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT e.patient_id FROM (SELECT e.patient_id,MIN(DATE(e.date_started)) AS date_started FROM kenyaemr_etl.etl_drug_event e WHERE e.program ='HIV' AND DATE(e.date_started) <= DATE(@endDate)
                                GROUP BY e.patient_id HAVING TIMESTAMPDIFF(MONTH,date_started,DATE(@endDate)) BETWEEN 3 AND 5)e)
AND p.`patient_id` NOT IN
(SELECT p.`patient_id` FROM kenyaemr_etl.`etl_patient_demographics` p WHERE p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d
                                    WHERE d.program_name = 'HIV'
                                          AND DATE(d.effective_discontinuation_date)
                                          BETWEEN DATE(@startDate)
                                          AND DATE(@endDate)
                                          AND d.discontinuation_reason = 159492 AND d.trf_out_verified =1065)
OR p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034)

OR p.`patient_id` IN
(SELECT d.patient_id
                FROM kenyaemr_etl.etl_patient_demographics d
                         LEFT JOIN (SELECT dt.patient_id
                                    FROM kenyaemr_etl.etl_ccc_defaulter_tracing dt
                                    WHERE dt.is_final_trace = 1267
                                      AND dt.true_status = 164435
                                      AND DATE(dt.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dt
                                   ON d.patient_id = dt.patient_id
                         LEFT JOIN
                     (SELECT dc.patient_id
                      FROM kenyaemr_etl.etl_patient_program_discontinuation dc
                      WHERE dc.discontinuation_reason = 164349
                        AND DATE(dc.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dc ON d.patient_id = dc.patient_id
                WHERE dt.patient_id IS NOT NULL
                   OR dc.patient_id IS NOT NULL))
) tx GROUP BY tx.gender, tx.age_group

-- KP Section 
 UNION SELECT "AuGDaWr2ifR" data_element, (CASE t.key_population_type
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
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT e.patient_id FROM (SELECT e.patient_id,MIN(DATE(e.date_started)) AS date_started FROM kenyaemr_etl.etl_drug_event e WHERE e.program ='HIV' AND DATE(e.date_started) <= DATE(@endDate)
                                GROUP BY e.patient_id HAVING TIMESTAMPDIFF(MONTH,date_started,DATE(@endDate)) BETWEEN 3 AND 5)e)
AND p.`patient_id` NOT IN
(SELECT p.`patient_id` FROM kenyaemr_etl.`etl_patient_demographics` p WHERE p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d
                                    WHERE d.program_name = 'HIV'
                                          AND DATE(d.effective_discontinuation_date)
                                          BETWEEN DATE(@startDate)
                                          AND DATE(@endDate)
                                          AND d.discontinuation_reason = 159492 AND d.trf_out_verified =1065)
OR p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034)

OR p.`patient_id` IN
(SELECT d.patient_id
                FROM kenyaemr_etl.etl_patient_demographics d
                         LEFT JOIN (SELECT dt.patient_id
                                    FROM kenyaemr_etl.etl_ccc_defaulter_tracing dt
                                    WHERE dt.is_final_trace = 1267
                                      AND dt.true_status = 164435
                                      AND DATE(dt.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dt
                                   ON d.patient_id = dt.patient_id
                         LEFT JOIN
                     (SELECT dc.patient_id
                      FROM kenyaemr_etl.etl_patient_program_discontinuation dc
                      WHERE dc.discontinuation_reason = 164349
                        AND DATE(dc.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dc ON d.patient_id = dc.patient_id
                WHERE dt.patient_id IS NOT NULL
                   OR dc.patient_id IS NOT NULL))                                    
                               GROUP BY fup.`patient_id`) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type

-- PG Section
UNION SELECT "AuGDaWr2ifR" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value` 
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT e.patient_id FROM (SELECT e.patient_id,MIN(DATE(e.date_started)) AS date_started FROM kenyaemr_etl.etl_drug_event e WHERE e.program ='HIV' AND DATE(e.date_started) <= DATE(@endDate)
                                GROUP BY e.patient_id HAVING TIMESTAMPDIFF(MONTH,date_started,DATE(@endDate)) BETWEEN 3 AND 5)e)
AND p.`patient_id` NOT IN
(SELECT p.`patient_id` FROM kenyaemr_etl.`etl_patient_demographics` p WHERE p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d
                                    WHERE d.program_name = 'HIV'
                                          AND DATE(d.effective_discontinuation_date)
                                          BETWEEN DATE(@startDate)
                                          AND DATE(@endDate)
                                          AND d.discontinuation_reason = 159492 AND d.trf_out_verified =1065)
OR p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034)

OR p.`patient_id` IN
(SELECT d.patient_id
                FROM kenyaemr_etl.etl_patient_demographics d
                         LEFT JOIN (SELECT dt.patient_id
                                    FROM kenyaemr_etl.etl_ccc_defaulter_tracing dt
                                    WHERE dt.is_final_trace = 1267
                                      AND dt.true_status = 164435
                                      AND DATE(dt.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dt
                                   ON d.patient_id = dt.patient_id
                         LEFT JOIN
                     (SELECT dc.patient_id
                      FROM kenyaemr_etl.etl_patient_program_discontinuation dc
                      WHERE dc.discontinuation_reason = 164349
                        AND DATE(dc.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dc ON d.patient_id = dc.patient_id
                WHERE dt.patient_id IS NOT NULL
                   OR dc.patient_id IS NOT NULL))
GROUP BY fup.`patient_id`) t WHERE t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status

-- BF Section
UNION SELECT "AuGDaWr2ifR" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT e.patient_id FROM (SELECT e.patient_id,MIN(DATE(e.date_started)) AS date_started FROM kenyaemr_etl.etl_drug_event e WHERE e.program ='HIV' AND DATE(e.date_started) <= DATE(@endDate)
                                GROUP BY e.patient_id HAVING TIMESTAMPDIFF(MONTH,date_started,DATE(@endDate)) BETWEEN 3 AND 5)e)
AND p.`patient_id` NOT IN
(SELECT p.`patient_id` FROM kenyaemr_etl.`etl_patient_demographics` p WHERE p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d
                                    WHERE d.program_name = 'HIV'
                                          AND DATE(d.effective_discontinuation_date)
                                          BETWEEN DATE(@startDate)
                                          AND DATE(@endDate)
                                          AND d.discontinuation_reason = 159492 AND d.trf_out_verified =1065)
OR p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034)

OR p.`patient_id` IN
(SELECT d.patient_id
                FROM kenyaemr_etl.etl_patient_demographics d
                         LEFT JOIN (SELECT dt.patient_id
                                    FROM kenyaemr_etl.etl_ccc_defaulter_tracing dt
                                    WHERE dt.is_final_trace = 1267
                                      AND dt.true_status = 164435
                                      AND DATE(dt.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dt
                                   ON d.patient_id = dt.patient_id
                         LEFT JOIN
                     (SELECT dc.patient_id
                      FROM kenyaemr_etl.etl_patient_program_discontinuation dc
                      WHERE dc.discontinuation_reason = 164349
                        AND DATE(dc.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dc ON d.patient_id = dc.patient_id
                WHERE dt.patient_id IS NOT NULL
                   OR dc.patient_id IS NOT NULL))
GROUP BY fup.`patient_id`) t WHERE t.breastfeeding = 'Yes' GROUP BY t.breastfeeding;

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "hljl9rFXtEl" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F', 'M9WgZF3M1Ns',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M', 'UqhM8q5yX5s',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F', 'vBvWYKAplHX',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M', 'ST3sM0JpQMh',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F', 'EXjtAMYfZtB',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M', 'torkJKBt01E',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'ObtuPZxOt8Z',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'njp0MCdLV3g',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'eOCFWXD88Xj',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'PjxW3Ujsbio',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'VoRXHRvLOdE',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'dJZL6FHiCPr',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'gnrJY8ul7Gh',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'hwOe0NmqWDI',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'x20GH1rWFbS',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'RfaqUUfk8Rn',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'T87UeqXlwhZ',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'mKZfhqCgwTw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'mfQZLqO0wpt',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'kaYhcZFuprR',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'BQ0Ubzm7U9I',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'RaM5sQ7kves',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'UY5FvxvXnt6',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PIv36iYFL92',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'BDinRla76BQ',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'SqyjUPzpeA7',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'xUsD5LKc48C',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'A8tEnB77K4R',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F', 'rYKjhnWcBXR',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M', 'Pv5KPmGLJ37', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
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
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT e.patient_id FROM (SELECT e.patient_id,MIN(DATE(e.date_started)) AS date_started FROM kenyaemr_etl.etl_drug_event e WHERE e.program ='HIV' AND DATE(e.date_started) <= DATE(@endDate)
                                GROUP BY e.patient_id HAVING TIMESTAMPDIFF(MONTH,date_started,DATE(@endDate)) >= 6)e)
AND p.`patient_id` NOT IN
(SELECT p.`patient_id` FROM kenyaemr_etl.`etl_patient_demographics` p WHERE p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d
                                    WHERE d.program_name = 'HIV'
                                          AND DATE(d.effective_discontinuation_date)
                                          BETWEEN DATE(@startDate)
                                          AND DATE(@endDate)
                                          AND d.discontinuation_reason = 159492 AND d.trf_out_verified =1065)
OR p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034)

OR p.`patient_id` IN
(SELECT d.patient_id
                FROM kenyaemr_etl.etl_patient_demographics d
                         LEFT JOIN (SELECT dt.patient_id
                                    FROM kenyaemr_etl.etl_ccc_defaulter_tracing dt
                                    WHERE dt.is_final_trace = 1267
                                      AND dt.true_status = 164435
                                      AND DATE(dt.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dt
                                   ON d.patient_id = dt.patient_id
                         LEFT JOIN
                     (SELECT dc.patient_id
                      FROM kenyaemr_etl.etl_patient_program_discontinuation dc
                      WHERE dc.discontinuation_reason = 164349
                        AND DATE(dc.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dc ON d.patient_id = dc.patient_id
                WHERE dt.patient_id IS NOT NULL
                   OR dc.patient_id IS NOT NULL))
) tx GROUP BY tx.gender, tx.age_group

-- KP Section 
UNION SELECT "sKy3NAumeSH" data_element, (CASE t.key_population_type
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
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT e.patient_id FROM (SELECT e.patient_id,MIN(DATE(e.date_started)) AS date_started FROM kenyaemr_etl.etl_drug_event e WHERE e.program ='HIV' AND DATE(e.date_started) <= DATE(@endDate)
                                GROUP BY e.patient_id HAVING TIMESTAMPDIFF(MONTH,date_started,DATE(@endDate)) >= 6)e)
AND p.`patient_id` NOT IN
(SELECT p.`patient_id` FROM kenyaemr_etl.`etl_patient_demographics` p WHERE p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d
                                    WHERE d.program_name = 'HIV'
                                          AND DATE(d.effective_discontinuation_date)
                                          BETWEEN DATE(@startDate)
                                          AND DATE(@endDate)
                                          AND d.discontinuation_reason = 159492 AND d.trf_out_verified =1065)
OR p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034)

OR p.`patient_id` IN
(SELECT d.patient_id
                FROM kenyaemr_etl.etl_patient_demographics d
                         LEFT JOIN (SELECT dt.patient_id
                                    FROM kenyaemr_etl.etl_ccc_defaulter_tracing dt
                                    WHERE dt.is_final_trace = 1267
                                      AND dt.true_status = 164435
                                      AND DATE(dt.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dt
                                   ON d.patient_id = dt.patient_id
                         LEFT JOIN
                     (SELECT dc.patient_id
                      FROM kenyaemr_etl.etl_patient_program_discontinuation dc
                      WHERE dc.discontinuation_reason = 164349
                        AND DATE(dc.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dc ON d.patient_id = dc.patient_id
                WHERE dt.patient_id IS NOT NULL
                   OR dc.patient_id IS NOT NULL))                                    
                               GROUP BY fup.`patient_id`) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type

-- PG Section
UNION SELECT "sKy3NAumeSH" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value` 
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT e.patient_id FROM (SELECT e.patient_id,MIN(DATE(e.date_started)) AS date_started FROM kenyaemr_etl.etl_drug_event e WHERE e.program ='HIV' AND DATE(e.date_started) <= DATE(@endDate)
                                GROUP BY e.patient_id HAVING TIMESTAMPDIFF(MONTH,date_started,DATE(@endDate)) >= 6)e)
AND p.`patient_id` NOT IN
(SELECT p.`patient_id` FROM kenyaemr_etl.`etl_patient_demographics` p WHERE p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d
                                    WHERE d.program_name = 'HIV'
                                          AND DATE(d.effective_discontinuation_date)
                                          BETWEEN DATE(@startDate)
                                          AND DATE(@endDate)
                                          AND d.discontinuation_reason = 159492 AND d.trf_out_verified =1065)
OR p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034)

OR p.`patient_id` IN
(SELECT d.patient_id
                FROM kenyaemr_etl.etl_patient_demographics d
                         LEFT JOIN (SELECT dt.patient_id
                                    FROM kenyaemr_etl.etl_ccc_defaulter_tracing dt
                                    WHERE dt.is_final_trace = 1267
                                      AND dt.true_status = 164435
                                      AND DATE(dt.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dt
                                   ON d.patient_id = dt.patient_id
                         LEFT JOIN
                     (SELECT dc.patient_id
                      FROM kenyaemr_etl.etl_patient_program_discontinuation dc
                      WHERE dc.discontinuation_reason = 164349
                        AND DATE(dc.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dc ON d.patient_id = dc.patient_id
                WHERE dt.patient_id IS NOT NULL
                   OR dc.patient_id IS NOT NULL))
GROUP BY fup.`patient_id`) t WHERE t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status

-- BF Section
UNION SELECT "sKy3NAumeSH" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT e.patient_id FROM (SELECT e.patient_id,MIN(DATE(e.date_started)) AS date_started FROM kenyaemr_etl.etl_drug_event e WHERE e.program ='HIV' AND DATE(e.date_started) <= DATE(@endDate)
                                GROUP BY e.patient_id HAVING TIMESTAMPDIFF(MONTH,date_started,DATE(@endDate)) >= 6)e)
AND p.`patient_id` NOT IN
(SELECT p.`patient_id` FROM kenyaemr_etl.`etl_patient_demographics` p WHERE p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d
                                    WHERE d.program_name = 'HIV'
                                          AND DATE(d.effective_discontinuation_date)
                                          BETWEEN DATE(@startDate)
                                          AND DATE(@endDate)
                                          AND d.discontinuation_reason = 159492 AND d.trf_out_verified =1065)
OR p.`patient_id` IN
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034)

OR p.`patient_id` IN
(SELECT d.patient_id
                FROM kenyaemr_etl.etl_patient_demographics d
                         LEFT JOIN (SELECT dt.patient_id
                                    FROM kenyaemr_etl.etl_ccc_defaulter_tracing dt
                                    WHERE dt.is_final_trace = 1267
                                      AND dt.true_status = 164435
                                      AND DATE(dt.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dt
                                   ON d.patient_id = dt.patient_id
                         LEFT JOIN
                     (SELECT dc.patient_id
                      FROM kenyaemr_etl.etl_patient_program_discontinuation dc
                      WHERE dc.discontinuation_reason = 164349
                        AND DATE(dc.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate)) dc ON d.patient_id = dc.patient_id
                WHERE dt.patient_id IS NOT NULL
                   OR dc.patient_id IS NOT NULL))
GROUP BY fup.`patient_id`) t WHERE t.breastfeeding = 'Yes' GROUP BY t.breastfeeding;

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "uWO3qx8G8G3" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F',   'GNeIO7NKWbK',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M',   'R8VOVnilPsi',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F',   'yYsa6DgPQ1L',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M',   'TFfIA3ckZB9',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F',   'acWpnRJooLl',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M',   'iLUjUofsGws',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'Vi9ZZq1LOkV',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'm6J0HSpVpm9',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'xJD7BCOuWnJ',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'P3One8fmJuO',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'ZIed1fqNBHk',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'F1v9qUgeVnj',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'vm6xxjuNEP2',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'vQTsctb3eG2',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'X7DtVP2AY4T',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'C3dmnSwK2tg',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'cAdmFsboYke',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'm220Qa5Nvgc',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'YNvPgPCTDcw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'wvZYZVnGhX0',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'k5qtSzz0GdB',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'p6RS8ympUB1',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'kEbSx1fQvKw',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PCU8aoLAePM',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'Fgv4QXMK7ql',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'A4sOddTlvUY',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'cZmfXVkxuBC',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'l0UzujCOViJ',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F',   'c1TfvEBhzxV',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M',   'R72TdJJC0Qi', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
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
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 163324)

) tx GROUP BY tx.gender, tx.age_group

-- KP Section 
UNION SELECT "SX0KNqg6FiQ" data_element, (CASE t.key_population_type
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
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 163324)                                    
                               GROUP BY fup.`patient_id`) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type

-- PG Section
UNION SELECT "SX0KNqg6FiQ" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value` 
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 163324)
GROUP BY fup.`patient_id`) t WHERE t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status

-- BF section
UNION SELECT "SX0KNqg6FiQ" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 163324)
GROUP BY fup.`patient_id`) t WHERE t.breastfeeding = 'Yes' GROUP BY t.breastfeeding;

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "H5mO66YYAJm" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F',   'GNeIO7NKWbK',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M',   'R8VOVnilPsi',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F',   'yYsa6DgPQ1L',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M',   'TFfIA3ckZB9',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F',   'acWpnRJooLl',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M',   'iLUjUofsGws',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'Vi9ZZq1LOkV',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'm6J0HSpVpm9',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'xJD7BCOuWnJ',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'P3One8fmJuO',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'ZIed1fqNBHk',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'F1v9qUgeVnj',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'vm6xxjuNEP2',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'vQTsctb3eG2',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'X7DtVP2AY4T',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'C3dmnSwK2tg',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'cAdmFsboYke',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'm220Qa5Nvgc',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'YNvPgPCTDcw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'wvZYZVnGhX0',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'k5qtSzz0GdB',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'p6RS8ympUB1',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'kEbSx1fQvKw',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PCU8aoLAePM',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'Fgv4QXMK7ql',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'A4sOddTlvUY',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'cZmfXVkxuBC',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'l0UzujCOViJ',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F',   'c1TfvEBhzxV',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M',   'R72TdJJC0Qi', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
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
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 116030)

) tx GROUP BY tx.gender, tx.age_group

-- KP Section 
UNION SELECT "Hn9weltUe1b" data_element, (CASE t.key_population_type
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
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 116030)                                    
                               GROUP BY fup.`patient_id`) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type

-- PG Section
UNION SELECT "Hn9weltUe1b" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value` 
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 116030)
GROUP BY fup.`patient_id`) t WHERE t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status

-- BF Section
UNION SELECT "Hn9weltUe1b" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 116030)
GROUP BY fup.`patient_id`) t WHERE t.breastfeeding = 'Yes' GROUP BY t.breastfeeding;

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "gIcp6q0TqpZ" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F',   'GNeIO7NKWbK',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M',   'R8VOVnilPsi',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F',   'yYsa6DgPQ1L',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M',   'TFfIA3ckZB9',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F',   'acWpnRJooLl',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M',   'iLUjUofsGws',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'Vi9ZZq1LOkV',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'm6J0HSpVpm9',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'xJD7BCOuWnJ',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'P3One8fmJuO',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'ZIed1fqNBHk',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'F1v9qUgeVnj',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'vm6xxjuNEP2',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'vQTsctb3eG2',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'X7DtVP2AY4T',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'C3dmnSwK2tg',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'cAdmFsboYke',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'm220Qa5Nvgc',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'YNvPgPCTDcw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'wvZYZVnGhX0',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'k5qtSzz0GdB',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'p6RS8ympUB1',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'kEbSx1fQvKw',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PCU8aoLAePM',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'Fgv4QXMK7ql',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'A4sOddTlvUY',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'cZmfXVkxuBC',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'l0UzujCOViJ',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F',   'c1TfvEBhzxV',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M',   'R72TdJJC0Qi', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
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
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 160159)

) tx GROUP BY tx.gender, tx.age_group

-- KP Section 
UNION SELECT "Ut23wGsJdwO" data_element, (CASE t.key_population_type
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
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 160159)                                    
                               GROUP BY fup.`patient_id`) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type

-- PG Section
UNION SELECT "Ut23wGsJdwO" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value` 
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 160159)
GROUP BY fup.`patient_id`) t WHERE t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status

-- BF Section
UNION SELECT "Ut23wGsJdwO" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 160159)
GROUP BY fup.`patient_id`) t WHERE t.breastfeeding = 'Yes' GROUP BY t.breastfeeding;

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "wHW2C8Ca9HS" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F',   'GNeIO7NKWbK',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M',   'R8VOVnilPsi',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F',   'yYsa6DgPQ1L',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M',   'TFfIA3ckZB9',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F',   'acWpnRJooLl',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M',   'iLUjUofsGws',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'Vi9ZZq1LOkV',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'm6J0HSpVpm9',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'xJD7BCOuWnJ',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'P3One8fmJuO',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'ZIed1fqNBHk',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'F1v9qUgeVnj',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'vm6xxjuNEP2',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'vQTsctb3eG2',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'X7DtVP2AY4T',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'C3dmnSwK2tg',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'cAdmFsboYke',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'm220Qa5Nvgc',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'YNvPgPCTDcw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'wvZYZVnGhX0',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'k5qtSzz0GdB',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'p6RS8ympUB1',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'kEbSx1fQvKw',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PCU8aoLAePM',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'Fgv4QXMK7ql',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'A4sOddTlvUY',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'cZmfXVkxuBC',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'l0UzujCOViJ',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F',   'c1TfvEBhzxV',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M',   'R72TdJJC0Qi', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
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
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 160158)

) tx GROUP BY tx.gender, tx.age_group

-- KP Section 
UNION SELECT "qUNJfNh86OZ" data_element, (CASE t.key_population_type
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
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 160158)                                    
                               GROUP BY fup.`patient_id`) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type

-- PG Section
UNION SELECT "qUNJfNh86OZ" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value` 
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 160158)
GROUP BY fup.`patient_id`) t WHERE t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status

-- BF Section
UNION SELECT "qUNJfNh86OZ" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 160158)
GROUP BY fup.`patient_id`) t WHERE t.breastfeeding = 'Yes' GROUP BY t.breastfeeding;

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "IpUWkPU1I96" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F',   'GNeIO7NKWbK',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M',   'R8VOVnilPsi',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F',   'yYsa6DgPQ1L',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M',   'TFfIA3ckZB9',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F',   'acWpnRJooLl',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M',   'iLUjUofsGws',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'Vi9ZZq1LOkV',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'm6J0HSpVpm9',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'xJD7BCOuWnJ',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'P3One8fmJuO',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'ZIed1fqNBHk',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'F1v9qUgeVnj',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'vm6xxjuNEP2',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'vQTsctb3eG2',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'X7DtVP2AY4T',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'C3dmnSwK2tg',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'cAdmFsboYke',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'm220Qa5Nvgc',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'YNvPgPCTDcw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'wvZYZVnGhX0',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'k5qtSzz0GdB',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'p6RS8ympUB1',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'kEbSx1fQvKw',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PCU8aoLAePM',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'Fgv4QXMK7ql',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'A4sOddTlvUY',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'cZmfXVkxuBC',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'l0UzujCOViJ',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F',   'c1TfvEBhzxV',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M',   'R72TdJJC0Qi', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
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
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 133478)

) tx GROUP BY tx.gender, tx.age_group

-- KP Section 
UNION SELECT "v2MY4GnScw3" data_element, (CASE t.key_population_type
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
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 133478)                                    
                               GROUP BY fup.`patient_id`) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type

-- PG Section
UNION SELECT "v2MY4GnScw3" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value` 
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 133478)
GROUP BY fup.`patient_id`) t WHERE t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status

-- BF Section
UNION SELECT "v2MY4GnScw3" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 133478)
GROUP BY fup.`patient_id`) t WHERE t.breastfeeding = 'Yes' GROUP BY t.breastfeeding;

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "XJUjlUQttC1" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F',   'GNeIO7NKWbK',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M',   'R8VOVnilPsi',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F',   'yYsa6DgPQ1L',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M',   'TFfIA3ckZB9',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F',   'acWpnRJooLl',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M',   'iLUjUofsGws',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'Vi9ZZq1LOkV',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'm6J0HSpVpm9',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'xJD7BCOuWnJ',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'P3One8fmJuO',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'ZIed1fqNBHk',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'F1v9qUgeVnj',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'vm6xxjuNEP2',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'vQTsctb3eG2',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'X7DtVP2AY4T',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'C3dmnSwK2tg',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'cAdmFsboYke',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'm220Qa5Nvgc',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'YNvPgPCTDcw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'wvZYZVnGhX0',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'k5qtSzz0GdB',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'p6RS8ympUB1',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'kEbSx1fQvKw',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PCU8aoLAePM',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'Fgv4QXMK7ql',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'A4sOddTlvUY',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'cZmfXVkxuBC',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'l0UzujCOViJ',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F',   'c1TfvEBhzxV',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M',   'R72TdJJC0Qi', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
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
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 123812)

) tx GROUP BY tx.gender, tx.age_group

-- KP Section 
UNION SELECT "CajTXVzA29p" data_element, (CASE t.key_population_type
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
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 123812)                                    
                               GROUP BY fup.`patient_id`) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type

-- PG Section
UNION SELECT "CajTXVzA29p" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value` 
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 123812)
GROUP BY fup.`patient_id`) t WHERE t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status

-- BF Section
UNION SELECT "CajTXVzA29p" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 123812)
GROUP BY fup.`patient_id`) t WHERE t.breastfeeding = 'Yes' GROUP BY t.breastfeeding;

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "uPDzu4ZEfbe" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F',   'GNeIO7NKWbK',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M',   'R8VOVnilPsi',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F',   'yYsa6DgPQ1L',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M',   'TFfIA3ckZB9',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F',   'acWpnRJooLl',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M',   'iLUjUofsGws',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'Vi9ZZq1LOkV',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'm6J0HSpVpm9',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'xJD7BCOuWnJ',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'P3One8fmJuO',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'ZIed1fqNBHk',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'F1v9qUgeVnj',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'vm6xxjuNEP2',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'vQTsctb3eG2',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'X7DtVP2AY4T',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'C3dmnSwK2tg',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'cAdmFsboYke',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'm220Qa5Nvgc',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'YNvPgPCTDcw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'wvZYZVnGhX0',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'k5qtSzz0GdB',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'p6RS8ympUB1',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'kEbSx1fQvKw',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PCU8aoLAePM',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'Fgv4QXMK7ql',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'A4sOddTlvUY',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'cZmfXVkxuBC',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'l0UzujCOViJ',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F',   'c1TfvEBhzxV',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M',   'R72TdJJC0Qi', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, COUNT(tx.age_group) `value`
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
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 142917)

) tx GROUP BY tx.gender, tx.age_group

-- KP Section 
UNION SELECT "rJdg243K8Wx" data_element, (CASE t.key_population_type
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
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 142917)                                    
                               GROUP BY fup.`patient_id`) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type
-- PG Section
UNION SELECT "rJdg243K8Wx" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value` 
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 142917)
GROUP BY fup.`patient_id`) t WHERE t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status

-- BF Section
UNION SELECT "rJdg243K8Wx" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT p.`patient_id` FROM kenyaemr_etl.etl_patient_demographics p WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM (SELECT fup.visit_date,
                             fup.patient_id,
                             MAX(e.visit_date)                                                      AS enroll_date,
                             GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date), '0000-00-00')) AS latest_vis_date,
                             GREATEST(MID(MAX(CONCAT(fup.visit_date, fup.next_appointment_date)), 11),
                                      IFNULL(MAX(d.visit_date), '0000-00-00'))                      AS latest_tca,
                             d.patient_id                                                           AS disc_patient,
                             d.effective_disc_date                                                  AS effective_disc_date,
                             MAX(d.visit_date)                                                      AS date_discontinued,
                             de.patient_id                                                          AS started_on_drugs
                      FROM kenyaemr_etl.etl_patient_hiv_followup fup
                               JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id = fup.patient_id
                               JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id = e.patient_id
                               LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program = 'HIV' AND
                                                                                 DATE(date_started) < DATE(@startDate)
                               LEFT OUTER JOIN
                           (SELECT patient_id,
                                   COALESCE(DATE(effective_discontinuation_date), visit_date) visit_date,
                                   MAX(DATE(effective_discontinuation_date)) AS               effective_disc_date
                            FROM kenyaemr_etl.etl_patient_program_discontinuation
                            WHERE DATE(visit_date) < DATE(@startDate)
                              AND program_name = 'HIV'
                            GROUP BY patient_id) d ON d.patient_id = fup.patient_id
                      WHERE fup.visit_date < DATE(@startDate)
                      GROUP BY patient_id
                      HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '')
                         AND ((((TIMESTAMPDIFF(DAY, DATE(latest_tca), DATE(@startDate)) <=
                                 30) AND
                                ((DATE(d.effective_disc_date) > DATE(@startDate) OR
                                  DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                          AND
                               (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR
                                disc_patient IS NULL)
                          )
                          )) t)
OR p.`patient_id` IN
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
                                )net))
AND p.`patient_id` NOT IN
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
(SELECT d.patient_id FROM kenyaemr_etl.etl_patient_program_discontinuation d 
WHERE d.program_name = 'HIV' AND DATE(d.visit_date) BETWEEN DATE(@startDate) AND DATE(@endDate) AND d.discontinuation_reason = 160034 AND d.death_reason = 142917)
GROUP BY fup.`patient_id`) t WHERE t.breastfeeding = 'Yes' GROUP BY t.breastfeeding;

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "wJWftIFfLNn" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F', 'M9WgZF3M1Ns',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M', 'UqhM8q5yX5s',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F', 'vBvWYKAplHX',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M', 'ST3sM0JpQMh',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F', 'EXjtAMYfZtB',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M', 'torkJKBt01E',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'ObtuPZxOt8Z',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'njp0MCdLV3g',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'eOCFWXD88Xj',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'PjxW3Ujsbio',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'VoRXHRvLOdE',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'dJZL6FHiCPr',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'gnrJY8ul7Gh',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'hwOe0NmqWDI',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'x20GH1rWFbS',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'RfaqUUfk8Rn',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'T87UeqXlwhZ',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'mKZfhqCgwTw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'mfQZLqO0wpt',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'kaYhcZFuprR',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'BQ0Ubzm7U9I',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'RaM5sQ7kves',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'UY5FvxvXnt6',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PIv36iYFL92',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'BDinRla76BQ',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'SqyjUPzpeA7',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'xUsD5LKc48C',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'A8tEnB77K4R',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F', 'rYKjhnWcBXR',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M', 'Pv5KPmGLJ37', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, tx.entry_value
FROM (SELECT t.patient_id, gender, age_group, COUNT(t.age_group) entry_value, t.mfl, ou.`organization_unit`
 FROM(
     SELECT p.`Gender`, p.`DOB`, TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) AS age, fi.`siteCode` mfl,
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
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) > 64, '65+yrs', NULL))))))))))))))) age_group,    
     fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date,
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
              JOIN kenyaemr_etl.`etl_default_facility_info` fi
     WHERE fup.visit_date <= DATE(@endDate)
     GROUP BY patient_id
     HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
         (
             ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
               AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
             )
         )
     ) t LEFT JOIN ldwh.`facility_info` ou ON ou.`mfl`=t.mfl
     WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT vl.patient_id FROM (SELECT fup.patient_id, de.patient_id AS started_on_drugs,
           MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, test_result, NULL))),11) AS last_cd4_result,
	   MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, le.visit_date, NULL))),11) AS last_cd4_date
    FROM kenyaemr_etl.etl_patient_hiv_followup fup
           LEFT JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id=e.patient_id
           LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON fup.patient_id = de.patient_id AND de.program='HIV' AND DATE(date_started) <= DATE(@enddate)
           LEFT JOIN kenyaemr_etl.`etl_laboratory_extract` le ON le.`patient_id`=e.`patient_id`
           LEFT OUTER JOIN
             (SELECT patient_id, COALESCE(DATE(effective_discontinuation_date),visit_date) visit_date,MAX(DATE(effective_discontinuation_date)) AS effective_disc_date FROM kenyaemr_etl.etl_patient_program_discontinuation
              WHERE DATE(visit_date) <= DATE(@enddate) AND program_name='HIV'
              GROUP BY patient_id
             ) d ON d.patient_id = fup.patient_id
    WHERE fup.visit_date <= DATE(@enddate)
    GROUP BY patient_id
    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND last_cd4_result < 200 AND DATE(last_cd4_date) BETWEEN DATE(@startDate) AND DATE(@endDate) ) vl)GROUP BY t.gender, t.age_group) tx

-- KP section
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "ECMCfoUEqZM" data_element, (CASE t.key_population_type
					WHEN 'Female sex worker' THEN 'gNjREqP1dq8'
					WHEN 'Men who have sex with men' THEN 'G0alyNeHzFt'
					WHEN 'People who inject drugs' THEN 'rQud3arnRmr'
					WHEN 'Transgender' THEN 'ZFiEPANua6x'
					WHEN 'Fisher folk' THEN 'AbrdwgGtlZP'
					WHEN 'Prisoner' THEN 'hF8G1rUSaDu'
					END) category_option, t.`organization_unit`, @period period,
		COUNT(t.key_population_type) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,(CASE key_population_type WHEN 105 THEN 'People who inject drugs'
								WHEN 160578 THEN 'Men who have sex with men'
								WHEN 160579 THEN 'Female sex worker'
								WHEN 165100 THEN 'Transgender'
								WHEN 5622 THEN 'Other'
								WHEN 159674 THEN 'Fisher folk'
								WHEN 162198 THEN 'Truck driver'
								WHEN 160549 THEN 'Adolescent and young girls'
								WHEN 162277 THEN 'Prisoner'
								WHEN 165192 THEN 'Military and other uniformed services' END))),11) key_population_type,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT vl.patient_id FROM (SELECT fup.patient_id, de.patient_id AS started_on_drugs,
           MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, test_result, NULL))),11) AS last_cd4_result,
	   MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, le.visit_date, NULL))),11) AS last_cd4_date
    FROM kenyaemr_etl.etl_patient_hiv_followup fup
           LEFT JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id=e.patient_id
           LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON fup.patient_id = de.patient_id AND de.program='HIV' AND DATE(date_started) <= DATE(@enddate)
           LEFT JOIN kenyaemr_etl.`etl_laboratory_extract` le ON le.`patient_id`=e.`patient_id`
           LEFT OUTER JOIN
             (SELECT patient_id, COALESCE(DATE(effective_discontinuation_date),visit_date) visit_date,MAX(DATE(effective_discontinuation_date)) AS effective_disc_date FROM kenyaemr_etl.etl_patient_program_discontinuation
              WHERE DATE(visit_date) <= DATE(@enddate) AND program_name='HIV'
              GROUP BY patient_id
             ) d ON d.patient_id = fup.patient_id
    WHERE fup.visit_date <= DATE(@enddate)
    GROUP BY patient_id
    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND last_cd4_result < 200 AND DATE(last_cd4_date) BETWEEN DATE(@startDate) AND DATE(@endDate) ) vl)
                     AND t.key_population_type IS NOT NULL GROUP BY t.key_population_type) rtt

-- PG section	
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "ECMCfoUEqZM" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT vl.patient_id FROM (SELECT fup.patient_id, de.patient_id AS started_on_drugs,
           MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, test_result, NULL))),11) AS last_cd4_result,
	   MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, le.visit_date, NULL))),11) AS last_cd4_date
    FROM kenyaemr_etl.etl_patient_hiv_followup fup
           LEFT JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id=e.patient_id
           LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON fup.patient_id = de.patient_id AND de.program='HIV' AND DATE(date_started) <= DATE(@enddate)
           LEFT JOIN kenyaemr_etl.`etl_laboratory_extract` le ON le.`patient_id`=e.`patient_id`
           LEFT OUTER JOIN
             (SELECT patient_id, COALESCE(DATE(effective_discontinuation_date),visit_date) visit_date,MAX(DATE(effective_discontinuation_date)) AS effective_disc_date FROM kenyaemr_etl.etl_patient_program_discontinuation
              WHERE DATE(visit_date) <= DATE(@enddate) AND program_name='HIV'
              GROUP BY patient_id
             ) d ON d.patient_id = fup.patient_id
    WHERE fup.visit_date <= DATE(@enddate)
    GROUP BY patient_id
    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND last_cd4_result < 200 AND DATE(last_cd4_date) BETWEEN DATE(@startDate) AND DATE(@endDate) ) vl)
                     AND t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status) rtt

-- BF section	
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "ECMCfoUEqZM" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT vl.patient_id FROM (SELECT fup.patient_id, de.patient_id AS started_on_drugs,
           MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, test_result, NULL))),11) AS last_cd4_result,
	   MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, le.visit_date, NULL))),11) AS last_cd4_date
    FROM kenyaemr_etl.etl_patient_hiv_followup fup
           LEFT JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id=e.patient_id
           LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON fup.patient_id = de.patient_id AND de.program='HIV' AND DATE(date_started) <= DATE(@enddate)
           LEFT JOIN kenyaemr_etl.`etl_laboratory_extract` le ON le.`patient_id`=e.`patient_id`
           LEFT OUTER JOIN
             (SELECT patient_id, COALESCE(DATE(effective_discontinuation_date),visit_date) visit_date,MAX(DATE(effective_discontinuation_date)) AS effective_disc_date FROM kenyaemr_etl.etl_patient_program_discontinuation
              WHERE DATE(visit_date) <= DATE(@enddate) AND program_name='HIV'
              GROUP BY patient_id
             ) d ON d.patient_id = fup.patient_id
    WHERE fup.visit_date <= DATE(@enddate)
    GROUP BY patient_id
    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND last_cd4_result < 200 AND DATE(last_cd4_date) BETWEEN DATE(@startDate) AND DATE(@endDate) ) vl)
                     AND t.breastfeeding = 'Yes' GROUP BY t.breastfeeding) rtt;

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "noy5pevrOE3" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F', 'M9WgZF3M1Ns',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M', 'UqhM8q5yX5s',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F', 'vBvWYKAplHX',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M', 'ST3sM0JpQMh',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F', 'EXjtAMYfZtB',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M', 'torkJKBt01E',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'ObtuPZxOt8Z',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'njp0MCdLV3g',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'eOCFWXD88Xj',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'PjxW3Ujsbio',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'VoRXHRvLOdE',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'dJZL6FHiCPr',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'gnrJY8ul7Gh',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'hwOe0NmqWDI',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'x20GH1rWFbS',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'RfaqUUfk8Rn',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'T87UeqXlwhZ',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'mKZfhqCgwTw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'mfQZLqO0wpt',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'kaYhcZFuprR',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'BQ0Ubzm7U9I',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'RaM5sQ7kves',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'UY5FvxvXnt6',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PIv36iYFL92',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'BDinRla76BQ',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'SqyjUPzpeA7',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'xUsD5LKc48C',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'A8tEnB77K4R',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F', 'rYKjhnWcBXR',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M', 'Pv5KPmGLJ37', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, tx.entry_value
FROM (SELECT t.patient_id, gender, age_group, COUNT(t.age_group) entry_value, t.mfl, ou.`organization_unit`
 FROM(
     SELECT p.`Gender`, p.`DOB`, TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) AS age, fi.`siteCode` mfl,
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
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) > 64, '65+yrs', NULL))))))))))))))) age_group,    
     fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date,
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
              JOIN kenyaemr_etl.`etl_default_facility_info` fi
     WHERE fup.visit_date <= DATE(@endDate)
     GROUP BY patient_id
     HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
         (
             ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
               AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
             )
         )
     ) t LEFT JOIN ldwh.`facility_info` ou ON ou.`mfl`=t.mfl
     WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT vl.patient_id FROM (SELECT fup.patient_id, de.patient_id AS started_on_drugs,
           MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, test_result, NULL))),11) AS last_cd4_result,
	   MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, le.visit_date, NULL))),11) AS last_cd4_date
    FROM kenyaemr_etl.etl_patient_hiv_followup fup
           LEFT JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id=e.patient_id
           LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON fup.patient_id = de.patient_id AND de.program='HIV' AND DATE(date_started) <= DATE(@enddate)
           LEFT JOIN kenyaemr_etl.`etl_laboratory_extract` le ON le.`patient_id`=e.`patient_id`
           LEFT OUTER JOIN
             (SELECT patient_id, COALESCE(DATE(effective_discontinuation_date),visit_date) visit_date,MAX(DATE(effective_discontinuation_date)) AS effective_disc_date FROM kenyaemr_etl.etl_patient_program_discontinuation
              WHERE DATE(visit_date) <= DATE(@enddate) AND program_name='HIV'
              GROUP BY patient_id
             ) d ON d.patient_id = fup.patient_id
    WHERE fup.visit_date <= DATE(@enddate)
    GROUP BY patient_id
    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND last_cd4_result >= 200 AND DATE(last_cd4_date) BETWEEN DATE(@startDate) AND DATE(@endDate) ) vl)GROUP BY t.gender, t.age_group) tx

-- KP section
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "xnVcUeR6UW7" data_element, (CASE t.key_population_type
					WHEN 'Female sex worker' THEN 'gNjREqP1dq8'
					WHEN 'Men who have sex with men' THEN 'G0alyNeHzFt'
					WHEN 'People who inject drugs' THEN 'rQud3arnRmr'
					WHEN 'Transgender' THEN 'ZFiEPANua6x'
					WHEN 'Fisher folk' THEN 'AbrdwgGtlZP'
					WHEN 'Prisoner' THEN 'hF8G1rUSaDu'
					END) category_option, t.`organization_unit`, @period period,
		COUNT(t.key_population_type) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,(CASE key_population_type WHEN 105 THEN 'People who inject drugs'
								WHEN 160578 THEN 'Men who have sex with men'
								WHEN 160579 THEN 'Female sex worker'
								WHEN 165100 THEN 'Transgender'
								WHEN 5622 THEN 'Other'
								WHEN 159674 THEN 'Fisher folk'
								WHEN 162198 THEN 'Truck driver'
								WHEN 160549 THEN 'Adolescent and young girls'
								WHEN 162277 THEN 'Prisoner'
								WHEN 165192 THEN 'Military and other uniformed services' END))),11) key_population_type,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT vl.patient_id FROM (SELECT fup.patient_id, de.patient_id AS started_on_drugs,
           MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, test_result, NULL))),11) AS last_cd4_result,
	   MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, le.visit_date, NULL))),11) AS last_cd4_date
    FROM kenyaemr_etl.etl_patient_hiv_followup fup
           LEFT JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id=e.patient_id
           LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON fup.patient_id = de.patient_id AND de.program='HIV' AND DATE(date_started) <= DATE(@enddate)
           LEFT JOIN kenyaemr_etl.`etl_laboratory_extract` le ON le.`patient_id`=e.`patient_id`
           LEFT OUTER JOIN
             (SELECT patient_id, COALESCE(DATE(effective_discontinuation_date),visit_date) visit_date,MAX(DATE(effective_discontinuation_date)) AS effective_disc_date FROM kenyaemr_etl.etl_patient_program_discontinuation
              WHERE DATE(visit_date) <= DATE(@enddate) AND program_name='HIV'
              GROUP BY patient_id
             ) d ON d.patient_id = fup.patient_id
    WHERE fup.visit_date <= DATE(@enddate)
    GROUP BY patient_id
    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND last_cd4_result >= 200 AND DATE(last_cd4_date) BETWEEN DATE(@startDate) AND DATE(@endDate) ) vl)
                     AND t.key_population_type IS NOT NULL GROUP BY t.key_population_type) rtt

-- PG section	
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "xnVcUeR6UW7" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT vl.patient_id FROM (SELECT fup.patient_id, de.patient_id AS started_on_drugs,
           MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, test_result, NULL))),11) AS last_cd4_result,
	   MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, le.visit_date, NULL))),11) AS last_cd4_date
    FROM kenyaemr_etl.etl_patient_hiv_followup fup
           LEFT JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id=e.patient_id
           LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON fup.patient_id = de.patient_id AND de.program='HIV' AND DATE(date_started) <= DATE(@enddate)
           LEFT JOIN kenyaemr_etl.`etl_laboratory_extract` le ON le.`patient_id`=e.`patient_id`
           LEFT OUTER JOIN
             (SELECT patient_id, COALESCE(DATE(effective_discontinuation_date),visit_date) visit_date,MAX(DATE(effective_discontinuation_date)) AS effective_disc_date FROM kenyaemr_etl.etl_patient_program_discontinuation
              WHERE DATE(visit_date) <= DATE(@enddate) AND program_name='HIV'
              GROUP BY patient_id
             ) d ON d.patient_id = fup.patient_id
    WHERE fup.visit_date <= DATE(@enddate)
    GROUP BY patient_id
    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND last_cd4_result >= 200 AND DATE(last_cd4_date) BETWEEN DATE(@startDate) AND DATE(@endDate) ) vl)
                     AND t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status) rtt

-- BF section	
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "xnVcUeR6UW7" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id IN (SELECT vl.patient_id FROM (SELECT fup.patient_id, de.patient_id AS started_on_drugs,
           MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, test_result, NULL))),11) AS last_cd4_result,
	   MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, le.visit_date, NULL))),11) AS last_cd4_date
    FROM kenyaemr_etl.etl_patient_hiv_followup fup
           LEFT JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id=e.patient_id
           LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON fup.patient_id = de.patient_id AND de.program='HIV' AND DATE(date_started) <= DATE(@enddate)
           LEFT JOIN kenyaemr_etl.`etl_laboratory_extract` le ON le.`patient_id`=e.`patient_id`
           LEFT OUTER JOIN
             (SELECT patient_id, COALESCE(DATE(effective_discontinuation_date),visit_date) visit_date,MAX(DATE(effective_discontinuation_date)) AS effective_disc_date FROM kenyaemr_etl.etl_patient_program_discontinuation
              WHERE DATE(visit_date) <= DATE(@enddate) AND program_name='HIV'
              GROUP BY patient_id
             ) d ON d.patient_id = fup.patient_id
    WHERE fup.visit_date <= DATE(@enddate)
    GROUP BY patient_id
    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND last_cd4_result >= 200 AND DATE(last_cd4_date) BETWEEN DATE(@startDate) AND DATE(@endDate) ) vl)
                     AND t.breastfeeding = 'Yes' GROUP BY t.breastfeeding) rtt;

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "UH9sK24Weby" data_element,
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'F', 'M9WgZF3M1Ns',
	IF(tx.age_group = '< 1yrs' AND tx.gender = 'M', 'UqhM8q5yX5s',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'F', 'vBvWYKAplHX',
	IF(tx.age_group = '1-4yrs' AND tx.gender = 'M', 'ST3sM0JpQMh',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'F', 'EXjtAMYfZtB',
	IF(tx.age_group = '5-9yrs' AND tx.gender = 'M', 'torkJKBt01E',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'F', 'ObtuPZxOt8Z',
	IF(tx.age_group = '10-14yrs' AND tx.gender = 'M', 'njp0MCdLV3g',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'F', 'eOCFWXD88Xj',
	IF(tx.age_group = '15-19yrs' AND tx.gender = 'M', 'PjxW3Ujsbio',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'F', 'VoRXHRvLOdE',
	IF(tx.age_group = '20-24yrs' AND tx.gender = 'M', 'dJZL6FHiCPr',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'F', 'gnrJY8ul7Gh',
	IF(tx.age_group = '25-29yrs' AND tx.gender = 'M', 'hwOe0NmqWDI',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'F', 'x20GH1rWFbS',
	IF(tx.age_group = '30-34yrs' AND tx.gender = 'M', 'RfaqUUfk8Rn',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'F', 'T87UeqXlwhZ',
	IF(tx.age_group = '35-39yrs' AND tx.gender = 'M', 'mKZfhqCgwTw',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'F', 'mfQZLqO0wpt',
	IF(tx.age_group = '40-44yrs' AND tx.gender = 'M', 'kaYhcZFuprR',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'F', 'BQ0Ubzm7U9I',
	IF(tx.age_group = '45-49yrs' AND tx.gender = 'M', 'RaM5sQ7kves',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'F', 'UY5FvxvXnt6',
	IF(tx.age_group = '50-54yrs' AND tx.gender = 'M', 'PIv36iYFL92',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'F', 'BDinRla76BQ',
	IF(tx.age_group = '55-59yrs' AND tx.gender = 'M', 'SqyjUPzpeA7',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'F', 'xUsD5LKc48C',
	IF(tx.age_group = '60-64yrs' AND tx.gender = 'M', 'A8tEnB77K4R',
	IF(tx.age_group = '65+yrs' AND tx.gender = 'F', 'rYKjhnWcBXR',  
	IF(tx.age_group = '65+yrs' AND tx.gender = 'M', 'Pv5KPmGLJ37', NULL)))))))))))))))))))))))))))))) category_option, tx.organization_unit, @period period, tx.entry_value
FROM (SELECT t.patient_id, gender, age_group, COUNT(t.age_group) entry_value, t.mfl, ou.`organization_unit`
 FROM(
     SELECT p.`Gender`, p.`DOB`, TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) AS age, fi.`siteCode` mfl,
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
	IF(TIMESTAMPDIFF(YEAR,p.`DOB`,@enddate) > 64, '65+yrs', NULL))))))))))))))) age_group,    
     fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date,
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
              JOIN kenyaemr_etl.`etl_default_facility_info` fi
     WHERE fup.visit_date <= DATE(@endDate)
     GROUP BY patient_id
     HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
         (
             ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
               AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
             )
         )
     ) t LEFT JOIN ldwh.`facility_info` ou ON ou.`mfl`=t.mfl
     WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id NOT IN (SELECT vl.patient_id FROM (SELECT fup.patient_id, de.patient_id AS started_on_drugs,
           MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, test_result, NULL))),11) AS last_cd4_result,
	   MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, le.visit_date, NULL))),11) AS last_cd4_date
    FROM kenyaemr_etl.etl_patient_hiv_followup fup
           LEFT JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id=e.patient_id
           LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON fup.patient_id = de.patient_id AND de.program='HIV' AND DATE(date_started) <= DATE(@enddate)
           LEFT JOIN kenyaemr_etl.`etl_laboratory_extract` le ON le.`patient_id`=e.`patient_id`
           LEFT OUTER JOIN
             (SELECT patient_id, COALESCE(DATE(effective_discontinuation_date),visit_date) visit_date,MAX(DATE(effective_discontinuation_date)) AS effective_disc_date FROM kenyaemr_etl.etl_patient_program_discontinuation
              WHERE DATE(visit_date) <= DATE(@enddate) AND program_name='HIV'
              GROUP BY patient_id
             ) d ON d.patient_id = fup.patient_id
    WHERE fup.visit_date <= DATE(@enddate)
    GROUP BY patient_id
    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND DATE(last_cd4_date) BETWEEN DATE(@startDate) AND DATE(@endDate) ) vl)GROUP BY t.gender, t.age_group) tx

-- KP section
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "BckYd9cjMJy" data_element, (CASE t.key_population_type
					WHEN 'Female sex worker' THEN 'gNjREqP1dq8'
					WHEN 'Men who have sex with men' THEN 'G0alyNeHzFt'
					WHEN 'People who inject drugs' THEN 'rQud3arnRmr'
					WHEN 'Transgender' THEN 'ZFiEPANua6x'
					WHEN 'Fisher folk' THEN 'AbrdwgGtlZP'
					WHEN 'Prisoner' THEN 'hF8G1rUSaDu'
					END) category_option, t.`organization_unit`, @period period,
		COUNT(t.key_population_type) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,(CASE key_population_type WHEN 105 THEN 'People who inject drugs'
								WHEN 160578 THEN 'Men who have sex with men'
								WHEN 160579 THEN 'Female sex worker'
								WHEN 165100 THEN 'Transgender'
								WHEN 5622 THEN 'Other'
								WHEN 159674 THEN 'Fisher folk'
								WHEN 162198 THEN 'Truck driver'
								WHEN 160549 THEN 'Adolescent and young girls'
								WHEN 162277 THEN 'Prisoner'
								WHEN 165192 THEN 'Military and other uniformed services' END))),11) key_population_type,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id NOT IN (SELECT vl.patient_id FROM (SELECT fup.patient_id, de.patient_id AS started_on_drugs,
           MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, test_result, NULL))),11) AS last_cd4_result,
	   MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, le.visit_date, NULL))),11) AS last_cd4_date
    FROM kenyaemr_etl.etl_patient_hiv_followup fup
           LEFT JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id=e.patient_id
           LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON fup.patient_id = de.patient_id AND de.program='HIV' AND DATE(date_started) <= DATE(@enddate)
           LEFT JOIN kenyaemr_etl.`etl_laboratory_extract` le ON le.`patient_id`=e.`patient_id`
           LEFT OUTER JOIN
             (SELECT patient_id, COALESCE(DATE(effective_discontinuation_date),visit_date) visit_date,MAX(DATE(effective_discontinuation_date)) AS effective_disc_date FROM kenyaemr_etl.etl_patient_program_discontinuation
              WHERE DATE(visit_date) <= DATE(@enddate) AND program_name='HIV'
              GROUP BY patient_id
             ) d ON d.patient_id = fup.patient_id
    WHERE fup.visit_date <= DATE(@enddate)
    GROUP BY patient_id
    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND DATE(last_cd4_date) BETWEEN DATE(@startDate) AND DATE(@endDate) ) vl)
                     AND t.key_population_type IS NOT NULL GROUP BY t.key_population_type) rtt

-- PG section	
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "BckYd9cjMJy" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id NOT IN (SELECT vl.patient_id FROM (SELECT fup.patient_id, de.patient_id AS started_on_drugs,
           MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, test_result, NULL))),11) AS last_cd4_result,
	   MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, le.visit_date, NULL))),11) AS last_cd4_date
    FROM kenyaemr_etl.etl_patient_hiv_followup fup
           LEFT JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id=e.patient_id
           LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON fup.patient_id = de.patient_id AND de.program='HIV' AND DATE(date_started) <= DATE(@enddate)
           LEFT JOIN kenyaemr_etl.`etl_laboratory_extract` le ON le.`patient_id`=e.`patient_id`
           LEFT OUTER JOIN
             (SELECT patient_id, COALESCE(DATE(effective_discontinuation_date),visit_date) visit_date,MAX(DATE(effective_discontinuation_date)) AS effective_disc_date FROM kenyaemr_etl.etl_patient_program_discontinuation
              WHERE DATE(visit_date) <= DATE(@enddate) AND program_name='HIV'
              GROUP BY patient_id
             ) d ON d.patient_id = fup.patient_id
    WHERE fup.visit_date <= DATE(@enddate)
    GROUP BY patient_id
    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND DATE(last_cd4_date) BETWEEN DATE(@startDate) AND DATE(@endDate) ) vl)
                     AND t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status) rtt

-- BF section	
UNION SELECT rtt.data_element, rtt.category_option, rtt.organization_unit, rtt.period, rtt.value
FROM (SELECT t.patient_id, "BckYd9cjMJy" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date, ou.`organization_unit`,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding,
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
                             JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t WHERE t.patient_id IN (SELECT  e.patient_id
                FROM (
                         SELECT fup_prev_period.patient_id,
                                MAX(fup_prev_period.visit_date) AS prev_period_latest_vis_date,
                                MID(MAX(CONCAT(fup_prev_period.visit_date,fup_prev_period.next_appointment_date)),11) AS prev_period_latest_tca,
                                MAX(d.visit_date) AS date_discontinued,
                                d.patient_id AS disc_patient,
                                fup_reporting_period.first_visit_after_IIT AS first_visit_after_IIT,
                                fup_reporting_period.first_tca_after_IIT AS first_tca_after_IIT
                         FROM kenyaemr_etl.etl_patient_hiv_followup fup_prev_period
                                  JOIN (SELECT fup_reporting_period.patient_id,MIN(fup_reporting_period.visit_date) AS first_visit_after_IIT,MIN(fup_reporting_period.next_appointment_date) AS first_tca_after_IIT FROM kenyaemr_etl.etl_patient_hiv_followup fup_reporting_period WHERE fup_reporting_period.visit_date >= DATE_SUB(DATE(@endDate) , INTERVAL 3 MONTH) GROUP BY fup_reporting_period.patient_id)fup_reporting_period ON fup_reporting_period.patient_id = fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup_prev_period.patient_id
                                  JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup_prev_period.patient_id=e.patient_id
                                  LEFT OUTER JOIN
                              (SELECT patient_id, visit_date FROM kenyaemr_etl.etl_patient_program_discontinuation
                               WHERE DATE(visit_date) <= CURDATE()  AND program_name='HIV'
                               GROUP BY patient_id
                              ) d ON d.patient_id = fup_prev_period.patient_id
                         WHERE fup_prev_period.visit_date < DATE(@startDate)
                         GROUP BY patient_id
                         HAVING (
                                        (((DATE(prev_period_latest_tca) < DATE(@endDate)) AND
                                          (DATE(prev_period_latest_vis_date) < DATE(prev_period_latest_tca)))) AND
                                        ((DATE(fup_reporting_period.first_visit_after_IIT) > DATE(date_discontinued) AND
                                          DATE(fup_reporting_period.first_tca_after_IIT) > DATE(date_discontinued)) OR
                                         disc_patient IS NULL)
                                     AND TIMESTAMPDIFF(DAY, DATE(prev_period_latest_tca),DATE(@startDate)) > 30)
                     )e) AND t.patient_id NOT IN (SELECT vl.patient_id FROM (SELECT fup.patient_id, de.patient_id AS started_on_drugs,
           MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, test_result, NULL))),11) AS last_cd4_result,
	   MID(MAX(CONCAT(le.visit_date, IF(lab_test = 5497, le.visit_date, NULL))),11) AS last_cd4_date
    FROM kenyaemr_etl.etl_patient_hiv_followup fup
           LEFT JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id=e.patient_id
           LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON fup.patient_id = de.patient_id AND de.program='HIV' AND DATE(date_started) <= DATE(@enddate)
           LEFT JOIN kenyaemr_etl.`etl_laboratory_extract` le ON le.`patient_id`=e.`patient_id`
           LEFT OUTER JOIN
             (SELECT patient_id, COALESCE(DATE(effective_discontinuation_date),visit_date) visit_date,MAX(DATE(effective_discontinuation_date)) AS effective_disc_date FROM kenyaemr_etl.etl_patient_program_discontinuation
              WHERE DATE(visit_date) <= DATE(@enddate) AND program_name='HIV'
              GROUP BY patient_id
             ) d ON d.patient_id = fup.patient_id
    WHERE fup.visit_date <= DATE(@enddate)
    GROUP BY patient_id
    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND DATE(last_cd4_date) BETWEEN DATE(@startDate) AND DATE(@endDate) ) vl)
                     AND t.breastfeeding = 'Yes' GROUP BY t.breastfeeding) rtt;