-- =====================================================
-- RETAILNOVA PVT LTD
-- MODULE: Operations & Logistics Analytics
-- PURPOSE: Evaluate shipping performance, SLA metrics,
--          operational bottlenecks, and delivery delays
-- AUTHOR: Sachin Singh Tanwar
-- =====================================================

-- KPI 1 — AVERAGE SHIPPING TIME
SELECT
    ROUND(AVG(DATEDIFF(Ship_Date, Order_Date)), 2) AS avg_shipping_days
FROM orders_clean
WHERE Ship_Date IS NOT NULL;

-- KPI 2 — SHIPPING PERFORMANCE BY MODE
SELECT Ship_Mode,
    ROUND(AVG(DATEDIFF(Ship_Date, Order_Date)), 2) AS avg_shipping_days,
    COUNT(*) AS total_orders
FROM orders_clean
WHERE Ship_Date IS NOT NULL
GROUP BY Ship_Mode
ORDER BY avg_shipping_days;

-- KPI 3 — DELAYED SHIPMENT ANALYSIS
SELECT COUNT(*) AS delayed_orders
FROM orders_clean 
WHERE DATEDIFF(Ship_Date, Order_Date) > 7;

-- KPI 4 — DELAY RATE %
SELECT
    ROUND((SUM(
			CASE
				WHEN DATEDIFF(Ship_Date, Order_Date) > 7
				THEN 1
				ELSE 0
			END
            ) / COUNT(*)) * 100, 2) AS delay_rate_percent
FROM orders_clean
WHERE Ship_Date IS NOT NULL;

-- KPI 5 — REGIONAL DELIVERY PERFORMANCE
SELECT Region,
    ROUND(AVG(DATEDIFF(Ship_Date, Order_Date)), 2) AS avg_shipping_days,
    COUNT(*) AS total_orders
FROM orders_clean
WHERE Ship_Date IS NOT NULL
GROUP BY Region
ORDER BY avg_shipping_days DESC;

-- KPI 6 — STATE-LEVEL DELAY ANALYSIS
SELECT State,
    ROUND(AVG(DATEDIFF(Ship_Date, Order_Date)), 2) AS avg_shipping_days,
    COUNT(*) AS total_orders
FROM orders_clean
WHERE Ship_Date IS NOT NULL
GROUP BY State
ORDER BY avg_shipping_days DESC LIMIT 10;

-- KPI 7 — SHIPPING MODE PROFITABILITY IMPACT
SELECT Ship_Mode,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(AVG(Profit), 2) AS avg_profit_per_order
FROM orders_clean
GROUP BY Ship_Mode
ORDER BY avg_profit_per_order DESC;

-- KPI 8 — SHIPPING DELAYS VS RETURNS
SELECT
    CASE
        WHEN DATEDIFF(o.Ship_Date, o.Order_Date) <= 3
            THEN 'Fast'
        WHEN DATEDIFF(o.Ship_Date, o.Order_Date) <= 7
            THEN 'Moderate'
        ELSE 'Delayed'
    END AS shipping_category,
    COUNT(r.Return_ID) AS total_returns,
    ROUND(AVG(r.Refund_Amount), 2) AS avg_refund_amount
FROM orders_clean o
LEFT JOIN returns_clean r
    ON o.Order_ID = r.Order_ID
WHERE o.Ship_Date IS NOT NULL
GROUP BY shipping_category;

-- KPI 9 — MONTHLY OPERATIONAL PERFORMANCE
SELECT
    YEAR(Order_Date) AS order_year,
    MONTH(Order_Date) AS order_month,
    ROUND(AVG(DATEDIFF(Ship_Date, Order_Date)), 2) AS avg_shipping_days
FROM orders_clean
WHERE Ship_Date IS NOT NULL
GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date)
ORDER BY order_year, order_month;

-- KPI 10 — HIGH-RISK DELAY ORDERS
SELECT Order_ID, Region, State,
    Ship_Mode, DATEDIFF(Ship_Date, Order_Date) AS shipping_days, Profit
FROM orders_clean
WHERE DATEDIFF(Ship_Date, Order_Date) > 10
ORDER BY shipping_days DESC;

-- KPI 11 — SHIPPING PERFORMANCE BY SALES CHANNEL
SELECT Sales_Channel,
    ROUND(AVG(DATEDIFF(Ship_Date, Order_Date)), 2) AS avg_shipping_days,
    COUNT(*) AS total_orders
FROM orders_clean
WHERE Ship_Date IS NOT NULL
GROUP BY Sales_Channel
ORDER BY avg_shipping_days;

-- KPI 12 — NULL SHIP DATE ANALYSIS
SELECT COUNT(*) AS missing_ship_dates
FROM orders_clean
WHERE Ship_Date IS NULL;

-- KPI 13 — DELIVERY SLA PERFORMANCE 
-- SLA = Service Level Agreement
SELECT Ship_Mode,
    COUNT(*) AS total_orders,
    SUM(CASE
            WHEN Ship_Mode = 'Same Day' AND DATEDIFF(Ship_Date, Order_Date) <= 1
                THEN 1
            WHEN Ship_Mode = 'Express' AND DATEDIFF(Ship_Date, Order_Date) <= 3
                THEN 1
            WHEN Ship_Mode = 'Standard' AND DATEDIFF(Ship_Date, Order_Date) <= 7
                THEN 1
            WHEN Ship_Mode = 'Economy' AND DATEDIFF(Ship_Date, Order_Date) <= 10
                THEN 1
            ELSE 0
        END) AS sla_met_orders
FROM orders_clean
WHERE Ship_Date IS NOT NULL
GROUP BY Ship_Mode;
