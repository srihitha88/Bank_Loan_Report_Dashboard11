select * from bank_loan_data;

--Total Loan Applications--

select count(id) as Total_Loan_Applications 
from bank_loan_data;

select count(id) as MTD_Total_Loan_Applications from bank_loan_data
where MONTH(issue_date) = 12 And year(issue_date)=2021;

select count(id) as PMTD_Total_Loan_Applications from bank_loan_data
where MONTH(issue_date) = 11 And year(issue_date)=2021;

--Toatl Funded AMOUNT--

select sum(loan_amount) as Total_Funded_Amount 
from bank_loan_data;

select sum(loan_amount) as MTD_Total_Funded_Amount from bank_loan_data
where MONTH(issue_date) = 12 And year(issue_date)=2021;

select sum(loan_amount) as PMTD_Total_Funded_Amount from bank_loan_data
where MONTH(issue_date) = 11 And year(issue_date)=2021;

--Total Payment Received--

select SUM(Total_payment) as Total_Payment_Received from bank_loan_data;

select SUM(Total_payment) as MTD_Total_Payment_Received from bank_loan_data
where MONTH(issue_date)=12 and year(issue_date)=2021;

select SUM(Total_payment) as PMTD_Total_Payment_Received from bank_loan_data
where MONTH(issue_date)=11 and year(issue_date)=2021;

--Avg Intrest Rate--

select Round(avg(int_rate)*100,2) as Avg_Intrest_Rate 
from bank_loan_data;

select Round(avg(int_rate)*100,2) as MTD_Avg_Intrest_Rate 
from bank_loan_data
where MONTH(issue_date)=12 and YEAR(issue_date)=2021;

select Round(avg(int_rate)*100,2) as PMTD_Avg_Intrest_Rate 
from bank_loan_data
where MONTH(issue_date)=11 and YEAR(issue_date)=2021;

--Average DTI--

select Round(avg(dti)*100,2) as Avg_DTI_Rate 
from bank_loan_data;

select Round(avg(dti)*100,2) as MTD_Avg_DTI_Rate 
from bank_loan_data
where MONTH(issue_date)=12 and YEAR(issue_date)=2021;

select Round(avg(dti)*100,2) as PMTD_Avg_Intrest_Rate 
from bank_loan_data
where MONTH(issue_date)=11 and YEAR(issue_date)=2021;

select distinct loan_status from bank_loan_data;

--Good Loan--

select 
(count(case when loan_status = 'Fully Paid' or loan_status='current' then id end)*100)/
count(id) as good_loan_percentage
from bank_loan_data;

select count(id) as Good_loan_applications
from bank_loan_data
where loan_status='Fully Paid' or loan_status='Current'

select sum(loan_amount) as Good_loan_funded_amount
from bank_loan_data
where loan_status='Fully Paid' or loan_status='Current'

select sum(total_payment) as Good_loan_total_amount_received
from bank_loan_data
where loan_status='Fully paid' or loan_status='Current';


--Bad Loan--

select 
(count(case when loan_status = 'Charged off' then id end)*100.0)/
count(id) as Bad_loan_percentage
from bank_loan_data;

select count(id) as Bad_loan_applications
from bank_loan_data
where loan_status='Charged off';

select sum(loan_amount) as Bad_loan_funded_amount
from bank_loan_data
where loan_status='Charged off'

select sum(total_payment) as Bad_loan_total_amount_received
from bank_loan_data
where loan_status='Charged off';

--Loan Status Grid view--
select 
loan_status,
count(id) as Total_loan_applications,
sum(total_payment) as Total_amount_received,
sum(loan_amount) as Total_amount_funded,
Round(avg(int_rate)*100,2) as Average_intrest_rate,
Round(avg(dti*100),2) as average_dti_rate
from bank_loan_data
group by
loan_status;


select 
loan_status,
sum(total_payment) as MTD_Total_amount_received,
sum(loan_amount) as MTD_Total_loan_amount
from bank_loan_data
where MONTH(issue_date)=12 and year(issue_date)=2021
group by loan_status;

--Monthly Trends by issue date--

select 
MONTH(issue_date) as month_number,
DATENAME(month,issue_date) as Month_Name,
count(id) as Total_loan_applications,
sum(loan_amount) as Total_Funded_amount,
sum(total_payment) as Total_Received_amount
from bank_loan_data
group by MONTH(issue_date),DATENAME(month,issue_date)
order by MONTH(issue_date),DATENAME(month,issue_date) ;

--Regional Analysis by state--

select 
address_state,
count(id) as Total_loan_applications,
sum(loan_amount) as Total_Funded_amount,
sum(total_payment) as Total_Received_amount
from bank_loan_data
group by address_state
order by count(id) desc;

--Loan Term analysis--

select 
term as loan_term,
count(id) as Total_loan_applications,
sum(loan_amount) as Total_Funded_amount,
sum(total_payment) as Total_Received_amount
from bank_loan_data
group by term
order by count(id) desc;

--Employee length Analysis--

select 
emp_length,
count(id) as Total_loan_Applications,
sum(loan_amount) as Total_Funded_amount,
sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by emp_length
order by emp_length ;

--Loan Purpose Breakdown Analysis--

select
purpose,
count(id) as Total_loan_Applications,
sum(loan_amount) as Total_Funded_amount,
sum(total_payment) as Total_Received_Amount,
sum(loan_amount)-sum(total_payment) as Difference_blw
from bank_loan_data
group by purpose
order by count(id) desc;

--Home Ownership Analysis--

select
home_ownership,
count(id) as Total_loan_Applications,
sum(loan_amount) as Total_Funded_amount,
sum(total_payment) as Total_Received_Amount
from bank_loan_data
where grade='A'
group by home_ownership
order by count(id) desc;


