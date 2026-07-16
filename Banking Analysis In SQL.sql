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