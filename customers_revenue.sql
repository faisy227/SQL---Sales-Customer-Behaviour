-- Customers and their totals
SELECT 
    email,
    CAST(SUM(revenue) AS DECIMAL(10,2)) AS total_purchase
FROM sales_master
WHERE LENGTH(email) > 1
GROUP BY email
ORDER BY total_purchase DESC;
