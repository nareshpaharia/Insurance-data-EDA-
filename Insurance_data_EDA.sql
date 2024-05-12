SELECT 
    *
FROM
    insurance1.insurance_;

-- --------------------------------------------
UPDATE insurance1.insurance_ 
SET 
    Opened = DATE_FORMAT(Opened, '%Y-%m-%d');
-- -------------------------------------------

SELECT 
    COUNT(*) total_record
FROM
    insurance1.insurance_;

/* Q1: What are the unique coverage types and their frequencies?*/

SELECT 
    Coverage, COUNT(*) AS frequency
FROM
    insurance1.insurance_
GROUP BY Coverage;

/* Q2: What are the reasons for filing claims and their frequencies?*/
SELECT 
    Reason, COUNT(*) frequency
FROM
    insurance1.insurance_
GROUP BY Reason;

/*Q3: What are the different dispositions and conclusions reached for claims?*/

SELECT 
    Disposition, COUNT(*) AS Disposition_count
FROM
    insurance1.insurance_
GROUP BY Disposition;
-- --
SELECT 
    Conclusion, COUNT(*) AS Conclusion_count
FROM
    insurance1.insurance_
GROUP BY Conclusion;

/*Q4: What is the distribution of recovery amounts?*/

SELECT 
    MIN(Recovery) AS min_recovery,
    ROUND(MAX(Recovery), 0) AS max_recovery,
    ROUND(AVG(Recovery), 0) AS avg_recovery
FROM
    insurance1.insurance_;

/*Q5: What are the different statuses of claims and their frequencies?*/
SELECT 
    Status, COUNT(*) AS frequency
FROM
    insurance1.insurance_
GROUP BY Status;

/*Q6: Are there any missing values in Company column?*/

SELECT 
    'Company' AS company_name,
    COUNT(*) - COUNT(company) AS missing_count
FROM
    insurance1.insurance_;

/*Q7: How many claims were opened and
      closed each month over the past year?*/
SELECT 
    YEAR(Opened) AS year,
    MONTH(Opened) AS month,
    YEAR(Closed) AS year2,
    MONTH(Closed) AS month2,
    COUNT(*) AS opened_claims_count,
    COUNT(*) AS close_claims_count
FROM
    insurance1.insurance_
GROUP BY YEAR(Opened) , MONTH(Opened) , YEAR(Closed) , MONTH(Closed);

/*Q8: What is the average 
      duration (in days) it takes to process a claim?*/
SELECT 
    AVG(DATEDIFF(Closed, Opened)) AS avg_claim_duration_days
FROM
    insurance1.insurance_
WHERE
    Closed IS NOT NULL;

/*Q9: What are the 3 top reasons for 
  filing claims, and how does their frequency vary over time?*/
  
SELECT 
    Reason, COUNT(*) frequency
FROM
    insurance1.insurance_
GROUP BY Reason
ORDER BY frequency DESC
LIMIT 3;

/*Q10: What is the total amount 
      recovered for each month over the past year?*/
     
SELECT 
    YEAR(Opened) AS year,
    MONTH(Opened) AS month,
    ROUND(SUM(Recovery), 0) AS total_count_recovery
FROM
    insurance1.insurance_
GROUP BY YEAR(Opened) , MONTH(Opened);
       
/*Q11: What is the distribution of claim 
      statuses (open, closed, pending) over time?*/
SELECT 
    YEAR(Opened) AS year,
    MONTH(Opened) AS month,
    Status,
    COUNT(*) AS status_count
FROM
    insurance1.insurance_
GROUP BY YEAR(Opened) , MONTH(Opened) , Status;

/*Q12: What percentage of claims 
     opened in each month are closed by the end of the year?*/

SELECT 
    YEAR(Opened) AS year,
    MONTH(Opened) AS month,
    (COUNT(CASE
        WHEN Closed IS NOT NULL THEN 1
    END) / COUNT(*)) * 100 AS close_rate
FROM
    insurance1.insurance_
GROUP BY YEAR(Opened) , MONTH(Opened);
      
/*Q13: What is the Claims Processing Time*/
SELECT 
    AVG(DATEDIFF(Closed, Opened)) AS avg_processing_time
FROM
    insurance1.insurance_;

-- --------------------------------END----------------------------------------
-- ---------------------------------------------------------------------------



      