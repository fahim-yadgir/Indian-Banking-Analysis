create database Bank;
use Bank;

select * from bank_analysis
where Fraud_Flag = 'Yes';

select count(case when Fraud_Flag='Yes' then 1 end) Frause_flag
from bank_analysis;

select distinct(Bank_Name)
from bank_analysis;

select count(*)as total_number_of_customer
from bank_analysis;

select * from bank_analysis
where region = 'South'
order by Transaction_Amount desc;

select avg(Annual_Income_INR )from 
bank_analysis;

SET SQL_SAFE_UPDATES = 0;

update bank_analysis
set
Transaction_Date = str_to_date(Transaction_Date,'%d-%m-%Y');

select Customer_Name,Bank_Name,Transaction_Date,Transaction_Amount,
round(sum(Transaction_Amount) over (order by Transaction_Date),2)as runnig_sum
from bank_analysis
where Transaction_Date between '2022-01-01' and '2022-12-31';

select * from
(select Customer_Name,Transaction_Type,round(sum(Transaction_Amount),2) as total_Transaction_Amount,
		dense_rank() over(partition by Transaction_Type order by sum(Transaction_Amount) desc)as top_3
        from bank_analysis
        group by Transaction_Type,Customer_Name
        )as segment
where top_3 <= 3
order by Transaction_Type,top_3;

select * from bank_analysis
where Loan_Status = 'Approved';

select round(sum(Transaction_Amount),2)as via_UPI
from bank_analysis
where Transaction_Type = 'UPI';

select min(Credit_Score)as min_Credit_Score , max(Credit_Score)as max_Credit_Score
from bank_analysis;

select customer_name,Transaction_Amount,Transaction_Type,age
from bank_analysis
where age > 60;

select transaction_amount,customer_name
from bank_analysis
where Transaction_Date BETWEEN '2024-01-01' AND '2024-12-31';

select Region,round(sum(Transaction_Amount),2)as Total_Transaction_Amount
from bank_analysis
group by region;

select bank_name,count(Transaction_ID)as total_Transaction
from bank_analysis
group by bank_name
order by total_Transaction desc;

select Branch,sum(Transaction_Amount)as Transaction_Amount
from bank_analysis
group by branch
having sum(Transaction_Amount) >=5000000;

select Loan_Type,Loan_Status,count(*)as total_count
from bank_analysis
where Loan_Type is not null 
group by Loan_Type,Loan_Status
order by Loan_Type,loan_status;

select region ,round(avg(loan_amount),2)as avg_loan_amount
from bank_analysis
where Loan_Status = 'Approved'
group by region;

select age,
count(case
when age < 25 then "Adult"
when age between 25 and 40 then "Men"
when age between 40 and 60 then "Senior"
when age > 60 then "senior_citizon" end)as band
from bank_analysis
group by age;

select * from
(select  Region,
count(Transaction_Type)as max_count
from bank_analysis
group by region)as segment
order by max_count desc;

select customer_id,count(distinct loan_type)as more_than_1
from bank_analysis
group by customer_id
having count(distinct loan_type) >1;