Create Database iphone_analysis;

Use iphone_analysis;

Select * from apple_products;

-- Data Cleaning

-- Find missing values

SELECT COUNT(*) AS missing_values FROM apple_products
WHERE product_name IS NULL OR product_url IS NULL OR brand IS NULL
   OR sale_price IS NULL OR mrp IS NULL OR discount_percentage IS NULL
   OR number_of_ratings IS NULL OR number_of_reviews IS NULL
   OR upc IS NULL OR star_rating IS NULL OR ram IS NULL;
   
   
-- Delete unwanted column from table

ALTER TABLE apple_products
DROP COLUMN product_url;


-- Check duplicates

SELECT upc, COUNT(*) AS duplicate_count
FROM apple_products
GROUP BY upc
HAVING duplicate_count > 1;

-- Check for any rows where the sale_price is greater than the mrp, as this is a logical inconsistency.

SELECT * FROM apple_products
WHERE sale_price > mrp;


-- Add price_category column
ALTER TABLE apple_products 
ADD COLUMN Price_Category VARCHAR(10);  

UPDATE apple_products  
SET Price_Category = CASE  
    WHEN Sale_Price < 30000 THEN 'Low'  
    WHEN Sale_Price BETWEEN 30000 AND 60000 THEN 'Medium'  
    WHEN Sale_Price > 60000 THEN 'High'  
    ELSE 'Unknown'  
END; 


-- Add ram_category column

ALTER TABLE apple_products
ADD COLUMN RAM_Category VARCHAR(20);

UPDATE apple_products  
SET RAM_Category = CASE  
    WHEN RAM < 4 THEN 'Low'  
    WHEN RAM BETWEEN 4 AND 6 THEN 'Medium'  
    WHEN RAM > 6 THEN 'High'  
    ELSE 'Unknown'  
END;  


-- Add revenue column 

ALTER TABLE apple_products
ADD COLUMN Revenue DECIMAL(15, 2);

UPDATE apple_products
SET Revenue = Sale_Price * Number_Of_Ratings;  


-- add total engagement column

ALTER TABLE apple_products 
ADD COLUMN Total_Engagement INT;  

UPDATE apple_products 
SET Total_Engagement = Number_Of_Ratings + Number_Of_Reviews;  


-- Add discount amount column

ALTER TABLE apple_products
ADD COLUMN Discount_Amount DECIMAL(10, 2);  

UPDATE apple_products 
SET Discount_Amount = MRP - Sale_Price;  


