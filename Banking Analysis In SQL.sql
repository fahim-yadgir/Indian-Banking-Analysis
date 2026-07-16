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
(select Customer_Name,Transaction_Type,sum(Transaction_Amount) as total_Transaction_Amount,
		dense_rank() over(partition by Transaction_Type order by sum(Transaction_Amount) desc)as top_3
        from bank_analysis
        group by Transaction_Type,Customer_Name
        )as segment
where top_3 <= 3
order by Transaction_Type,top_3;
