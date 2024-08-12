SET @startDate = '{startDate}';
SET @endDate = '{endDate}';
SET @period = '{period}';

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "wsQVbENz2sg" data_element,
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
(SELECT t.patient_id
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,IF(stability=1,'Established', IF(stability=2,'Not Established', NULL)))),11) AS establishment,
                           MID(MAX(CONCAT(fup.visit_date,
				IF(differentiated_care=164942,'Standard Care',
				IF(differentiated_care=164943,'Fast Track',
				IF(differentiated_care=164944,'Community ART Distribution - HCW Led',
				IF(differentiated_care=164945,'Community ART Distribution - Peer Led',
				IF(differentiated_care=164946,'Facility ART Distribution Group',NULL))))))),11) AS differentiated_care,
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
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND establishment = 'Established' AND differentiated_care = 'Community ART Distribution - Peer Led' AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t)     
 ) tx GROUP BY tx.gender, tx.age_group

-- KP Section
UNION SELECT "z1Kx5nkupRN" data_element, (CASE t.key_population_type
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
(SELECT t.patient_id
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,IF(stability=1,'Established', IF(stability=2,'Not Established', NULL)))),11) AS establishment,
                           MID(MAX(CONCAT(fup.visit_date,
				IF(differentiated_care=164942,'Standard Care',
				IF(differentiated_care=164943,'Fast Track',
				IF(differentiated_care=164944,'Community ART Distribution - HCW Led',
				IF(differentiated_care=164945,'Community ART Distribution - Peer Led',
				IF(differentiated_care=164946,'Facility ART Distribution Group',NULL))))))),11) AS differentiated_care,
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
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND establishment = 'Established' AND differentiated_care = 'Community ART Distribution - Peer Led' AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t)                                 
                                GROUP BY fup.`patient_id` ) t WHERE t.key_population_type IS NOT NULL GROUP BY t.key_population_type

-- PG Section
UNION SELECT "z1Kx5nkupRN" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value` 
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(pregnancy_status = 1065, 'Yes', IF(pregnancy_status = 1066, 'No', NULL)))),11) AS pregnancy_status, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,IF(stability=1,'Established', IF(stability=2,'Not Established', NULL)))),11) AS establishment,
                           MID(MAX(CONCAT(fup.visit_date,
				IF(differentiated_care=164942,'Standard Care',
				IF(differentiated_care=164943,'Fast Track',
				IF(differentiated_care=164944,'Community ART Distribution - HCW Led',
				IF(differentiated_care=164945,'Community ART Distribution - Peer Led',
				IF(differentiated_care=164946,'Facility ART Distribution Group',NULL))))))),11) AS differentiated_care,
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
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND establishment = 'Established' AND differentiated_care = 'Community ART Distribution - Peer Led' AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t)     
GROUP BY fup.`patient_id`) t WHERE t.pregnancy_status = 'Yes' GROUP BY t.pregnancy_status

-- BF Section
UNION SELECT "z1Kx5nkupRN" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
FROM (SELECT p.patient_id,
MID(MAX(CONCAT(fup.visit_date,IF(breastfeeding = 1065, 'Yes', IF(breastfeeding = 1066, 'No', NULL)))),11) AS breastfeeding, ou.organization_unit
FROM kenyaemr_etl.etl_patient_demographics p 
JOIN kenyaemr_etl.etl_patient_hiv_followup fup ON fup.`patient_id` = p.`patient_id`
JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
WHERE p.`patient_id` IN
(SELECT t.patient_id
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_tca,
                           MID(MAX(CONCAT(fup.visit_date,IF(stability=1,'Established', IF(stability=2,'Not Established', NULL)))),11) AS establishment,
                           MID(MAX(CONCAT(fup.visit_date,
				IF(differentiated_care=164942,'Standard Care',
				IF(differentiated_care=164943,'Fast Track',
				IF(differentiated_care=164944,'Community ART Distribution - HCW Led',
				IF(differentiated_care=164945,'Community ART Distribution - Peer Led',
				IF(differentiated_care=164946,'Facility ART Distribution Group',NULL))))))),11) AS differentiated_care,
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
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') AND establishment = 'Established' AND differentiated_care = 'Community ART Distribution - Peer Led' AND (
                        (
                            ((TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(@endDate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(latest_tca),DATE(CURDATE())) <= 30) AND ((DATE(d.effective_disc_date) > DATE(@endDate) OR DATE(enroll_date) > DATE(d.effective_disc_date)) OR d.effective_disc_date IS NULL))
                              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(latest_tca) >= DATE(date_discontinued) OR disc_patient IS NULL)
                            )
                        )
                    ) t)     
GROUP BY fup.`patient_id`) t WHERE t.breastfeeding = 'Yes' GROUP BY t.breastfeeding;