-- =====================================================
-- RETAILNOVA PVT LTD
-- MODULE: Data Profiling & Validation
-- PURPOSE: Perform null checks, duplicates, profiling,
--          and data quality validation
-- AUTHOR: Sachin Singh Tanwar
-- =====================================================

-- Check Missing Values

SET @db = 'retailnova_db', @tbl = 'staging_returns'; -- JUST CHANGE THESE

SET SESSION group_concat_max_len = 50000;

SELECT GROUP_CONCAT(CONCAT('SUM(`',column_name,'` IS NULL OR `',column_name,'`=\'\')`',column_name,'`')) 
INTO @q FROM INFORMATION_SCHEMA.COLUMNS WHERE table_schema=@db AND table_name=@tbl;

SET @q = CONCAT('SELECT ', @q, ' FROM `', @db, '`.`', @tbl, '`');
PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s;

-- Verify Data Import
SELECT COUNT(*) FROM staging_products;
SELECT COUNT(*) FROM staging_customers;
SELECT COUNT(*) FROM staging_orders;
SELECT COUNT(*) FROM staging_returns;

-- Check Duplicate/Categorial Values

-- Orders Table
SELECT Order_ID, COUNT(*) AS duplicate_count
FROM staging_orders GROUP BY Order_ID HAVING COUNT(*) > 1; -- 50

SELECT DISTINCT Payment_Mode FROM staging_orders;
SELECT MIN(Sales), MAX(Sales), AVG(Sales) FROM staging_orders;

-- Customers Table
SELECT Customer_ID, COUNT(*) AS duplicate_count
FROM staging_customers GROUP BY Customer_ID HAVING COUNT(*) > 1; -- 15

SELECT DISTINCT Age_Group FROM staging_customers;

-- Products Table
SELECT Product_ID, COUNT(*) AS duplicate_count
FROM staging_products GROUP BY Product_ID HAVING COUNT(*) > 1; -- 5

SELECT DISTINCT Category FROM staging_products;
SELECT DISTINCT Supplier FROM staging_products;

-- Returns Table
SELECT Return_ID, COUNT(*) AS duplicate_count
FROM staging_returns GROUP BY Return_ID HAVING COUNT(*) > 1; -- 10
SELECT Order_ID, COUNT(*) AS duplicate_count
FROM staging_returns GROUP BY Order_ID HAVING COUNT(*) > 1; -- 36 

SELECT DISTINCT Return_Status FROM staging_returns;


