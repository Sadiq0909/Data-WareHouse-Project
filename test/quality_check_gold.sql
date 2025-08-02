-- Duplicate Key Checks
SELECT customer_key, COUNT(*) FROM gold.dim_customers GROUP BY customer_key HAVING COUNT(*) > 1;
SELECT product_key, COUNT(*) FROM gold.dim_products GROUP BY product_key HAVING COUNT(*) > 1;

-- Fact-Dimension Referential Integrity Check
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p ON p.product_key = f.product_key
WHERE c.customer_key IS NULL OR p.product_key IS NULL;
