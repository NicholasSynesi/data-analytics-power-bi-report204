SELECT
    p.category AS product_category,
    SUM((p.sale_price - p.cost_price) * o.total_orders) AS total_profit
FROM 
    dim_product p 
JOIN 
    orders o ON p.product_code = o.product_code
JOIN 
    dim_store s ON o.store_code = s.store_code
WHERE
    s.full_region = 'Wiltshire, UK'
    AND o.order_date >= '2021-01-01' AND o.order_date < '2022-01-01'
GROUP BY
    product_category
ORDER BY 
    total_profit DESC
LIMIT 1;