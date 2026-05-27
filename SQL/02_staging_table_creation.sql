-- =====================================================
-- RETAILNOVA PVT LTD
-- MODULE: Staging Layer
-- PURPOSE: Create raw ingestion staging tables
-- AUTHOR: Sachin Singh Tanwar
-- =====================================================

CREATE TABLE staging_products (
    Product_ID VARCHAR(255),
    Product_Name VARCHAR(255),
    Category VARCHAR(255),
    Sub_Category VARCHAR(255),
    Supplier VARCHAR(255),
    Manufacturing_Cost VARCHAR(255),
    Retail_Price VARCHAR(255)
);
CREATE TABLE staging_customers (
    Customer_ID VARCHAR(255),
    Customer_Name VARCHAR(255),
    Age_Group VARCHAR(255),
    Gender VARCHAR(255),
    City VARCHAR(255),
    Join_Date VARCHAR(255),
    Loyalty_Status VARCHAR(255),
    Acquisition_Channel VARCHAR(255)
);
CREATE TABLE staging_orders (
    Order_ID VARCHAR(255),
    Order_Date VARCHAR(255),
    Ship_Date VARCHAR(255),
    Customer_ID VARCHAR(255),
    Product_ID VARCHAR(255),
    Region VARCHAR(255),
    State VARCHAR(255),
    City VARCHAR(255),
    Segment VARCHAR(255),
    Sales_Channel VARCHAR(255),
    Sales VARCHAR(255),
    Quantity VARCHAR(255),
    Discount VARCHAR(255),
    Profit VARCHAR(255),
    Ship_Mode VARCHAR(255),
    Payment_Mode VARCHAR(255)
);
CREATE TABLE staging_returns (
    Return_ID VARCHAR(255),
    Order_ID VARCHAR(255),
    Return_Reason VARCHAR(255),
    Refund_Amount VARCHAR(255),
    Return_Status VARCHAR(255)
);

