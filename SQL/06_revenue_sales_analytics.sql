-- =====================================================
-- RETAILNOVA PVT LTD
-- MODULE: Revenue & Sales Analytics
-- PURPOSE: Analyze revenue trends, sales KPIs,
--          category performance, and regional growth
-- AUTHOR: Sachin Singh Tanwar
-- =====================================================

-- KPI 1 — TOTAL REVENUE
SELECT ROUND(SUM(Sales), 2) AS total_revenue FROM orders_clean;

-- KPI 2 — TOTAL PROFIT
SELECT ROUND(SUM(Profit), 2) AS total_profit FROM orders_clean;

-- KPI 3 — PROFIT MARGIN %
SELECT ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin_percent
FROM orders_clean;

-- KPI 4 — TOTAL ORDERS
SELECT COUNT(DISTINCT Order_ID) AS total_orders FROM orders_clean;

-- KPI 5 — AVERAGE ORDER VALUE (AOV)
SELECT ROUND(SUM(Sales) /COUNT(DISTINCT Order_ID),2) AS average_order_value
FROM orders_clean;

-- KPI 6 — MONTHLY SALES TREND
SELECT
    YEAR(Order_Date) AS order_year,
    MONTH(Order_Date) AS order_month,
    ROUND(SUM(Sales), 2) AS monthly_sales
FROM orders_clean
GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date)
ORDER BY
    order_year,
    order_month;
    
-- KPI 7 — REGIONAL SALES PERFORMANCE
SELECT Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT Order_ID) AS total_orders
FROM orders_clean
GROUP BY Region
ORDER BY total_sales DESC;

-- KPI 8 — STATE PERFORMANCE ANALYSIS
SELECT State,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM orders_clean
GROUP BY State
ORDER BY total_sales DESC LIMIT 10;

-- KPI 9 — CATEGORY PERFORMANCE
SELECT p.Category,
    ROUND(SUM(o.Sales), 2) AS total_sales,
    ROUND(SUM(o.Profit), 2) AS total_profit,
    ROUND(AVG(o.Discount) * 100, 2)
        AS avg_discount_percent
FROM orders_clean o
JOIN products_clean p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY total_sales DESC;

-- KPI 10 — TOP SELLING PRODUCTS 
SELECT p.Product_Name, p.Category,
    ROUND(SUM(o.Sales), 2) AS total_sales,
    COUNT(*) AS total_orders
FROM orders_clean o
JOIN products_clean p
    ON o.Product_ID = p.Product_ID
GROUP BY
    p.Product_Name,
    p.Category
ORDER BY total_sales DESC
LIMIT 10;

-- KPI 11 — LOW PROFIT PRODUCTS
SELECT p.Product_Name, p.Category,
    ROUND(SUM(o.Profit), 2) AS total_profit,
    ROUND(AVG(o.Discount) * 100, 2)
        AS avg_discount
FROM orders_clean o
JOIN products_clean p
    ON o.Product_ID = p.Product_ID
GROUP BY
    p.Product_Name,
    p.Category
HAVING total_profit < 0
ORDER BY total_profit ASC;

-- KPI 12 — SALES CHANNEL ANALYSIS
SELECT Sales_Channel,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT Order_ID) AS total_orders
FROM orders_clean
GROUP BY Sales_Channel
ORDER BY total_sales DESC;

-- KPI 13 — PAYMENT MODE ANALYSIS
SELECT Payment_Mode,
    COUNT(*) AS total_transactions,
    ROUND(SUM(Sales), 2) AS total_sales
FROM orders_clean
GROUP BY Payment_Mode
ORDER BY total_sales DESC;










