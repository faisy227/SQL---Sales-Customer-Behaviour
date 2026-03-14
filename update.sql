-- Update the outlier miss spelling
UPDATE customer_info
SET gender = 'Female'
WHERE gender = 'Femle';

-- Update the outlier miss spelling
UPDATE sales_data
SET region = 'North'
WHERE region = 'nrth';

-- update the missing gender
UPDATE customer_info
SET gender = 'Other'
WHERE gender IS NULL
   OR TRIM(gender) = '';
