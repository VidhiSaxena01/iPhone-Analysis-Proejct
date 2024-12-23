SELECT 
    *
FROM
    apple_products;

-- 1. Sales and Revenue Analysis

-- Total revenue generated by each price category

SELECT 
    Price_Category, SUM(Revenue) AS Total_Revenue
FROM
    apple_products
GROUP BY Price_Category
ORDER BY Total_Revenue DESC;

-- Top 5 Product with highest revenue

SELECT 
    Product_Name, SUM(Revenue) AS Total_Revenue
FROM
    apple_products
GROUP BY Product_Name
ORDER BY Total_Revenue DESC
LIMIT 5;

-- Average sale price of products across storage capacities

SELECT 
    TRIM(Storage_Capacity) AS Storage_Capacity, 
    AVG(Sale_Price) AS Avg_Sale_Price
FROM
    apple_products
WHERE
    Storage_Capacity != ''
        AND Storage_Capacity IS NOT NULL
GROUP BY TRIM(Storage_Capacity)
ORDER BY Avg_Sale_Price DESC;


-- Total quantity sold for each product

SELECT 
    Product_Name, SUM(Quantity_Sold) AS Total_Sold
FROM
    apple_products
GROUP BY Product_Name
ORDER BY Total_Sold DESC;


-- 2. Customer Engagement Analysis

-- Product with highest total engagement (ratings + reviews)

SELECT 
    Product_Name, SUM(Total_Engagement) AS Total_Engagement
FROM
    apple_products
WHERE
    Total_Engagement IS NOT NULL
        AND Total_Engagement > 0
GROUP BY Product_Name
ORDER BY Total_Engagement DESC
LIMIT 5;

-- Average star rating for each price category

SELECT 
    Price_Category,
    ROUND(AVG(Star_Rating), 0) AS Avg_Star_Rating
FROM
    apple_products
GROUP BY Price_Category
ORDER BY Avg_Star_Rating DESC;

-- Correlation between number of reviews and ratings

SELECT 
    Number_Of_Ratings,
    Number_Of_Reviews,
    ROUND(Number_Of_Ratings / NULLIF(Number_Of_Reviews, 0),
            1) AS Rating_Review_Ratio
FROM
    apple_products;

-- RAM category with the most customer engagement

SELECT 
    RAM, SUM(Total_Engagement) AS Total_Engagement
FROM
    apple_products
GROUP BY RAM
ORDER BY Total_Engagement DESC;


-- 3. Pricing and Discounts

-- Top 5 Products with the highest discounts

SELECT 
    Product_Name, MAX(Discount_Percentage) AS Max_Discount
FROM
    apple_products
GROUP BY Product_Name
ORDER BY Max_Discount DESC
LIMIT 5;

-- Total discount amount offered for each price category

SELECT 
    Price_Category, Round(SUM(Discount_Amount),0) AS Total_Discount
FROM
    apple_products
GROUP BY Price_Category
ORDER BY Total_Discount DESC;

-- Average MRP for products in each RAM category

SELECT 
    RAM, Round(AVG(Mrp),0) AS Avg_MRP
FROM
    apple_products
GROUP BY RAM
ORDER BY Avg_MRP DESC;

-- Relationship between storage capacity and discount percentage

SELECT 
    TRIM(UPPER(Storage_Capacity)) AS Storage_Capacity,
    CONCAT(ROUND(AVG(CAST(REPLACE(Discount_Percentage, '%', '') AS DECIMAL(5, 2))), 0), '%') AS Avg_Discount
FROM
    apple_products
WHERE
    Discount_Percentage IS NOT NULL
        AND Discount_Percentage != ''
        AND TRIM(Storage_Capacity) != ''
GROUP BY TRIM(UPPER(Storage_Capacity))
ORDER BY AVG(CAST(REPLACE(Discount_Percentage, '%', '') AS DECIMAL(5, 2))) DESC;


-- 4. Product Performance

-- Products variant (color + RAM + storage) with the most units sold

SELECT 
    Product_Name,Colour,ram, Storage_Capacity, SUM(Quantity_Sold) AS Total_Sold
FROM
    apple_products
GROUP BY Product_Name,Colour,ram, Storage_Capacity
ORDER BY Total_Sold DESC;


-- Most popular color for each price category

SELECT 
    a.Price_Category, 
    a.Colour, 
    SUM(a.Quantity_Sold) AS Total_Sold
FROM apple_products a
WHERE a.Colour = (
    SELECT b.Colour
    FROM apple_products b
    WHERE b.Price_Category = a.Price_Category
    GROUP BY b.Colour
    ORDER BY SUM(b.Quantity_Sold) DESC, b.Colour ASC
    LIMIT 1
)
GROUP BY a.Price_Category, a.Colour;


-- Average quantity sold for products in each star rating range

SELECT 
    Star_Rating, Round(AVG(Quantity_Sold),0) AS Avg_Quantity_Sold
FROM
    apple_products
GROUP BY Star_Rating
ORDER BY Star_Rating ASC;




