-- =====================================================
-- RETAILNOVA PVT LTD
-- MODULE: Profitability & Discount Analytics
-- PURPOSE: Evaluate margins, discount leakage,
--          loss-making products, and supplier economics
-- AUTHOR: Sachin Singh Tanwar
-- =====================================================

-- KPI 1 — OVERALL PROFITABILITY
SELECT
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin_percent
FROM orders_clean;

-- KPI 2 — DISCOUNT IMPACT ANALYSIS
SELECT
    CASE WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.10 THEN 'Low Discount'
		WHEN Discount <= 0.25 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_category,
    COUNT(*) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(AVG(Profit), 2) AS avg_profit
FROM orders_clean
GROUP BY discount_category
ORDER BY avg_profit DESC;


-- KPI 3 — CATEGORY PROFITABILITY
SELECT p.Category,
    ROUND(SUM(o.Sales), 2) AS total_sales,
    ROUND(SUM(o.Profit), 2) AS total_profit,
    ROUND((SUM(o.Profit) / SUM(o.Sales)) * 100, 2) AS profit_margin_percent
FROM orders_clean o
JOIN products_clean p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY profit_margin_percent DESC;

-- KPI 4 — LOSS-MAKING CATEGORIES
SELECT p.Category,
    ROUND(SUM(o.Profit), 2) AS total_profit
FROM orders_clean o
JOIN products_clean p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Category
HAVING total_profit < 0
ORDER BY total_profit ASC;

-- KPI 5 — LOSS-MAKING PRODUCTS
SELECT p.Product_Name, p.Category,
    ROUND(SUM(o.Sales), 2) AS total_sales,
    ROUND(SUM(o.Profit), 2) AS total_profit,
    ROUND(AVG(o.Discount) * 100, 2) AS avg_discount_percent
FROM orders_clean o
JOIN products_clean p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Product_Name, p.Category
HAVING total_profit < 0
ORDER BY total_profit ASC LIMIT 20;

-- KPI 6 — REGIONAL PROFITABILITY
SELECT Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin_percent
FROM orders_clean
GROUP BY Region
ORDER BY profit_margin_percent DESC;

-- KPI 7 — STATE-LEVEL LOSS ANALYSIS
SELECT State,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM orders_clean
GROUP BY State
HAVING total_profit < 0
ORDER BY total_profit ASC;

-- KPI 8 — SHIPPING MODE PROFITABILITY
SELECT Ship_Mode,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(AVG(Profit), 2) AS avg_profit
FROM orders_clean
GROUP BY Ship_Mode
ORDER BY avg_profit DESC;

-- KPI 9 — CUSTOMER SEGMENT PROFITABILITY
SELECT Segment,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(AVG(Profit),2) AS avg_profit_per_order
FROM orders_clean
GROUP BY Segment
ORDER BY total_profit DESC;

-- KPI 10 — HIGH DISCOUNT RISK ORDERS
SELECT Order_ID, Sales, Discount, Profit, Region, Segment
FROM orders_clean
WHERE Discount >= 0.40 AND Profit < 0
ORDER BY Profit ASC;

-- KPI 11 — MONTHLY PROFIT TREND
SELECT
    YEAR(Order_Date) AS order_year,
    MONTH(Order_Date) AS order_month,
    ROUND(SUM(Profit), 2) AS monthly_profit
FROM orders_clean
GROUP BY 
	YEAR(Order_Date),
    MONTH(Order_Date)
ORDER BY order_year, order_month;

-- KPI 12 — TOP PROFITABLE PRODUCTS
SELECT p.Product_Name, p.Category,
    ROUND(SUM(o.Profit), 2) AS total_profit
FROM orders_clean o
JOIN products_clean p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Product_Name, p.Category
ORDER BY total_profit DESC LIMIT 10;

-- KPI 13 — SUPPLIER PROFITABILITY ANALYSIS
SELECT p.Supplier,
    ROUND(SUM(o.Sales), 2) AS total_sales,
    ROUND(SUM(o.Profit), 2) AS total_profit,
    ROUND(AVG(o.Profit), 2) AS avg_profit
FROM orders_clean o
JOIN products_clean p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Supplier
ORDER BY total_profit DESC;