-- Overtime change analysis
SELECT
    YEAR(order_date) AS order_year,
    FORMAT(order_date, 'MMM') AS order_month_name,
    SUM(sales_amount) AS total_sales,
    SUM(customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales_copy
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date) , FORMAT(order_date, 'MMM')
ORDER BY YEAR(order_date), MONTH(order_date);


-- Progress analysis overtime
-- Total sales per month and running total of sales over time

select 
YEAR(order_date) as order_year, 
total_sales , 
SUM(total_sales) over(order by order_date) as running_total_sales ,
AVG(avg_price) over(order by order_date) as moving_average_price
from (
	select 
		DATETRUNC(year , order_date) as order_date , 
		SUM(sales_amount) as total_sales,
		AVG(price) as avg_price
	from gold.fact_sales_copy  
	where order_date is not null
	group by DATETRUNC(year , order_date)
) t


-- Analyze yearly performance of products by compairing their sales to both average sales and the previous sales ;\
With yearly_product_sales AS (
select 
YEAR(f.order_date) as order_year , 
p.product_name , 
SUM(f.sales_amount) as current_sales 
from gold.fact_sales_copy f
left join gold.dim_products_copy p
on p.product_key  = f.product_key 
where f.order_date is not null
group by year(f.order_date) , p.product_name
)

select 
	order_year , 
	product_name ,
	current_sales , 
	AVG(current_sales) over(partition by product_name) avg_sales,
	case when current_sales - AVG(current_sales) over(partition by product_name) >0then 'Above Average'
		 when current_sales - AVG(current_sales) over(partition by product_name) <0 then 'Below Average'
		 else 'Average'
	end avg_change ,
	case when current_sales - lag(current_sales) over(partition by product_name order by order_year) > 0 then 'Increase' 
		 when current_sales - lag(current_sales) over(partition by product_name order by order_year) < 0 then 'Decrease'
		 else 'No change'
	end prev_change
from yearly_product_sales 
order by product_name, order_year ;



-- Which category contributes to most of sales
WITH category_sales as(
select 
c.category , 
SUM(s.sales_amount) total_sales
from gold.fact_sales_copy s
left join gold.dim_products_copy c
on c.product_key = s.product_key
group by c.category
)

select 
category  , 
total_sales ,
CONCAT(ROUND((CAST(total_sales as float)  / SUM(total_sales) over()) *100 , 2) ,'%') as percentage_total
from category_sales
order by percentage_total desc;


