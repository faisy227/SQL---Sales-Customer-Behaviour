-- Identify and list all tables
SELECT *
FROM customer_info;

SELECT *
from product_info;

SELECT *
FROM sales_data;

-- Check for missing values
SELECT
  SUM(CASE WHEN customer_id IS NULL OR customer_id = '' THEN 1 ELSE 0 END) AS missing_id,
  SUM(CASE WHEN email IS NULL OR email = '' THEN 1 ELSE 0 END) AS missing_email,
  SUM(CASE WHEN signup_date IS NULL OR signup_date = '' THEN 1 ELSE 0 END) AS missing_signup_date,
  SUM(CASE WHEN gender IS NULL OR gender = '' THEN 1 ELSE 0 END) AS missing_gender,
  SUM(CASE WHEN region IS NULL OR region = '' THEN 1 ELSE 0 END) AS missing_region,
  SUM(CASE WHEN loyalty_tier IS NULL OR loyalty_tier = '' THEN 1 ELSE 0 END) AS missing_tier
FROM customer_info;

SELECT
  SUM(CASE WHEN product_id IS NULL OR product_id = '' THEN 1 ELSE 0 END) AS missing_id,
  SUM(CASE WHEN product_name IS NULL OR product_name = '' THEN 1 ELSE 0 END) AS missing_name,
  SUM(CASE WHEN category IS NULL OR category = '' THEN 1 ELSE 0 END) AS missing_category,
  SUM(CASE WHEN launch_date IS NULL OR launch_date = '' THEN 1 ELSE 0 END) AS missing_launch_date,
  SUM(CASE WHEN base_price IS NULL OR base_price = '' THEN 1 ELSE 0 END) AS missing_base_price,
  SUM(CASE WHEN supplier_code IS NULL OR supplier_code = '' THEN 1 ELSE 0 END) AS missing_code
FROM product_info;

SELECT
  SUM(CASE WHEN order_id IS NULL OR order_id = '' THEN 1 ELSE 0 END) AS missing_id,
  SUM(CASE WHEN customer_id IS NULL OR customer_id = '' THEN 1 ELSE 0 END) AS missing_customer_id,
  SUM(CASE WHEN product_id IS NULL OR product_id = '' THEN 1 ELSE 0 END) AS missing_product_id,
  SUM(CASE WHEN quantity IS NULL OR quantity = '' THEN 1 ELSE 0 END) AS missing_quantity,
  SUM(CASE WHEN unit_price IS NULL OR unit_price = '' THEN 1 ELSE 0 END) AS missing_unit_price,
  SUM(CASE WHEN order_date IS NULL OR order_date = '' THEN 1 ELSE 0 END) AS missing_order_date,
  SUM(CASE WHEN delivery_status IS NULL OR delivery_status = '' THEN 1 ELSE 0 END) AS missing_satus,
  SUM(CASE WHEN payment_method IS NULL OR payment_method = '' THEN 1 ELSE 0 END) AS missing_method,
  SUM(CASE WHEN region IS NULL OR region = '' THEN 1 ELSE 0 END) AS missing_region,
  SUM(CASE WHEN discount_applied IS NULL OR discount_applied = '' THEN 1 ELSE 0 END) AS missing_discount
FROM sales_data;

-- Standardize date formats (YYYY-MM-DD)
SELECT signup_date,
    DATE_FORMAT(
        -- transform a string into a date
        STR_TO_DATE(signup_date, '%Y-%c-%e'),
        '%Y-%m-%d'
    ) AS standardized_date
FROM customer_info;

SELECT launch_date,
    DATE_FORMAT(
        STR_TO_DATE(launch_date, '%Y-%c-%e'),
        '%Y-%m-%d'
    ) AS standardized_date
FROM product_info;

SELECT order_date,
    DATE_FORMAT(
        STR_TO_DATE(order_date, '%Y-%c-%e'),
        '%Y-%m-%d'
    ) AS standardized_date
FROM sales_data;

-- Create a Master View
CREATE VIEW sales_master AS
SELECT
    sd.order_id,
    c.customer_id,
    p.product_id,
   CAST(sd.quantity AS UNSIGNED) AS quantity,
    CAST(sd.unit_price AS DECIMAL(10,2)) AS unit_price,
    DATE_FORMAT(
        STR_TO_DATE(sd.order_date, '%Y-%c-%e'),
        '%Y-%m-%d'
    ) AS order_date,
    CONCAT(
        UPPER(LEFT(TRIM(sd.delivery_status), 1)),
        LOWER(SUBSTRING(TRIM(sd.delivery_status), 2))
    ) AS delivery_status,
    CONCAT(
        UPPER(LEFT(TRIM(sd.payment_method), 1)),
        LOWER(SUBSTRING(TRIM(sd.payment_method), 2))
    ) AS payment_method,
    sd.region,
    CAST(sd.discount_applied AS DECIMAL(10,2)) AS discount_applied,
    c.email,
    DATE_FORMAT(
        STR_TO_DATE(c.signup_date, '%Y-%c-%e'),
        '%Y-%m-%d'
    ) AS signup_date,
    CONCAT(
        UPPER(LEFT(TRIM(c.gender), 1)),
        LOWER(SUBSTRING(TRIM(c.gender), 2))
    ) AS gender,
    CONCAT(
        UPPER(LEFT(TRIM(c.loyalty_tier), 1)),
        LOWER(SUBSTRING(TRIM(c.loyalty_tier), 2))
    ) AS loyalty_tier,
    p.product_name,
    p.category,
    DATE_FORMAT(
        STR_TO_DATE(p.launch_date, '%Y-%c-%e'),
        '%Y-%m-%d'
    ) AS launch_date,
    CAST(p.base_price AS DECIMAL(10,2)) AS base_price,
    p.supplier_code,
    CAST(
    sd.quantity * sd.unit_price * (1 - sd.discount_applied)
    AS DECIMAL(12,2)
) AS revenue
FROM sales_data sd
JOIN customer_info c ON sd.customer_id = c.customer_id
JOIN product_info p ON sd.product_id = p.product_id;

