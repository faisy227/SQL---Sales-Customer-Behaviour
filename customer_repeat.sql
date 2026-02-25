SELECT CASE
    WHEN order_count = 1 THEN "One-time"
    ELSE 'Repeat'
  END AS customer_type,
  COUNT(*) as total_customers,
  SUM(total_spent) as total_revenue
FROM (
    SELECT customer_id,
      COUNT(DISTINCT(order_id)) as order_count,
      SUM(revenue) as total_spent
    from sales_master
    GROUP BY customer_id
    HAVING TRIM(customer_id) != ""
  ) as t
GROUP BY customer_type