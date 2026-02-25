SELECT  region, SUM(revenue) as revenue
FROM sales_master
GROUP BY region
ORDER BY SUM(revenue) DESC;

