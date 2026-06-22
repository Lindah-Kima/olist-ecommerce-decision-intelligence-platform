---
# Olist Decision Intelligence Platform

An end-to-end Decision Intelligence Platform that transforms raw e-commerce data into actionable business decisions using Medallion Architecture, Business Intelligence, Machine Learning, APIs, and AI-assisted decision support.

[Portfolio](https://www.datascienceportfol.io/lindahkima2) | [LinkedIn](https://www.linkedin.com/in/lindah-kima/) | [Medium](https://github.com/Lindah-Kima) | [Credly](https://www.credly.com/users/lindah-kima)

---
## Business Problem

E-commerce businesses generate vast amounts of transactional data but often struggle to answer critical operational questions:

* What is happening in the business?
* Why is it happening?
* What is likely to happen next?
* What actions should be taken?
* How can decision-making be partially automated?

This project addresses these challenges by building a production-inspired analytics platform that transforms raw operational data into trusted business intelligence, predictive insights, and decision recommendations.

---

## Solution Overview

The platform implements a complete analytical lifecycle consisting of:

* End-to-end data pipeline using Medallion Architecture (Bronze → Silver → Gold)
* Dimensional modeling using Kimball Star Schema
* Executive and operational dashboards in Power BI
* Predictive machine learning models
* REST APIs for serving predictions
* Rule-based decision intelligence
* AI-assisted business recommendations
* Containerized deployment using Docker

---

## System Architecture

```text
                                     ┌───────────────────┐
                                     │   Olist CSV Data │
                                     └─────────┬─────────┘
                                               │
                                               ▼
                          ┌─────────────────────────────┐
                          │ Bronze Layer (Raw Storage) │
                          │ PostgreSQL                 │
                          └─────────┬──────────────────┘
                                    │
                                    ▼
                       ┌───────────────────────────────┐
                       │ Silver Layer (Cleaned Data)  │
                       │ Validation + Standardization │
                       └─────────┬─────────────────────┘
                                 │
                                 ▼
                    ┌──────────────────────────────────┐
                    │ Gold Layer (Star Schema Model)  │
                    │ Fact & Dimension Tables         │
                    └───────┬──────────────────────────┘
                            │
             ┌──────────────┴──────────────┐
             ▼                             ▼
┌───────────────────────┐      ┌────────────────────────┐
│ Power BI Dashboards   │      │ Machine Learning       │
│ Executive Analytics   │      │ Delay & Risk Models    │
└───────────────────────┘      └──────────┬─────────────┘
                                          │
                                          ▼
                          ┌────────────────────────────┐
                          │ Decision Engine            │
                          │ Business Rules             │
                          └──────────┬─────────────────┘
                                     │
                                     ▼
                         ┌────────────────────────────┐
                         │ FastAPI Service            │
                         │ Prediction Endpoints       │
                         └──────────┬─────────────────┘
                                    │
                                    ▼
                     ┌────────────────────────────────┐
                     │ AI Decision Support Layer      │
                     │ Recommendation & Summarization │
                     └────────────────────────────────┘
```

---

## Data Platform Architecture

### Bronze Layer

Stores source data exactly as received.

**Key Features**

* Raw ingestion into PostgreSQL
* No transformations applied
* Source fidelity preserved
* Row count validation performed

---

### Silver Layer

Creates trusted, analytics-ready datasets.

**Implemented Transformations**

* Data type standardization
* Duplicate detection and removal
* Missing value handling
* Text normalization
* Business rule validation
* Derived metric generation

**Example Derived Features**

* `delivery_days`
* `delay_days`
* `processing_days`

**Data Quality Controls**

* Referential integrity validation
* Duplicate key detection
* Logical date validation
* Financial integrity checks
* Completeness checks

---

### Gold Layer

Creates business-ready analytical datasets optimized for reporting and machine learning.

### Dimension Tables

* `dim_customers`
* `dim_products`
* `dim_sellers`
* `dim_date`

### Fact Tables

* `fact_order_items`
* `fact_order_payments`

---

## Data Warehouse Design

The analytical warehouse follows Kimball dimensional modeling principles.

### Design Decisions

* Raw data is preserved in Bronze to maintain source fidelity.
* Silver standardizes and validates business entities before analytical consumption.
* Gold separates dimensions and facts to improve analytical performance and maintainability.
* Customer reviews are aggregated before joining transactional facts to prevent Cartesian fan-out.
* Payment transactions are stored in a separate fact table to preserve metric accuracy.

This design ensures trusted, scalable, and BI-optimized datasets.

---

## Analytics & Business Intelligence

Power BI dashboards are designed to answer strategic and operational business questions.

### Executive Dashboard

* Revenue performance
* Order trends
* Customer growth
* Regional performance

### Logistics Dashboard

* Delivery performance
* Delay trends
* Seller fulfillment efficiency

### Customer Experience Dashboard

* Customer satisfaction analysis
* Review score trends
* Repeat purchase behavior

### Seller Performance Dashboard

* Revenue contribution
* Fulfillment performance
* Operational risk analysis

### Core KPIs

* Revenue
* Orders
* Customers
* Average Order Value
* Revenue Growth
* Delay Rate
* Average Delivery Time
* Average Review Score

---

## Diagnostic Analytics

Statistical analyses are performed to identify drivers of business outcomes.

### Analyses

* Delivery delays vs customer satisfaction
* Freight costs vs customer satisfaction
* Product categories vs review scores
* Regional operational differences

### Techniques

* T-Test
* ANOVA
* Correlation Analysis

### Deliverable

**Customer Friction Report**

---

## Machine Learning

### Delivery Delay Prediction

**Business Question**

> Which orders are likely to be delayed?

**Models**

* Logistic Regression
* Random Forest
* XGBoost

**Evaluation Metrics**

* Precision
* Recall
* ROC-AUC

---

### Customer Risk Scoring

Predicts customer dissatisfaction risk.

**Outputs**

* Low Risk
* Medium Risk
* High Risk

---

### Explainability

SHAP is used to improve transparency and explain model predictions.

Benefits include:

* Feature importance analysis
* Prediction explainability
* Increased business trust

---

## Decision Intelligence Layer

Transforms predictions into recommended business actions.

| Scenario                       | Recommended Action    |
| ------------------------------ | --------------------- |
| High Value + High Delay Risk   | Retention Voucher     |
| Low Value + High Delay Risk    | Apology Communication |
| High Satisfaction + High Spend | Loyalty Campaign      |

---

## AI Decision Support Layer

A lightweight AI layer enhances business decision-making without introducing unnecessary architectural complexity.

### Capabilities

* Summarizes analytical findings into business-friendly insights
* Generates contextual recommendations for high-risk customers
* Assists interpretation of prediction results
* Supports operational decision-making

### Example Recommendation

> "Provide proactive communication and a compensation voucher to reduce customer churn risk."

**Implementation**

* Gemini API
* Prompt-based business reasoning
* Human-in-the-loop decision support

---

## API Layer

Predictions and recommendations are exposed through FastAPI.

| Endpoint                 | Description                           |
| ------------------------ | ------------------------------------- |
| `POST /predict-delay`    | Predict delayed orders                |
| `POST /customer-risk`    | Predict customer dissatisfaction risk |
| `POST /recommend-action` | Generate business recommendations     |

Interactive API documentation is available through Swagger UI.

---

## Repository Structure

```text
olist-decision-intelligence-platform/
│
├── data/
│   ├── raw/
│   ├── processed/
│   └── features/
│
├── sql/
│   ├── bronze/
│   ├── silver/
│   ├── gold/
│
├── notebooks/
│   ├── exploratory/
│   ├── modeling/
│   └── validation/
│
├── src/
│   ├── data/
│   ├── features/
│   ├── models/
│   ├── inference/
│   └── utils/
│
├── api/
├── agents/
├── dashboard/
├── docs/
├── tests/
├── docker/
│
├── requirements.txt
├── Dockerfile
├── .env.example
└── README.md
```

---

## Documentation

Additional project documentation:

* `docs/project_roadmap.md`
* `docs/data_dictionary.md`
* `docs/project_log.md`
* `docs/architecture.md`

---

## How to Run

### Clone Repository

```bash
git clone https://github.com/Lindah-Kima/olist-ecommerce-decision-intelligence-platform.git

cd olist_decision_intelligence_platform
```

### Create Virtual Environment

```bash
python -m venv .venv
```

Activate environment:

**Windows**

```bash
.venv\Scripts\activate
```

**Linux / Mac**

```bash
source .venv/bin/activate
```

Install dependencies:

```bash
pip install -r requirements.txt
```

---

### Configure Environment Variables

Create a `.env` file:

```env
DB_HOST=
DB_PORT=
DB_NAME=
DB_USER=
DB_PASSWORD=

GEMINI_API_KEY=
```

---

## Running Project Components

### Data Platform

Execute SQL scripts sequentially:

```text
sql/bronze/
sql/silver/
sql/gold/
```

### Analytics

Open Power BI Desktop and connect to Gold-layer tables.

### Machine Learning

```bash
python src/models/train_delay_model.py

python src/models/train_customer_risk_model.py
```

### API Service

```bash
uvicorn api.main:app --reload
```

Swagger documentation:

```text
http://localhost:8000/docs
```

### AI Decision Support

```bash
python agents/recommend_actions.py
```

### Docker Deployment

Build image:

```bash
docker build -t olist-platform .
```

Run container:

```bash
docker run -p 8000:8000 olist-platform
```

---

## Tech Stack

### Data Engineering

* PostgreSQL
* SQL
* Pandas
* Medallion Architecture

### Analytics

* Power BI
* DAX

### Machine Learning

* Scikit-learn
* XGBoost
* SHAP

### API Development

* FastAPI

### AI

* Gemini API

### Deployment

* Docker

### Version Control

* Git
* GitHub

---

## Key Engineering Decisions

* Adopted Medallion Architecture to improve maintainability and data quality.
* Implemented Kimball dimensional modeling to optimize analytical performance.
* Applied comprehensive data quality audits to validate referential, financial, and temporal integrity.
* Designed multiple fact tables to eliminate Cartesian fan-out risks and preserve metric accuracy.
* Used SHAP to improve model interpretability and transparency.
* Exposed predictions through FastAPI to support operational integration.
* Containerized services using Docker for portability and reproducibility.
* Added lightweight AI-assisted decision support to bridge analytics and business action.

---

## Future Enhancements

* Automated data quality testing using Great Expectations
* Workflow orchestration using Apache Airflow
* CI/CD pipeline implementation
* Automated model retraining
* Data and model drift monitoring
* Real-time data ingestion
* Feature store implementation
* Multi-agent decision support workflows

---

## Project Status

| Component           | Status         |
| ------------------- | -------------- |
| Bronze Layer        | Completed    |
| Silver Layer        | Completed |
| Gold Layer          | Completed |
| Power BI Dashboards | In Progress     |
| Machine Learning    | Planned      |
| API Development     | Planned      |
| Docker Deployment   | Planned      |
| AI Decision Support | Planned      |

---

## Engineering Philosophy

> Build foundations before intelligence.

This project prioritizes reproducibility, maintainability, explainability, and business value while treating the solution as a product rather than a collection of notebooks.
