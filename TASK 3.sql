
## Task 3: Analyzing Products
select * from product;

-- 1. Categorize Products by dosage form and analyze their distribution.
-- Distribution as per Drugname and Dosage 
select Drugname , Dosage, count(Drugname) as "Total No. of Products" from product 
group by Drugname,dosage order by count(Drugname) desc;

-- 2. Calculate the total number of approvals for each dosage - form and identify the most successful forms.
select  Form, Dosage, count(Form) as "Total no. of Approvals" from product group by form,dosage 
order by count(Form) desc;
-- Most Successful form were found to be Oral Tablets,Capsules and Injections in various forms.


-- 3. Investigate yearly trends related to successful forms. 
with t1 as (
select p.Form, year(r.actiondate) as "Year" from product p join regactiondate r
on r.applno = p.applno ) select Year, Form ,count(Form) as "Total" 
from t1 group by Year ,Form  order by  count(Form) desc ;

