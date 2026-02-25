--  All Quantities and Discounts
SELECT quantity, discount_applied
FROM sales_master;


-- Where Qunanty is less than 3
SELECT quantity, discount_applied
FROM sales_master
WHERE quantity < 3;


-- Where Qunanty is greater than 3
SELECT quantity, discount_applied
FROM sales_master
WHERE quantity > 3;


-- Count Where Quantity is Less than 3
SELECT discount_applied, COUNT(*) as times_used
FROM sales_master
WHERE quantity < 3
GROUP BY discount_applied;


-- Count Where Quantity is Greater than 3
SELECT discount_applied, COUNT(*) as times_used
FROM sales_master
WHERE quantity > 3
GROUP BY discount_applied;


-- total number of items bought when quatity was less than 3
SELECT COUNT(*) as total_times
FROM sales_master
WHERE quantity < 3;


-- total number of items bought when quatity was Greater than 3
SELECT COUNT(*) as total_times
FROM sales_master
WHERE quantity > 3;


-- total number of items bought when quatity was EQUAL than 3
SELECT COUNT(*) as total_times
FROM sales_master
WHERE quantity = 3;
