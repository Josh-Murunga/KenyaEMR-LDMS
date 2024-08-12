SET @startDate = '{startDate}';
SET @endDate = '{endDate}';
SET @period = '{period}';

-- GP section
INSERT INTO ldwh.dataset_values
SELECT "vDGaxAplbFy" data_element,
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
FROM (SELECT t.patient_id, "OqXX9ahJVq0" data_element, (CASE t.key_population_type
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
FROM (SELECT t.patient_id, "OqXX9ahJVq0" data_element, IF(t.pregnancy_status = 'Yes', 'um52UVweKbK', '')category_option, t.`organization_unit`, @period period, COUNT(t.pregnancy_status) `value`
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
FROM (SELECT t.patient_id, "OqXX9ahJVq0" data_element, IF(t.breastfeeding = 'Yes', 'BSjw9WXURmv', '')category_option, t.`organization_unit`, @period period, COUNT(t.breastfeeding) `value`
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