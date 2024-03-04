
## Task 2: Segmentation Analysis Based on Drug MarketingStatus
select * from product;
select distinct(ProductMktStatus) from product;

## 1.  Group products based on MarketingStatus. Provide meaningful insights into the segmentation patterns.
-- considering the drugname, here is the list of the products with total count and marketing status. 
-- Drugs that are are high in total, have marketing status either 1,3 or 4 
select ProductMktStatus, drugname , count(drugname) as "Total Products" from product 
group by ProductMktStatus, drugname order by count(drugname) desc ;

## Grouping total no. of products as per the Product marketing status . Higher no. of products 
## have 1 or 3 as their maket status. status 2 signifies least no. of listed products.
select ProductMktStatus, count(ProductMktStatus)  from product group by ProductMktStatus 
order by ProductMktStatus asc ;

 
 ## 2. Calculate the total number of applications for each MarketingStatus year-wise after the year 2010
with t1 as (
select r.applno , year(r.actiondate) as "Year" ,p.ProductMktStatus from product p join regactiondate r
on r.applno = p.applno ) select Year,ProductMktStatus as "Product Market status" ,
count(ProductMktStatus) as 'No. of Applications' from t1 where Year>2010 
group by Year , ProductMktStatus order by Year asc;


## 3.  Identify the top MarketingStatus with the maximum number of applications and analyze its trend over time.
with t2 as (
select r.applno , year(r.actiondate) as "Year" ,p.ProductMktStatus from product p join regactiondate r
on r.applno = p.applno ) select Year,ProductMktStatus as "Product Market status" ,
count(ProductMktStatus) as 'No. of Applications' from t2 group by Year, ProductMktStatus order by 
count(ProductMktStatus) desc;

-- The top marketing status is 1,3 with maximum no. of applications, witnessed between 1997-2016, with 2002 reciving hightest no. of application.

