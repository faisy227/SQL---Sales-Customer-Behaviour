-- Total Sales Over Time withput discount
SELECT SUM(revenue) AS total_revenue FROM sales_master;


-- Top 10 Performing Products
SELECT 
  product_name,
  CAST(SUM(revenue) AS DECIMAL(10,2)) AS product_revenue
FROM sales_master
GROUP BY product_name
ORDER BY product_revenue DESC
LIMIT 10;

-- Best‑Selling Categories
SELECT 
  category,
  CAST(SUM(revenue) AS DECIMAL(10,2)) AS category_revenue
FROM sales_master
GROUP BY category
ORDER BY category_revenue DESC;

