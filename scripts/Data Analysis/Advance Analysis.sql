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
--
