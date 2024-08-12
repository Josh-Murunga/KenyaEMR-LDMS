SET @startDate = '{startDate}';
SET @endDate = '{endDate}';
SET @period = '{period}';

INSERT INTO ldwh.dataset_values
SELECT "otYr6t1yV4L" data_element, (CASE ret.patient_status
					WHEN 'Active' THEN 'oaTXCY2xOAm'
					WHEN 'Lost to followup' THEN 'fT6VSAk4p7e'
					WHEN 'Undocumented IIT' THEN 'fT6VSAk4p7e'
					WHEN 'Died' THEN 'TnKln1XN4bD'
					WHEN 'Transfer out' THEN 'dyXshM2oQKq'
					WHEN 'Stopped Treatment' THEN 'upXRhvHckxm'
					WHEN 'Transfer In' THEN 'r7v6xkBPiHl'
					END) category_option, ret.organization_unit, @period period, COUNT(ret.patient_status) `value`
FROM
(SELECT e.patient_id,
 e.date_started
 FROM
    (SELECT dr.patient_id, MIN(dr.date_started) AS date_started
    FROM kenyaemr_etl.etl_drug_event dr
     JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=dr.patient_id AND p.voided = 0
     WHERE dr.program = 'HIV'
    GROUP BY dr.patient_id) e
   INNER JOIN kenyaemr_etl.etl_hiv_enrollment enr ON enr.patient_id=e.patient_id
 WHERE DATE(e.date_started) BETWEEN DATE_SUB(DATE(@startDate) , INTERVAL 24 MONTH) AND DATE_SUB(DATE(@endDate) , INTERVAL 24 MONTH)
  GROUP BY e.patient_id) a
  
  INNER JOIN (SELECT t.patient_id, t.organization_unit,
IF(
        (
            ((TIMESTAMPDIFF(DAY,DATE(t.next_appointment_date),DATE(@enddate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(t.next_appointment_date),DATE(CURDATE())) <= 30) AND ((DATE(t.effective_disc_date) > DATE(@enddate) OR DATE(enroll_date) > DATE(t.effective_disc_date)) OR t.effective_disc_date IS NULL))
              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(t.next_appointment_date) >= DATE(date_discontinued) OR disc_patient IS NULL)
             ) AND (t.patient_type=160563)
         ,'Transfer In',
         IF(
        (
            ((TIMESTAMPDIFF(DAY,DATE(t.next_appointment_date),DATE(@enddate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(t.next_appointment_date),DATE(CURDATE())) <= 30) AND ((DATE(t.effective_disc_date) > DATE(@enddate) OR DATE(enroll_date) > DATE(t.effective_disc_date)) OR t.effective_disc_date IS NULL))
              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(t.next_appointment_date) >= DATE(date_discontinued) OR disc_patient IS NULL)
             ), 'Active',
         IF(t.discontinuation_reason=159492, 'Transfer out',
         IF(t.discontinuation_reason=5240, 'Lost to followup',
         IF(t.discontinuation_reason=160034, 'Died', 
         IF(t.discontinuation_reason=819, "Cannot afford Treatment",
         IF(t.discontinuation_reason=5622, "Other",
         IF(t.discontinuation_reason=1067, "Unknown",
         IF(t.discontinuation_reason=164349, "Stopped Treatment", 'Undocumented IIT'))))))))) AS patient_status
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS next_appointment_date,
                           d.patient_id AS disc_patient,
                           d.effective_disc_date AS effective_disc_date,
                           d.discontinuation_reason,
                           MAX(d.visit_date) AS date_discontinued,
                           de.patient_id AS started_on_drugs,
                           e.patient_type patient_type,
                           ou.organization_unit
                    FROM kenyaemr_etl.etl_patient_hiv_followup fup
                           JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup.patient_id
                           JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id=e.patient_id
                           JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                           LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program='HIV' AND DATE(date_started) <= DATE(@endDate)
                           LEFT OUTER JOIN
                             (SELECT patient_id, COALESCE(DATE(effective_discontinuation_date),visit_date) visit_date,MAX(DATE(effective_discontinuation_date)) AS effective_disc_date, discontinuation_reason FROM kenyaemr_etl.etl_patient_program_discontinuation
                              WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                              GROUP BY patient_id
                             ) d ON d.patient_id = fup.patient_id
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') 
                    ) t) ret ON a.patient_id = ret.patient_id GROUP BY ret.patient_status
        
UNION SELECT "otYr6t1yV4L", "to3IAhcFxtd", ret.organization_unit, @period period, COUNT(*) `value` FROM
(SELECT e.patient_id,
 e.date_started
 FROM
    (SELECT dr.patient_id, MIN(dr.date_started) AS date_started
    FROM kenyaemr_etl.etl_drug_event dr
     JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=dr.patient_id AND p.voided = 0
     WHERE dr.program = 'HIV'
    GROUP BY dr.patient_id) e
   INNER JOIN kenyaemr_etl.etl_hiv_enrollment enr ON enr.patient_id=e.patient_id
 WHERE DATE(e.date_started) BETWEEN DATE_SUB(DATE(@startDate) , INTERVAL 24 MONTH) AND DATE_SUB(DATE(@endDate) , INTERVAL 24 MONTH)
  GROUP BY e.patient_id) a
  
  INNER JOIN (SELECT t.patient_id, t.organization_unit,
IF(
        (
            ((TIMESTAMPDIFF(DAY,DATE(t.next_appointment_date),DATE(@enddate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(t.next_appointment_date),DATE(CURDATE())) <= 30) AND ((DATE(t.effective_disc_date) > DATE(@enddate) OR DATE(enroll_date) > DATE(t.effective_disc_date)) OR t.effective_disc_date IS NULL))
              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(t.next_appointment_date) >= DATE(date_discontinued) OR disc_patient IS NULL)
             ) AND (t.patient_type=160563)
         ,'Transfer In',
         IF(
        (
            ((TIMESTAMPDIFF(DAY,DATE(t.next_appointment_date),DATE(@enddate)) <= 30 OR TIMESTAMPDIFF(DAY,DATE(t.next_appointment_date),DATE(CURDATE())) <= 30) AND ((DATE(t.effective_disc_date) > DATE(@enddate) OR DATE(enroll_date) > DATE(t.effective_disc_date)) OR t.effective_disc_date IS NULL))
              AND (DATE(latest_vis_date) >= DATE(date_discontinued) OR DATE(t.next_appointment_date) >= DATE(date_discontinued) OR disc_patient IS NULL)
             ), 'Active',
         IF(t.discontinuation_reason=159492, 'Transfer out',
         IF(t.discontinuation_reason=5240, 'Lost to followup',
         IF(t.discontinuation_reason=160034, 'Died', 
         IF(t.discontinuation_reason=819, "Cannot afford Treatment",
         IF(t.discontinuation_reason=5622, "Other",
         IF(t.discontinuation_reason=1067, "Unknown",
         IF(t.discontinuation_reason=164349, "Stopped Treatment", 'Undocumented IIT'))))))))) AS patient_status
                FROM(
                    SELECT fup.visit_date,fup.patient_id, MAX(e.visit_date) AS enroll_date,
                           GREATEST(MAX(e.visit_date), IFNULL(MAX(DATE(e.transfer_in_date)),'0000-00-00')) AS latest_enrolment_date,
                           GREATEST(MAX(fup.visit_date), IFNULL(MAX(d.visit_date),'0000-00-00')) AS latest_vis_date,
                           GREATEST(MID(MAX(CONCAT(fup.visit_date,fup.next_appointment_date)),11), IFNULL(MAX(d.visit_date),'0000-00-00')) AS next_appointment_date,
                           d.patient_id AS disc_patient,
                           d.effective_disc_date AS effective_disc_date,
                           d.discontinuation_reason,
                           MAX(d.visit_date) AS date_discontinued,
                           de.patient_id AS started_on_drugs,
                           e.patient_type patient_type,
                           ou.organization_unit
                    FROM kenyaemr_etl.etl_patient_hiv_followup fup
                           JOIN kenyaemr_etl.etl_patient_demographics p ON p.patient_id=fup.patient_id
                           JOIN kenyaemr_etl.etl_hiv_enrollment e ON fup.patient_id=e.patient_id
                           JOIN kenyaemr_etl.`etl_default_facility_info` fi LEFT JOIN ldwh.`facility_info` ou ON fi.`siteCode`=ou.`mfl`
                           LEFT OUTER JOIN kenyaemr_etl.etl_drug_event de ON e.patient_id = de.patient_id AND de.program='HIV' AND DATE(date_started) <= DATE(@endDate)
                           LEFT OUTER JOIN
                             (SELECT patient_id, COALESCE(DATE(effective_discontinuation_date),visit_date) visit_date,MAX(DATE(effective_discontinuation_date)) AS effective_disc_date, discontinuation_reason FROM kenyaemr_etl.etl_patient_program_discontinuation
                              WHERE DATE(visit_date) <= DATE(@endDate) AND program_name='HIV'
                              GROUP BY patient_id
                             ) d ON d.patient_id = fup.patient_id
                    WHERE fup.visit_date <= DATE(@endDate)
                    GROUP BY patient_id
                    HAVING (started_on_drugs IS NOT NULL AND started_on_drugs <> '') 
                    ) t) ret ON a.patient_id = ret.patient_id;