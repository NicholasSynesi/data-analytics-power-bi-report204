SELECT
    SUBSTRING(o.order_date, 6, 2) AS month,
    SUM(p.sale_price * o.total_orders) AS revenue
FROM 
    dim_product p 
JOIN 
    orders o ON p.product_code = o.product_code
WHERE
    o.order_date >= '2022-01-01' AND o.order_date < '2023-01-01'
GROUP BY
    month 
ORDER BY 
    revenue DESC
LIMIT 1;