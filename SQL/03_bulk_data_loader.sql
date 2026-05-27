-- =====================================================
-- RETAILNOVA PVT LTD
-- MODULE: Data Ingestion Pipeline
-- PURPOSE: Load raw CSV datasets into staging tables
-- AUTHOR: Sachin Singh Tanwar
-- =====================================================

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/KArju/Desktop/Enterprise-Analytics-Projects/RetailNova Pvt Ltd/DATA ENGINEERING/products.csv'
INTO TABLE staging_products
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
