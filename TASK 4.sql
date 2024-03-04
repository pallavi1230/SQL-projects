
## Task 4: Exploring Therapeutic Classes and Approval Trends
select * from product_tecode;
select * from product;
-- 1. Analyze drug approvals based on therapeutic evaluation code (TE_Code).
select tecode as TE_Code, count(tecode) as "Drugs Approved" from 
product_tecode group by tecode order by count(tecode) desc;

-- 2. Determine the therapeutic evaluation code (TE_Code) with the highest number of Approvals in each year.

-- TE_code with highest no. of approvals recieved each year arranged in ascending order of year 
-- from 1941 to 2016
with t2 as(
with t1 as(
select r.ApplNo ,year(r.actiondate) as "Year" , pt.tecode from regactiondate r join 
product_tecode pt on r.applno = pt.applno )
select Year, tecode, count(tecode) as "Total_Approvals", rank() over( partition by year order by 
count(tecode) desc) as "Yearly_Rank" from t1 group by year, tecode)
select year, tecode, total_approvals from t2 where yearly_rank=1;


--  TE_code with highest no. of approvals  each year arranged in order  of 
-- highest no. approvals received alongwith the TE_Code for that year .
with t2 as(
with t1 as(
select r.ApplNo ,year(r.actiondate) as "Year" , pt.tecode from regactiondate r join 
product_tecode pt on r.applno = pt.applno )
select Year, tecode, count(tecode) as "Total_Approvals", rank() over( partition by year order by 
count(tecode) desc) as "Yearly_Rank" from t1 group by year, tecode)
select year, tecode, total_approvals from t2 where yearly_rank=1 order by total_approvals desc;