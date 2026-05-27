# RetailNova Enterprise Analytics Platform

An enterprise-scale retail analytics platform built using SQL, Python, and Power BI to simulate real-world business intelligence workflows for a multi-channel retail company.

---

# Project Overview

RetailNova Pvt Ltd is a simulated retail and e-commerce company operating across multiple regions and product categories.

The company faced several business challenges despite increasing sales:

- unstable profitability
- rising product returns
- high discount dependency
- regional operational inefficiencies
- logistics bottlenecks
- inconsistent customer retention

This project was designed to simulate how real analysts work inside enterprise environments using:

- SQL Analytics
- Python Analytics
- Power BI Dashboards
- Data Engineering Workflows
- Executive Reporting

---

# Business Objectives

The analytics platform was developed to:

- identify profitability issues
- optimize discount strategies
- monitor logistics performance
- analyze customer behavior
- track return-related losses
- evaluate supplier efficiency
- build executive decision dashboards

---

# Tech Stack

| Technology | Purpose |
|---|---|
| MySQL | Data storage & analytics |
| Python | Data analysis & EDA |
| Pandas | Data manipulation |
| Matplotlib | Visualization |
| Power BI | Executive dashboards |
| CSV | Enterprise datasets |

---

# Project Architecture

```text
RetailNova-Enterprise-Analytics/
│
├── datasets/
├── sql/
├── python/
├── powerbi/
└── README.md
```
# Dataset Architecture
### 1. orders.csv
Main transactional dataset containing:
- orders
- revenue
- discounts
- profits
- shipping
- regions
- payment modes
### 2. customers.csv

Customer master dataset containing:
- demographics
- acquisition channels
- loyalty tiers
- locations
### 3. products.csv

Product catalog dataset containing:

- categories
-suppliers
- manufacturing cost
- retail pricing
### 4. returns.csv

Return management dataset containing:

- return reasons
- refund amounts
- return status

# Data Engineering Workflow

The project intentionally simulated real-world enterprise data challenges:
- missing values
- duplicate records
- delayed shipments
- high-discount orders
- loss-making products
- inconsistent customer behavior
- operational anomalies

Data engineering tasks included:

- CSV validation
- staging table loading
- null analysis
- data cleaning
- schema validation
- SQL import optimization
# SQL Analytics

The SQL analytics layer included:

- profitability analysis
- customer segmentation
- return analysis
- regional analysis
- logistics intelligence
- discount impact analysis
- supplier performance analysis

Key SQL operations used:

- JOINs
- CTEs
- aggregations
- window functions
- CASE statements
- KPI calculations
# Python Analytics

Python analysis included:

- exploratory data analysis
- trend analysis
- correlation analysis
- anomaly detection
- KPI calculations
- operational insights
- executive storytelling

Libraries used:

- pandas
- matplotlib
- numpy
# Power BI Dashboard

The Power BI solution contains 6 enterprise dashboard pages.

### Dashboard Pages
#### 1. Executive Overview
High-level business health monitoring.

#### 2. Revenue & Profitability

Financial and margin intelligence.

#### 3. Customer Intelligence

Retention, loyalty, and customer analytics.

#### 4. Returns & Refunds

Operational dissatisfaction and refund leakage analysis.

#### 5. Operations & Logistics

Shipping efficiency and fulfillment intelligence.

#### 6. Product & Supplier Analytics

Supplier performance and product optimization insights.

# Key Business Insights
- High discount campaigns reduced overall profitability.
- Fashion products generated elevated return rates.
- Delivery delays increased customer dissatisfaction.
- Premium customers contributed significantly to revenue.
- Supplier profitability varied across categories.
- Logistics inefficiencies impacted operational performance.
# Executive Recommendations
- Reduce excessive discount dependency.
- Optimize pricing for loss-making products.
- Improve regional logistics operations.
- Strengthen supplier quality monitoring.
- Launch customer retention campaigns.
- Monitor high-refund operational anomalies.
# KPIs Tracked
- Total Revenue
- Total Profit
- Profit Margin %
- Return Rate %
- Average Order Value
- SLA Compliance %
- Customer Lifetime Value
- Refund Loss %
- Delayed Orders
- Supplier Profitability
# Dashboard Features
- Executive KPI Cards
- Interactive Filters
- Regional Analysis
- Customer Intelligence
- Operational Risk Monitoring
- Profitability Analytics
- Dynamic DAX Measures
- Strategic Insight Panels
# Learning Outcomes

This project helped simulate:

- enterprise analytics workflows
- real-world data engineering
- business intelligence reporting
- executive dashboard development
- strategic business analysis
- operational intelligence systems
# Author
Sachin Singh Tanwar
