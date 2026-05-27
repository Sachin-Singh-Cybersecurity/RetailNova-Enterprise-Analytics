-- =====================================================
-- RETAILNOVA PVT LTD
-- MODULE: Customer & Return Analytics
-- PURPOSE: Analyze customer behavior, loyalty,
--          churn indicators, returns, and refund losses
-- AUTHOR: Sachin Singh Tanwar
-- =====================================================

-- CUSTOMER ANALYTICS
-- KPI 1 — TOTAL CUSTOMERS
SELECT COUNT(DISTINCT Customer_ID) AS total_customers FROM customers_clean;

-- KPI 2 — ACTIVE CUSTOMERS
SELECT COUNT(DISTINCT Customer_ID) AS active_customers FROM orders_clean;

-- KPI 3 — REPEAT CUSTOMERS
SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT Customer_ID,
        COUNT(DISTINCT Order_ID) AS total_orders
    FROM orders_clean
    GROUP BY Customer_ID
    HAVING total_orders > 1
) t;

-- KPI 4 — CUSTOMER LIFETIME VALUE (CLV)
SELECT c.Customer_Name, c.Loyalty_Status,
    ROUND(SUM(o.Sales), 2) AS lifetime_value,
    COUNT(DISTINCT o.Order_ID) AS total_orders
FROM orders_clean o
JOIN customers_clean c
    ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name, c.Loyalty_Status
ORDER BY lifetime_value DESC LIMIT 20;

-- KPI 5 — LOYALTY TIER PERFORMANCE
SELECT c.Loyalty_Status,
    COUNT(DISTINCT o.Customer_ID) AS customers,
    ROUND(SUM(o.Sales), 2) AS total_sales,
    ROUND(SUM(o.Profit), 2) AS total_profit,
    ROUND(AVG(o.Sales), 2) AS avg_order_value
FROM orders_clean o
JOIN customers_clean c
    ON o.Customer_ID = c.Customer_ID
GROUP BY c.Loyalty_Status
ORDER BY total_sales DESC;

-- KPI 6 — CUSTOMER SEGMENT ANALYSIS
SELECT Segment,
    COUNT(DISTINCT Customer_ID) AS unique_customers,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM orders_clean
GROUP BY Segment
ORDER BY total_sales DESC;

-- KPI 7 — ACQUISITION CHANNEL PERFORMANCE
SELECT c.Acquisition_Channel,
    COUNT(DISTINCT o.Customer_ID) AS customers_acquired,
    ROUND(SUM(o.Sales), 2) AS total_sales,
    ROUND(SUM(o.Profit), 2) AS total_profit
FROM orders_clean o
JOIN customers_clean c
    ON o.Customer_ID = c.Customer_ID
GROUP BY c.Acquisition_Channel
ORDER BY total_sales DESC;

-- KPI 8 — CHURN RISK CUSTOMERS
SELECT Customer_ID,
    MAX(Order_Date) AS last_order_date,
    DATEDIFF('2025-12-31', MAX(Order_Date)) AS inactive_days
FROM orders_clean
GROUP BY Customer_ID
HAVING inactive_days > 180
ORDER BY inactive_days DESC;


-- RETURN ANALYTICS
-- KPI 9 — TOTAL RETURNS
SELECT COUNT(*) AS total_returns FROM returns_clean;

-- KPI 10 — RETURN RATE
SELECT
    ROUND((COUNT(DISTINCT r.Order_ID) / COUNT(DISTINCT o.Order_ID)) * 100, 2) 
    AS return_rate_percent
FROM orders_clean o
LEFT JOIN returns_clean r
    ON o.Order_ID = r.Order_ID;
    
-- KPI 11 — CATEGORY RETURN ANALYSIS

SELECT p.Category,
    COUNT(r.Return_ID) AS total_returns,
    ROUND(SUM(r.Refund_Amount), 2) AS total_refund_loss
FROM returns_clean r
JOIN orders_clean o
    ON r.Order_ID = o.Order_ID
JOIN products_clean p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY total_returns DESC;

-- KPI 12 — RETURN REASON ANALYSIS
SELECT Return_Reason,
    COUNT(*) AS total_cases
FROM returns_clean
GROUP BY Return_Reason
ORDER BY total_cases DESC;

-- KPI 13 — RETURN STATUS ANALYSIS
SELECT Return_Status,
    COUNT(*) AS total_returns,
    ROUND(SUM(Refund_Amount), 2) AS total_refunds
FROM returns_clean
GROUP BY Return_Status;

-- KPI 14 — HIGH REFUND LOSS ORDERS

SELECT r.Order_ID, r.Refund_Amount, r.Return_Reason, o.Region, o.State, p.Category
FROM returns_clean r
JOIN orders_clean o
    ON r.Order_ID = o.Order_ID
JOIN products_clean p
    ON o.Product_ID = p.Product_ID
ORDER BY r.Refund_Amount DESC LIMIT 20;

-- KPI 15 — REGIONAL RETURN ANALYSIS
SELECT o.Region,
    COUNT(r.Return_ID) AS total_returns,
    ROUND(SUM(r.Refund_Amount), 2) AS refund_loss
FROM returns_clean r
JOIN orders_clean o
    ON r.Order_ID = o.Order_ID
GROUP BY o.Region
ORDER BY refund_loss DESC;

-- KPI 16 — SHIPPING DELAY VS RETURNS
SELECT
    CASE WHEN DATEDIFF(o.Ship_Date, o.Order_Date) <= 3 THEN 'Fast Delivery'
		 WHEN DATEDIFF(o.Ship_Date, o.Order_Date) <= 7 THEN 'Moderate Delivery'
         ELSE 'Delayed Delivery'
    END AS shipping_speed,
    COUNT(r.Return_ID) AS total_returns,
    ROUND(AVG(r.Refund_Amount), 2) AS avg_refund
FROM orders_clean o
LEFT JOIN returns_clean r
    ON o.Order_ID = r.Order_ID
GROUP BY shipping_speed;
