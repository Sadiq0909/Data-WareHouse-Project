-- All countries our customer come from
select distinct country 
from gold.dim_customers_copy ;


-- All Categories and subcategories of the products
select distinct category , subcategory , product_name
from gold.dim_products_copy
order by 1 ,2, 3 ;


-- Date of first and last order and How many years of sales is available
select 
	MIN(order_date) first_order_date , 
	MAX(order_date) last_order_date , 
	DATEDIFF(year , min(order_date) , max(order_date)) order_range_years
from gold.fact_sales_copy


-- Youngest and Oldest Customer
select 
	DATEDIFF(year , max(birthdate) , getDate()) youngest , 
	DATEDIFF(year , min(birthdate) , getDate()) oldest
from gold.dim_customers_copy

-- Find Total Sales
select 
	SUM(sales_amount) total_amount
from gold.fact_sales_copy


-- Find how many items are sold
select 
	SUM(quantity) total_items_sold
from gold.fact_sales_copy ;


-- Find average selling price
select 
	AVG(price) average_price
from gold.fact_sales_copy ; 


-- Find total numbers of orders
select 
	COUNT(Distinct order_number) total_orders
from gold.fact_sales_copy ;

-- Find total numbers of customers
select 
	COUNT(distinct customer_key) total_customers
from gold.dim_customers_copy ;


-- Find total number of products
select 
	COUNT(distinct product_key) total_products
from gold.dim_products_copy ;


-- Find total number of customers that have placed a order
select
	COUNT(distinct customer_key) total_cust_placed_order
from gold.fact_sales_copy


select 'Total Sales' as measure_name , SUM(sales_amount) from gold.fact_sales_copy 
UNION ALL
select 'Total Quantity' as measure_name , SUM(quantity) from gold.fact_sales_copy 
UNION ALL
select 'Average price' as measure_name , AVG(price) from gold.fact_sales_copy 
UNION ALL
select 'Total Orders' as measure_name , COUNT(Distinct order_number) from gold.fact_sales_copy 
UNION ALL
select 'Total Customers' as measure_name , COUNT(distinct customer_key) from gold.dim_customers_copy  
UNION ALL
select 'Total Products' as measure_name , COUNT(distinct product_key) from gold.dim_products_copy  ;  



-- Find total number of customers by country
select country , COUNT(customer_key) total_customers
from gold.dim_customers_copy 
group by country ;


-- Find total customers by gender
select gender  , COUNT(customer_key) total_customers
from gold.dim_customers_copy
group by gender ; 


-- Find total products by category
select category , COUNT(product_key) total_products 
from gold.dim_products_copy
group by category  ;


-- Find average cost in each category
select category , AVG(cost) average_cost
from gold.dim_products_copy
group by category ;


-- Find total revenue by each category
select 
	p.category ,
	SUM(f.sales_amount) total_revenue
from gold.fact_sales_copy as f
left join gold.dim_products_copy as p
on p.product_key = f.product_key 
group by category 
order by total_revenue;


-- Find total revenue generated  by each customers
select 
	c.customer_key ,
	c.first_name , 
	c.last_name ,
	SUM(f.sales_amount) total_revenue
from gold.fact_sales_copy as f
left join gold.dim_customers_copy as c
on c.customer_key = f.customer_key
group by 
c.customer_key , 
c.first_name ,
c.last_name
order by total_revenue desc ; 


-- Find distribution of sold item across country
select 
	c.country ,
	SUM(f.quantity) total_quantity
from gold.fact_sales_copy as f
left join gold.dim_customers_copy as c
on c.customer_key = f.customer_key
group by 
c.country
order by total_quantity desc ; 


-- Which 5 products generate highest revenue
select  top(5)
	p.product_name ,
	SUM(f.sales_amount) total_revenue
from gold.fact_sales_copy as f
left join gold.dim_products_copy as p
on p.product_key = f.product_key 
group by p.product_name 
order by total_revenue desc ;


-- Which 5 products generate least revenue
select  top(5)
	p.product_name ,
	SUM(f.sales_amount) total_revenue
from gold.fact_sales_copy as f
left join gold.dim_products_copy as p
on p.product_key = f.product_key 
group by p.product_name 
order by total_revenue  ;



-- Which 5 products generate highest revenue
select  top(5)
	p.subcategory ,
	SUM(f.sales_amount) total_revenue
from gold.fact_sales_copy as f
left join gold.dim_products_copy as p
on p.product_key = f.product_key 
group by p.subcategory 
order by total_revenue desc ;


-- Which 5 subcategories generate least revenue
select  top(5)
	p.subcategory ,
	SUM(f.sales_amount) total_revenue
from gold.fact_sales_copy as f
left join gold.dim_products_copy as p
on p.product_key = f.product_key 
group by p.subcategory 
order by total_revenue  ;


-- Find Top-10 customers who generated highest revenue
select top(10)
	c.customer_key ,
	c.first_name , 
	c.last_name ,
	SUM(f.sales_amount) total_revenue
from gold.fact_sales_copy as f
left join gold.dim_customers_copy as c
on c.customer_key = f.customer_key
group by 
c.customer_key , 
c.first_name ,
c.last_name
order by total_revenue desc ; 