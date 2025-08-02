create view gold.dim_customers as 
select 
	row_number() over(order by cst_id) customer_key,
	ci.cst_id customer_id, 
	ci.cst_key customer_number, 
	ci.cst_firstname first_name,
	ci.cst_lastname last_name,
	co.cntry country ,
	ci.cst_marital_status marital_status,
	case when ci.cst_gndr !='n/a' then ci.cst_gndr 
		 else COALESCE(ca.gen , 'n/a')
		 end as gender ,
	ci.cst_create_date create_date,
	ca.bdate birthdate 
from silver.crm_cust_info as ci 
left join silver.erp_cust_az12 as ca
on ci.cst_key = ca.cid 
left join silver.erp_loc_a101 as co
on ci.cst_key = co.cid ;

GO


create view gold.dim_products as 
select 
	row_number() over(order by cp.prd_start_dt , cp.prd_key) product_key , 
	cp.prd_id product_id, 
	cp.prd_key product_number, 
	cp.prd_nm product_name,
	cp.cat_id category_id,
	ep.cat category, 
	ep.subcat subcategory, 
	ep.maintenance ,
	cp.prd_cost cost, 
	cp.prd_line product_line, 
	CAST(cp.prd_start_dt as DATE) start_date 
from silver.crm_prd_info as cp
left join silver.erp_px_cat_g1v2  as ep
on cp.cat_id = ep.id
where prd_end_dt is null


GO

create view gold.fact_sales as
select 
	sls_ord_num order_number, 
	gp.product_key , 
	gc.customer_key ,
	sls_order_dt order_date, 
	sls_ship_dt shipping_date,
	sls_due_dt due_date,
	sls_sales sales_amount, 
	sls_quantity quantity,
	sls_price price
from silver.crm_sales_details 
left join gold.dim_products as gp
on gp.product_number = sls_prd_key
left join gold.dim_customers as gc
on gc.customer_id = sls_cust_id ;


 
