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

select * from bank_analysis
where Bank_Name = 'SBI';

select Customer_Name,
		Account_Type,
        Transaction_Amount,
        Transaction_Type
from bank_analysis
where Transaction_Type = 'UPI' and Account_Type = 'Current';

select Customer_Name,
		Account_Type,
        Transaction_Amount,
        Transaction_Type,
        round(sum(Transaction_Amount) over(order by customer_name),2)as runnig_amount
from bank_analysis
where Transaction_Type = 'NEFT' and Account_Type = 'Fixed Deposit';

select Bank_Name,sum(Transaction_Amount)
from bank_analysis
where Transaction_Amount = (select max(Transaction_Amount)from bank_analysis)
group by Bank_Name;

select Bank_Name,round(sum(Transaction_Amount),2)as Max_transaction
from bank_analysis
group by Bank_Name
order by Max_transaction desc
limit 2;

select Customer_Name , round(sum(Transaction_Amount),2)as total_transaction , count(*)as transaction_count , sum(loan_amount)as total_loan_amount
from bank_analysis
group by customer_name
order by total_transaction desc
limit 10;

select loan_type , count(*)as count_loan_type
from bank_analysis
group by loan_type 
order by count_loan_type desc
limit 2;

select loan_type,avg(loan_amount)as avg_loan_amount
from bank_analysis
group by loan_type;

select bank_name,round(sum(transaction_amount),2)total_transaction,
rank() over(order by sum(transaction_amount) desc)as Rank_t
from bank_analysis
group by bank_name;

select customer_name,Account_Type,Transaction_Date,Transaction_Amount,
		round(sum(Transaction_Amount) over(order by Transaction_Date),2)as runnig_transaction
from bank_analysis;

select Occupation,avg(transaction_amount)as avg_transaction
from bank_analysis
group by Occupation
order by avg_transaction desc
limit 5;

select city , max(credit_score)as max_score
from bank_analysis
group by city;

SELECT Region,
       Bank_Name,
       Total_Transaction
FROM
(
    SELECT Region,
           Bank_Name,
           SUM(Transaction_Amount) AS Total_Transaction,
           DENSE_RANK() OVER (
               PARTITION BY Region
               ORDER BY SUM(Transaction_Amount) DESC
           ) AS Rank_No
    FROM bank_analysis
    GROUP BY Region, Bank_Name
) AS ranked_banks
WHERE Rank_No = 1;

select month(Transaction_Date)as dates,sum(Transaction_Amount)as trend
from bank_analysis
group by month(Transaction_Date)
order by dates;