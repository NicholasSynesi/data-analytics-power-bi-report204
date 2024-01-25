DROP VIEW IF EXISTS store_sales_view;

CREATE VIEW store_sales_view AS
SELECT
    s.store_type AS store_type,
    SUM(p.sale_price * o.total_orders) AS total_sales,
    SUM(p.sale_price * o.total_orders) / SUM(SUM(p.sale_price * o.total_orders)) OVER () * 100 AS percentage_of_total_sales,
    COUNT(o.order_date_uuid) AS order_count
FROM 
    dim_product p 
JOIN 
    orders o ON p.product_code = o.product_code
JOIN 
    dim_store s ON o.store_code = s.store_code
GROUP BY
    store_type;