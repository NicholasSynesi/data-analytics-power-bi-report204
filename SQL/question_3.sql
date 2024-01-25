SELECT
    s.store_type AS store_type,
    SUM(p.sale_price * o.total_orders) AS revenue
FROM 
    dim_product p 
JOIN 
    orders o ON p.product_code = o.product_code
JOIN 
    dim_store s ON o.store_code = s.store_code
WHERE
    o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
    AND s.country = 'Germany'
GROUP BY
    store_type
ORDER BY 
    revenue DESC
LIMIT 1;