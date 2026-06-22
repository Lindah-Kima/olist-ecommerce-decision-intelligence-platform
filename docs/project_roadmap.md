# Olist Decision Intelligence Platform Roadmap

## Project Vision

Build a production-inspired Decision Intelligence Platform that transforms raw e-commerce data into trusted analytics, predictive insights, and business recommendations through an integrated Data Engineering, Analytics, Machine Learning, and AI stack.

---

# Current Status

| Area                  | Status         |
| --------------------- | -------------- |
| Repository Foundation | Completed    |
| Bronze Layer          | Completed    |
| Silver Layer          | Completed |
| Gold Layer            | Completed |
| Power BI              | In Progress      |
| Machine Learning      | Planned      |
| API Development       | Planned      |
| Docker Deployment     | Planned      |
| AI Decision Support   | Planned      |

**Current Phase:** Data Engineering Platform

**Current Focus**

* Complete Silver Layer
* Complete Gold Layer
* Validate analytical model
* Build Power BI semantic model

---

# Business Problem

Modern e-commerce organizations need to answer five critical business questions:

1. What happened?
2. Why did it happen?
3. What is likely to happen next?
4. What action should be taken?
5. How can decisions be partially automated?

This platform is designed to answer all five questions within a single integrated system.

---

# Strategic Objectives

## Data Engineering

* Build a trusted analytical warehouse using PostgreSQL.
* Implement Medallion Architecture (Bronze, Silver, Gold).
* Establish data quality, governance, and validation processes.

## Analytics

* Deliver executive and operational dashboards.
* Create standardized business metrics and KPIs.
* Generate actionable business insights.

## Data Science

* Perform exploratory, diagnostic, and statistical analysis.
* Build predictive machine learning models.
* Implement model explainability.

## Software Engineering

* Develop REST APIs using FastAPI.
* Apply modular project architecture and Git workflows.

## Deployment

* Containerize applications using Docker.
* Deploy production-style services.

## AI

* Implement lightweight AI-assisted decision support.

---

# Technology Stack

| Domain                  | Technologies                |
| ----------------------- | --------------------------- |
| Cloud Database          | Aiven PostgreSQL            |
| Database Administration | DBeaver                     |
| Data Processing         | SQL, Python, Pandas         |
| Analytics               | Power BI, DAX               |
| Machine Learning        | Scikit-learn, XGBoost, SHAP |
| API Development         | FastAPI                     |
| Deployment              | Docker                      |
| AI                      | Gemini API                  |
| Version Control         | Git, GitHub                 |
| Development Environment | VS Code                     |

---

# High-Level Architecture

```text
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
Analytics & Experimentation
   ↓
Machine Learning
   ↓
Decision Engine
   ↓
FastAPI
   ↓
Docker Deployment
   ↓
AI Decision Support
```

---

# Phase 0: Project Foundation

## Goal

Establish professional engineering standards before development begins.

### Deliverables

* Repository structure
* Modular project architecture
* Git branching strategy
* Data dictionary
* Project journal
* Architecture documentation
* Coding standards
* Acceptance criteria

### Success Criteria

* Repository structure finalized.
* Documentation standards established.
* Development workflow documented.

---

# Phase 1: Data Engineering Platform

## Goal

Build a trusted analytical warehouse using Medallion Architecture.

---

## Bronze Layer

### Objective

Store source data exactly as received.

### Deliverables

* Bronze schema creation
* Raw data ingestion pipelines
* Row count validation
* Backup procedures
* Source audit checks

### Success Criteria

* All datasets loaded successfully.
* Row counts match source files.
* No source data loss detected.

---

## Silver Layer

### Objective

Create clean, validated, analytics-ready datasets.

### Deliverables

* Data type standardization
* Missing value handling
* Duplicate removal
* Business rule validation
* Derived feature generation

### Example Features

* `delivery_days`
* `delay_days`
* `processing_days`

### Data Quality Controls

* Referential integrity validation
* Duplicate detection
* Logical date validation
* Financial integrity checks
* Completeness checks

### Success Criteria

* Data quality checks pass.
* Business rules validated.
* Analytical fields generated successfully.

---

## Gold Layer

### Objective

Create business-ready analytical datasets optimized for reporting and machine learning.

### Deliverables

#### Dimension Tables

* `dim_customers`
* `dim_products`
* `dim_sellers`
* `dim_date`

#### Fact Tables

* `fact_order_items`
* `fact_order_payments`

#### Aggregated Metrics

* Customer metrics
* Seller metrics
* Delivery metrics

### Success Criteria

* Star schema validated.
* No metric inflation detected.
* Power BI model consumes Gold tables successfully.

---

# Phase 1.5: Data Governance & Warehouse Quality

## Goal

Ensure warehouse trust, consistency, and reproducibility.

### Deliverables

* Data dictionary
* Business glossary
* Source-to-target mapping
* Metric definitions document
* Data quality audit scripts
* Referential integrity documentation

### Success Criteria

* All business metrics documented.
* Quality tests pass successfully.
* Warehouse lineage documented.

---

# Phase 2: Business Intelligence

## Goal

Deliver executive-level reporting and operational monitoring.

### Dashboards

#### Executive Dashboard

Focus Areas:

* Revenue
* Orders
* Customers
* Average Order Value
* Growth Trends

#### Logistics Dashboard

Focus Areas:

* Delivery performance
* Delay trends
* Seller logistics performance

#### Customer Experience Dashboard

Focus Areas:

* Review scores
* Customer satisfaction
* Repeat purchase behavior

#### Seller Performance Dashboard

Focus Areas:

* Seller revenue
* Fulfillment performance
* Operational risk

### Success Criteria

* Dashboards validated.
* KPIs documented.
* Business questions answered.

---

# Phase 3: Analytics & Experimentation

## Goal

Identify drivers of business performance and customer experience.

### Exploratory Analysis

Investigate:

* Delivery delays
* Customer reviews
* Freight costs
* Product categories
* Seller performance
* Geographic trends

### Statistical Analysis

#### T-Test

Delivery delays vs customer satisfaction.

#### ANOVA

Product categories vs customer satisfaction.

#### Correlation Analysis

Freight costs vs customer satisfaction.

### Deliverable

**Customer Friction Report**

### Success Criteria

* Statistical findings documented.
* Key business drivers identified.

---

# Phase 4: Machine Learning

## Goal

Predict operational and customer risks.

---

## Model 1: Delivery Delay Prediction

### Business Question

Which orders are likely to be delayed?

### Algorithms

* Logistic Regression
* Random Forest
* XGBoost

### Evaluation Metrics

* Precision
* Recall
* ROC-AUC

### Explainability

* SHAP

---

## Model 2: Customer Risk Scoring

### Business Question

Which customers are at risk of dissatisfaction?

### Outputs

* Low Risk
* Medium Risk
* High Risk

### Success Criteria

* Models evaluated and documented.
* Explainability implemented.
* Business utility demonstrated.

---

# Phase 5: Decision Intelligence

## Goal

Convert predictions into recommended business actions.

### Example Recommendations

| Scenario                       | Recommended Action    |
| ------------------------------ | --------------------- |
| High Value + High Delay Risk   | Retention Voucher     |
| Low Value + High Delay Risk    | Apology Communication |
| High Satisfaction + High Spend | Loyalty Campaign      |

### Success Criteria

* Rules documented.
* Recommendation logic validated.

---

# Phase 6: API Development

## Goal

Expose predictions and recommendations through REST APIs.

### Endpoints

* `POST /predict-delay`
* `POST /customer-risk`
* `POST /recommend-action`

### Deliverables

* FastAPI application
* Swagger documentation
* Request validation
* Error handling

### Success Criteria

* APIs tested successfully.
* Endpoints documented.

---

# Phase 7: Deployment

## Goal

Package and deploy production-style services.

### Deliverables

* Dockerized application
* Environment configuration
* Hosted API
* Deployment documentation

### Success Criteria

* Application deployed successfully.
* Environment reproducibility confirmed.

---

# Phase 8: AI Decision Support

## Goal

Enhance decision-making using lightweight AI assistance.

### Operations Agent

Identifies operational risks requiring intervention.

### Customer Recovery Agent

Recommends retention actions for at-risk customers.

### Executive Insights Agent

Summarizes business trends, opportunities, and risks.

### Success Criteria

* AI recommendations generated successfully.
* Recommendations support business decision-making.

---

# Phase 9: Documentation & Communication

## Goal

Produce professional documentation and portfolio assets.

### Deliverables

* Data Dictionary
* Architecture Diagrams
* Technical Documentation
* Model Evaluation Report
* Executive Summary Report
* Portfolio Case Study
* LinkedIn Showcase

### Success Criteria

* Project fully documented.
* Project reproducible end-to-end.

---

# Definition of Done

The project is considered complete when:

* Medallion Architecture is implemented.
* Gold layer is production-ready.
* Dashboards answer core business questions.
* Statistical analyses are documented.
* Machine learning models are deployed.
* Recommendation engine is operational.
* APIs are publicly accessible.
* Application is containerized.
* AI-assisted recommendations are functioning.
* Documentation is complete.
* The entire platform is reproducible.

---

# Guiding Principles

1. Build foundations before intelligence.
2. Complete each phase before moving forward.
3. Prioritize business value over complexity.
4. Document important decisions.
5. Keep solutions simple and maintainable.
6. Focus on reproducibility and scalability.
7. Treat the project as a product, not a collection of notebooks.
