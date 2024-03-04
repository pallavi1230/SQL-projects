select * from product;
select * from application;
select * from product_tecode;
select * from appdoc;
select * from regactiondate;
select * from chemtypeLookup;
select * from doctype_lookup;
select * from reviewclass_lookup;
select * from appdoctype_lookup;

## TASK  - IDENTIFYING APPROVAL TRENDS

#1. Determine the number of drugs approved each year and provide insights into the yearly trends
-- checked the unique values of actiontype
select distinct(actiontype) from regactiondate;
select distinct(actiontype) from appdoc;

-- Since no info is about AP so considered it as "Approved " ,where as TA stands for Tentative Approval. 
-- So below query is considering both the action type,including tentative approval, arranged by year asc. 
with t1 as 
(select year(actiondate) as "Year" from regactiondate )
select Year, count(Year) as "No. of Drugs approved " from t1 where Year is NOT NULL group by Year order by Year asc;

-- another way considering only AP we have:
with t2 as (
select year(actiondate) as "Year" from regactiondate where actiontype = 'AP')
select Year, count(Year) as "No. of Drugs approved " from t2 where Year is NOT NULL group by Year order by Year asc;


# 2. Identify the top three years that got the highest and lowest approvals, in descending and ascending order, respectively.
-- Highest approvals 
with t3 as 
(select year(actiondate) as "Year" from regactiondate  )
select Year, count(Year) as "Highest No. of Drugs approved " from t3 group by Year order by count(Year) desc limit 3;

-- Lowest approvals 
with t4 as 
(select year(actiondate) as "Year" from regactiondate  )
select Year, count(Year) as "Lowest No. of Drugs approved " from t4 where Year is NOT NULL group by Year order by count(Year) asc limit 3;


# 3. Explore approval trends over the years based on sponsors
-- Yearly trend of no. of approvals received arannged in order of year asc . 
with t5 as (
select r.applno , a.sponsorapplicant, r.actiontype, year(r.actiondate) as "Year" from 
regactiondate r join application a on r.ApplNo = a.ApplNo  )
select year , sponsorapplicant as "sponsors" , count(sponsorapplicant) as "approvals received" 
from t5 group by year, sponsorapplicant ;


#4. Rank sponsors based on the total number of approvals they received each year between 1939 and 1960.
with t7 as (
with t6 as (
select r.applno , a.sponsorapplicant, r.actiontype, year(r.actiondate) as "Year" from 
regactiondate r join application a on r.ApplNo = a.ApplNo  )
select year , sponsorapplicant  , count(sponsorapplicant) as "ApprovalsReceived" from t6 
group by year, sponsorapplicant)
select year,sponsorapplicant as 'Sponsors', ApprovalsReceived, dense_rank() over(order by ApprovalsReceived desc) as "Rank"
from t7 where year<=1960 and year>=1939 and year is NOT NULL group by year, sponsorapplicant;



