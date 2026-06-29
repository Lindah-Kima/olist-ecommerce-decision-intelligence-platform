# Power BI Dashboard Wireframes

## Overview

The Power BI reporting layer follows an executive-focused design approach where each dashboard answers specific business questions and supports operational decision-making.

All report pages follow a consistent layout consisting of:

1. Global Filters
2. KPI Summary Cards
3. Trend Analysis
4. Performance Breakdown Visuals
5. Detailed Analysis Tables

---

# Global Filters

The following slicers are available across all report pages:

* Order Date
* Customer State
* Seller State
* Product Category
* Seller

---

# Dashboard 1: Executive Overview

## Objective

Provide executives with a consolidated view of business performance.

## Page Layout

### Top Section

**KPI Cards**

* Total Revenue
* Total Orders
* Total Customers
* Average Order Value
* Revenue Growth %

### Middle Section

**Trend Analysis**

* Monthly Revenue Trend (Line Chart)

### Lower Section

**Performance Breakdown**

* Revenue by State (Map)
* Revenue by Product Category (Bar Chart)
* Top Categories by Revenue (Column Chart)

### Bottom Section

**Detailed Analysis**

* Revenue Summary Table

  * State
  * Revenue
  * Orders
  * Customers

---

# Dashboard 2: Logistics Performance

## Objective

Monitor delivery performance and identify logistics inefficiencies.

## Page Layout

### Top Section

**KPI Cards**

* Average Delivery Time
* Delay Rate %
* Average Delay Days
* On-Time Delivery Rate %

### Middle Section

**Trend Analysis**

* Delivery Trend Over Time (Line Chart)
* Delay Trend Over Time (Line Chart)

### Lower Section

**Performance Breakdown**

* Delay Rate by State (Map)
* Delay Rate by Product Category (Bar Chart)
* Top Sellers Causing Delays (Bar Chart)
* Delivery Time Distribution (Histogram)

### Bottom Section

**Detailed Analysis**

* Seller Logistics Performance Table

  * Seller
  * Orders
  * Delay Rate %
  * Average Delivery Days

---

# Dashboard 3: Customer Experience

## Objective

Understand customer satisfaction and loyalty behavior.

## Page Layout

### Top Section

**KPI Cards**

* Average Review Score
* Positive Review Rate %
* Negative Review Rate %
* Repeat Purchase Rate %

### Middle Section

**Trend Analysis**

* Review Score Trend Over Time (Line Chart)

### Lower Section

**Performance Breakdown**

* Review Score Distribution (Histogram)
* Review Score by Product Category (Bar Chart)
* Delay vs Review Relationship (Scatter Plot)
* Customer Satisfaction by State (Map)

### Bottom Section

**Detailed Analysis**

* Customer Satisfaction Summary Table

---

# Dashboard 4: Seller Performance

## Objective

Evaluate seller contribution, operational efficiency, and risk.

## Page Layout

### Top Section

**KPI Cards**

* Total Sellers
* Average Seller Revenue
* Average Seller Delay Rate %
* Average Seller Review Score

### Middle Section

**Trend Analysis**

* Seller Revenue Trend (Line Chart)

### Lower Section

**Performance Breakdown**

* Top Sellers by Revenue (Bar Chart)
* Orders by Seller (Bar Chart)
* Seller Delay Ranking (Bar Chart)
* Seller Review Ranking (Bar Chart)

### Advanced Analysis

**Seller Risk Matrix (Scatter Plot)**

* X-Axis: Delay Rate %
* Y-Axis: Average Review Score
* Bubble Size: Revenue

### Bottom Section

**Detailed Analysis**

* Seller Performance Summary Table

---

# Design Principles

* Maintain a consistent layout across all report pages.
* Use KPI cards to summarize performance.
* Prioritize trend analysis before detailed breakdowns.
* Enable interactive filtering through slicers and cross-filtering.
* Use color semantics consistently:

  * Green: Positive performance
  * Red: Risk or poor performance
  * Blue: Neutral metrics
  * Gray: Benchmarks and targets

---

# Report Navigation

1. Executive Overview
2. Logistics Performance
3. Customer Experience
4. Seller Performance

The reporting layer is designed to support descriptive and diagnostic analytics while enabling business stakeholders to monitor performance and make informed decisions.
