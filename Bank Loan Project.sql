use bank_loan;
select * from bank_loan;
truncate bank_loan;
DESCRIBE bank_loan;
LOAD DATA INFILE 'C:/Only For me/MY/Data Analytics/Projects/Mysql/Bank Loan/financial_loan.csv'
INTO TABLE bank_loan
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
IGNORE 1 LINES;

#Total Applications
SELECT COUNT(ID) AS Total_Applications FROM bank_loan;

SELECT COUNT(ID) AS MTD_Total_Applications
FROM bank_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT COUNT(ID) AS PMTD_Total_Applications
FROM bank_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

#loan Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan;

SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM bank_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM bank_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

#Total Payment Receive
SELECT SUM(total_payment) AS Total_Amount_Received FROM bank_loan;

SELECT SUM(total_payment) AS MTD_Total_Amount_Received FROM bank_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT SUM(total_payment) AS PMTD_Total_Amount_Received FROM bank_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

#Average Interest Rate
SELECT round(avg(int_rate),4)* 100 AS Avg_Interest_Rate FROM bank_loan;

SELECT round(avg(int_rate),4)* 100 AS MTD_Avg_Interest_Rate FROM bank_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT round(avg(int_rate),4)* 100 AS PMTD_Avg_Interest_Rate FROM bank_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

#Average DTI

SELECT ROUND(AVG(dti),4)*100 AS Avg_Dti FROM bank_loan;

SELECT ROUND(AVG(dti),4)*100 AS MTD_Avg_Dti FROM bank_loan
WHERE MONTH(issue_date)= 12 AND YEAR(issue_date)= 2021;

SELECT ROUND(AVG(dti),4)*100 AS PMTD_Avg_Dti FROM bank_loan
WHERE MONTH(issue_date)= 11 AND YEAR(issue_date)= 2021;

#Good Loan Percentage
SELECT
(COUNT(CASE WHEN loan_status ="Fully Paid" OR loan_status ="Current" THEN id END)*100)
/ COUNT(id) AS Good_Loan_Percentage
FROM bank_loan;

#Good Loan Application
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan
WHERE Loan_status ="Fully Paid" OR loan_status ="Current";

#Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROM bank_loan
WHERE Loan_status ="Fully Paid" OR loan_status ="Current";

#Good Loan Received Amount
SELECT SUM(total_payment) AS Good_Loan_Amount_REceived FROM bank_loan
WHERE Loan_status ="Fully Paid" OR loan_status ="Current";

#Bad Loan Percentage
SELECT
(COUNT(CASE WHEN loan_status ="Charged Off" THEN id END)*100)
/ COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan;

#Bad Loan Application
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan
WHERE loan_status ="Charged Off";

#Good Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount FROM bank_loan
WHERE loan_status ="Charged Off";

#Good Loan Received Amount
SELECT SUM(total_payment) AS Bad_Loan_Amount_REceived FROM bank_loan
WHERE loan_status ="Charged Off";

# Loan Status
SELECT loan_status,
COUNT(id) AS Total_Loan_Applications,
SUM(total_payment) AS Total_Amount_Recevied,
SUM(loan_amount) As Total_Funded_Amount,
AVG(int_rate* 100) AS Interest_rate,
AVG(dti*100) AS DTI
FROM bank_loan
GROUP BY loan_status;

SELECT loan_status,
SUM(total_payment) AS MTD_Total_Amount_Recevied,
SUM(loan_amount) As MTD_Total_Funded_Amount
FROM bank_loan
WHERE MONTH(issue_date) = 12
GROUP BY loan_status;

#Monthly Trend
SELECT 
MONTH(issue_date) as Month_number,
MONTHNAME(issue_date) as Month_Name,
COUNT(id) AS Total_Loan_Applications,
SUM(total_payment) AS Total_Amount_Recevied,
SUM(loan_amount) As Total_Funded_Amount
FROM bank_loan
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);

#Regions
SELECT 
address_state,
COUNT(id) AS Total_Loan_Applications,
SUM(total_payment) AS Total_Amount_Recevied,
SUM(loan_amount) As Total_Funded_Amount
FROM bank_loan
GROUP BY address_state
ORDER BY COUNT(id) DESC;

#Term
SELECT 
term,
COUNT(id) AS Total_Loan_Applications,
SUM(total_payment) AS Total_Amount_Recevied,
SUM(loan_amount) As Total_Funded_Amount
FROM bank_loan
GROUP BY term
ORDER BY term;

#Employee Length
SELECT 
emp_length,
COUNT(id) AS Total_Loan_Applications,
SUM(total_payment) AS Total_Amount_Recevied,
SUM(loan_amount) As Total_Funded_Amount
FROM bank_loan
GROUP BY emp_length
ORDER BY COUNT(id) DESC;

#Purpose
SELECT 
purpose,
COUNT(id) AS Total_Loan_Applications,
SUM(total_payment) AS Total_Amount_Recevied,
SUM(loan_amount) As Total_Funded_Amount
FROM bank_loan
GROUP BY purpose
ORDER BY COUNT(id) DESC;

# Home Owenership
SELECT 
home_ownership,
COUNT(id) AS Total_Loan_Applications,
SUM(total_payment) AS Total_Amount_Recevied,
SUM(loan_amount) As Total_Funded_Amount
FROM bank_loan
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;