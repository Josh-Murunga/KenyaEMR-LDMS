SET @startDate = '{startDate}';
SET @endDate = '{endDate}';
SET @period = '{period}';

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "f3OhTfbwyjm" data_element,
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
                                )net)
AND p.`patient_id` IN
(SELECT vl.patient_id FROM (SELECT fup.patient_id, de.patient_id AS started_on_drugs,
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
                                   ) tx GROUP BY tx.gender, tx.age_group

-- KP Section
UNION SELECT "IQUBgc07Yt5" data_element, (CASE t.key_population_type
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
                                )net)
AND p.`patient_id` IN
(SELECT vl.patient_id FROM (SELECT fup.patient_id, de.patient_id AS started_on_drugs,
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
                                         
                                GROUP BY fup.`patient_id` ) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type


-- PG Section
UNION SELECT "IQUBgc07Yt5" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value` 
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
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
                                )net)
AND p.`patient_id` IN
(SELECT vl.patient_id FROM (SELECT fup.patient_id, de.patient_id AS started_on_drugs,
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
     
GROUP BY fup.`patient_id`) t WHERE t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status


-- BF Section
UNION SELECT "IQUBgc07Yt5" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
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
                                )net)
AND p.`patient_id` IN
(SELECT vl.patient_id FROM (SELECT fup.patient_id, de.patient_id AS started_on_drugs,
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
     
GROUP BY fup.`patient_id`) t WHERE t.breastfeeding = 'Yes' GROUP BY t.breastfeeding;