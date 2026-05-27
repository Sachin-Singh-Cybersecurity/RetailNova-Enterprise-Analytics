-- =====================================================
-- RETAILNOVA PVT LTD
-- MODULE: Data Cleaning & Transformation
-- PURPOSE: Standardize, clean, deduplicate, and
--          transform raw staging data into analytics-
--          ready tables
-- AUTHOR: Sachin Singh Tanwar
-- =====================================================

CREATE TABLE products_clean AS
SELECT DISTINCT
    Product_ID, Product_Name, Category, Sub_Category, Supplier,
    CAST(Manufacturing_Cost AS DECIMAL(12,2))
        AS Manufacturing_Cost,
    CAST(Retail_Price AS DECIMAL(12,2))
        AS Retail_Price
FROM staging_products;
-- -----------------------------------
CREATE TABLE customers_clean AS
SELECT DISTINCT
    Customer_ID, Customer_Name, Age_Group, Gender, City,
    STR_TO_DATE(Join_Date,'%Y-%m-%d')
        AS Join_Date,
    Loyalty_Status, Acquisition_Channel
FROM staging_customers;
-- -----------------------------------
CREATE TABLE orders_clean AS
SELECT DISTINCT
    Order_ID,
    STR_TO_DATE(Order_Date,'%Y-%m-%d') AS Order_Date,
    CASE WHEN Ship_Date IS NULL OR Ship_Date=''
        THEN NULL
        ELSE STR_TO_DATE(Ship_Date,'%Y-%m-%d')
    END AS Ship_Date, 
    Customer_ID, Product_ID, Region, State, City, Segment, Sales_Channel,
    CAST(Sales AS DECIMAL(12,2)) AS Sales,
    CAST(Quantity AS UNSIGNED) AS Quantity,
    CASE WHEN Discount IS NULL OR Discount=''
        THEN 0
        ELSE CAST(Discount AS DECIMAL(10,2))
    END AS Discount,
    CAST(Profit AS DECIMAL(12,2)) AS Profit,
    Ship_Mode, Payment_Mode
FROM staging_orders;
-- -----------------------------------
CREATE TABLE returns_clean AS
SELECT DISTINCT Return_ID, Order_ID, Return_Reason,
    CAST(Refund_Amount AS DECIMAL(12,2)) AS Refund_Amount,
    Return_Status
FROM staging_returns;