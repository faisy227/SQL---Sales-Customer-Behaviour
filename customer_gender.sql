-- revenue and count by gender
SELECT gender,
    SUM(revenue) as total_revenue,
    COUNT(DISTINCT(customer_id)) as total_count
FROM sales_master
GROUP BY gender;

