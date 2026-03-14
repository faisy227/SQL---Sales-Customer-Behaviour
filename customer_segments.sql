-- customer segments
WITH customers_totals AS (
    SELECT
        email,
        CAST(SUM(quantity * unit_price) AS DECIMAL(10,2)) AS total_purchase
    FROM sales_master
    WHERE LENGTH(email) > 1
    GROUP BY email
),
ranked_customers AS (
    SELECT
        email,
        total_purchase,
        NTILE(10) OVER (ORDER BY total_purchase DESC) AS spend_tile
    FROM customers_totals
),
segments AS (
    SELECT
        email,
        total_purchase,
        CASE
            WHEN spend_tile <= 2 THEN 'Top 20%'
            WHEN spend_tile <= 7 THEN 'Middle 50%'
            ELSE 'Bottom 30%'
        END AS customer_segment
    FROM ranked_customers
)
-- 
-- table summary
SELECT
    customer_segment,
    COUNT(*) AS customer_count,
    SUM(total_purchase) AS segment_revenue,
    ROUND(
        SUM(total_purchase) /
        (SELECT SUM(revenue) from sales_master) * 100,
        2
    ) as segment_rate
FROM segments
GROUP BY customer_segment;





