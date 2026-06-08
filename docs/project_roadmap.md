# Olist Ecommerce Decision Intelligence Platform

## Project Overview

The Olist Ecommerce Decision Intelligence Platform is an end-to-end data project that transforms raw Olist e-commerce data into analytics, predictions, recommendations, and business actions.

The project demonstrates the complete data lifecycle across Data Engineering, Analytics, Data Science, Machine Learning, API Development, Deployment, and AI-assisted decision support.

---

## Current Status

Current Phase: Phase 1 — Data Engineering Platform

### Current Focus

- Complete Bronze Layer
- Build Silver Layer
- Build Gold Layer
- Create Power BI Data Model

### Next Milestone

Bronze Layer Completed

---

# Business Problem

E-commerce organizations need to answer five critical questions:

1. What happened?
2. Why did it happen?
3. What is likely to happen next?
4. What action should be taken?
5. How can decision-making be partially automated?

This platform is designed to answer all five.

---

# Project Objectives

## Data Engineering

* Build a PostgreSQL-based analytical platform
* Implement Medallion Architecture (Bronze, Silver, Gold)
* Apply data quality and validation processes

## Analytics

* Develop executive Power BI dashboards
* Create business KPIs and performance metrics
* Deliver actionable business insights

## Data Science

* Perform exploratory and diagnostic analysis
* Conduct statistical testing
* Build predictive machine learning models

## Software Engineering

* Develop REST APIs using FastAPI
* Apply Git workflow and project organization standards

## Deployment

* Containerize applications using Docker
* Deploy production-style services

## AI

* Implement AI-assisted business decision support

---

# Technology Stack

| Area | Tools |
|--------|--------|
| Cloud Database | Aiven PostgreSQL |
| Database Management | DBeaver |
| Data Processing | Python, SQL, Pandas |
| Analytics | Power BI, DAX |
| Machine Learning | Scikit-learn, SHAP |
| API Development | FastAPI |
| Containerization | Docker |
| Version Control | Git, GitHub |
| Development Environment | VS Code |

---

# Project Architecture

Raw Data

↓

Bronze Layer

↓

Silver Layer

↓

Gold Layer

↓

Business Intelligence

↓

Machine Learning

↓

Decision Engine

↓

FastAPI

↓

Docker

↓

Deployment

↓

AI Decision Support

---

# Phase 0: Project Foundation

## Goal

Establish professional project standards before development begins.

### Deliverables

* Repository structure
* Git workflow
* Feature branch strategy
* Data dictionary
* Project journal
* Architecture documentation
* Acceptance criteria

---

# Phase 1: Data Engineering Platform

## Goal

Build a trusted analytical data warehouse.

### Bronze Layer

Store source data exactly as received.

#### Deliverables

* Bronze schema
* Raw data ingestion pipelines
* Row count validation
* Backup procedures

### Silver Layer

Create clean and validated business data.

#### Deliverables

* Data quality checks
* Missing value handling
* Duplicate validation
* Business rule validation
* Derived metrics

Example metrics:

* delivery_days
* delay_days
* processing_days

### Gold Layer

Create business-ready analytical datasets.

#### Deliverables

##### Fact Tables

* fact_orders

##### Dimension Tables

* dim_customers
* dim_products
* dim_sellers
* dim_dates
* dim_geography

##### Metrics Tables

* customer_metrics
* seller_metrics
* delivery_metrics

---

# Phase 2: Business Intelligence

## Goal

Deliver executive-level reporting and monitoring.

### Executive Performance Dashboard

Focus Areas:

* Revenue
* Orders
* Customers
* Average Order Value
* Growth Trends

### Logistics Dashboard

Focus Areas:

* Delivery Performance
* Delay Trends
* Seller Logistics Performance

### Customer Experience Dashboard

Focus Areas:

* Review Scores
* Customer Satisfaction
* Repeat Purchase Behaviour

### Seller Performance Dashboard

Focus Areas:

* Seller Revenue
* Fulfillment Performance
* Operational Risk

---

# Phase 3: Analytics & Experimentation

## Goal

Identify drivers of business performance and customer experience.

### Exploratory Data Analysis

Investigate:

* Delivery delays
* Customer reviews
* Freight costs
* Product categories
* Seller performance
* Geographic patterns

### Statistical Analysis

#### T-Test

Delivery delays vs customer satisfaction

#### ANOVA

Product categories vs customer satisfaction

#### Correlation Analysis

Freight costs vs customer satisfaction

### Deliverable

Customer Friction Report

---

# Phase 4: Machine Learning

## Goal

Predict operational and customer risks.

### Model 1 — Delivery Delay Prediction

Business Question:

Which orders are likely to be delayed?

#### Algorithms

* Logistic Regression
* Random Forest
* XGBoost (Optional)

#### Evaluation Metrics

* Recall
* Precision
* ROC-AUC

#### Explainability

* SHAP

### Model 2: Customer Risk Scoring

Business Question:

Which customers are at risk of dissatisfaction?

#### Outputs

* Low Risk
* Medium Risk
* High Risk

---

# Phase 5: Decision Intelligence

## Goal

Convert predictions into recommended business actions.

### Example Recommendations

| Scenario                       | Recommended Action    |
| ------------------------------ | --------------------- |
| High Value + High Delay Risk   | Voucher               |
| Low Value + High Delay Risk    | Apology Communication |
| High Satisfaction + High Spend | Loyalty Campaign      |

---

# Phase 6: API Development

## Goal

Expose predictions and recommendations through APIs.

### Endpoints

* POST /predict-delay
* POST /customer-risk
* POST /recommend-action

### Deliverables

* FastAPI application
* Swagger documentation
* Input validation
* Error handling

---

# Phase 7: Deployment

## Goal

Make the platform publicly accessible.

### Deliverables

* Dockerized application
* Environment configuration
* Hosted API
* Public GitHub repository

---

# Phase 8: AI Decision Support

## Goal

Provide AI-assisted business recommendations.

### Operations Agent

Identifies high-risk orders requiring intervention.

### Customer Recovery Agent

Recommends retention strategies.

### Executive Insights Agent

Summarizes business trends, opportunities, and risks.

---

# Phase 9: Documentation & Communication

## Goal

Create professional project documentation and portfolio assets.

### Deliverables

* Data Dictionary
* Project Journal
* Architecture Diagrams
* Technical Documentation
* Model Evaluation Report
* Executive Summary Report
* Portfolio Case Study
* LinkedIn Project Showcase

---

# Success Criteria

The project is considered successful when:

* Medallion Architecture is implemented
* Executive dashboards are completed
* Statistical findings are documented
* Machine learning models are deployed
* Recommendation engine is operational
* APIs are publicly accessible
* Application is containerized
* Documentation is complete
* Project is fully reproducible

---

# Guiding Principles

1. Build foundations before intelligence.
2. Complete each phase before moving forward.
3. Prioritize business value over complexity.
4. Document important decisions.
5. Keep solutions simple and maintainable.
6. Focus on reproducibility and scalability.
7. Treat the project as a product, not a notebook.
