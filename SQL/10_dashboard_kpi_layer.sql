-- =====================================================
-- RETAILNOVA PVT LTD
-- MODULE: Executive Dashboard KPI Layer
-- PURPOSE: Prepare dashboard-ready KPI datasets and
--          executive reporting queries for Power BI
-- AUTHOR: Sachin Singh Tanwar
-- =====================================================

-- KPI 1 — Total Revenue
SELECT ROUND(SUM(Sales), 2) AS total_revenue FROM orders_clean;

-- KPI 2 — Total Profit
SELECT ROUND(SUM(Profit), 2) AS total_profit FROM orders_clean;

-- KPI 3 — Profit Margin %
SELECT 
	ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin_percent
FROM orders_clean;

-- KPI 4 — Total Orders
SELECT
    COUNT(DISTINCT Order_ID) AS total_orders
FROM orders_clean;

-- KPI 5 — Total Customers
SELECT
    COUNT(DISTINCT Customer_ID) AS total_customers
FROM customers_clean;

-- KPI 6 — Return Rate %
SELECT
    ROUND((COUNT(DISTINCT r.Order_ID) / COUNT(DISTINCT o.Order_ID)) * 100, 2) AS return_rate_percent
FROM orders_clean o
LEFT JOIN returns_clean r
    ON o.Order_ID = r.Order_ID;

-- VISUAL 1 — Monthly Revenue Trend
SELECT
    YEAR(Order_Date) AS order_year,
    MONTH(Order_Date) AS order_month,
    ROUND(SUM(Sales), 2) AS monthly_sales
FROM orders_clean
GROUP BY 
	YEAR(Order_Date),
    MONTH(Order_Date)
ORDER BY order_year, order_month;

-- VISUAL 2 — Regional Performance
SELECT Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM orders_clean
GROUP BY Region;

-- VISUAL 3 — Category Profitability
SELECT p.Category,
    ROUND(SUM(o.Sales), 2) AS total_sales,
    ROUND(SUM(o.Profit), 2) AS total_profit
FROM orders_clean o
JOIN products_clean p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Category;

-- VISUAL 4 — Discount vs Profitability
SELECT Discount, Profit, Sales
FROM orders_clean
WHERE Discount IS NOT NULL;

-- VISUAL 5 — Return Analysis
SELECT Return_Reason,
    COUNT(*) AS total_returns
FROM returns_clean
GROUP BY Return_Reason;

-- VISUAL 6 — Shipping Performance
SELECT Ship_Mode,
    ROUND(AVG(DATEDIFF(Ship_Date, Order_Date)), 2) AS avg_shipping_days
FROM orders_clean
WHERE Ship_Date IS NOT NULL
GROUP BY Ship_Mode;

-- VISUAL 7 — Loyalty Tier Analysis
SELECT c.Loyalty_Status,
    ROUND(SUM(o.Sales), 2) AS total_sales,
    ROUND(SUM(o.Profit), 2) AS total_profit
FROM orders_clean o
JOIN customers_clean c
    ON o.Customer_ID = c.Customer_ID
GROUP BY c.Loyalty_Status;
