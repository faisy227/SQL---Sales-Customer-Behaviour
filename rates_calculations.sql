-- by gender
SELECT gender,
    ROUND(
        SUM(revenue) / (
            SELECT SUM(revenue)
            FROM sales_master
        ) * 100,
        2
    ) as gender_rates
FROM sales_master
GROUP BY gender;
-- by category

SELECT category,
    ROUND(
        SUM(revenue) / (
            SELECT SUM(revenue)
            FROM sales_master
        ) * 100,
        2
    ) as category_rates
FROM sales_master
GROUP BY category;
-- by region
SELECT region,
    ROUND(
        SUM(revenue) / (
            SELECT SUM(revenue)
            from sales_master
        ) * 100,
        2
    ) as region_rates
from sales_master
GROUP by region;

-- by product
SELECT product_name,
    ROUND(
        SUM(revenue) / (
            SELECT SUM(revenue)
            from sales_master
        ) * 100,
        2
    ) as product_rate
FROM sales_master
GROUP by product_name;

-- by repeat or one-time
SELECT CASE
    WHEN order_count = 1 THEN "One-time"
    ELSE 'Repeat'
  END AS customer_type,
  ROUND(
    SUM(total_spent) /
    (SELECT SUM(revenue) from sales_master) * 100,
    2
  ) as customer_type_rate,
    ROUND(
    COUNT(*) /
    (SELECT COUNT(DISTINCT(customer_id)) from sales_master) * 100,
    2
  ) as total_customer_percent
FROM (
    SELECT customer_id,
      COUNT(DISTINCT(order_id)) as order_count,
      SUM(revenue) as total_spent
    from sales_master
    GROUP BY customer_id
    HAVING TRIM(customer_id) != ""
  ) as t
GROUP BY customer_type

-- segment rate in /customer_segments.sql