---
# Full Stack Data System: Olist Pipeline, BI Modeling, and Automation

This project implements a full stack data system lifecycle using the Olist e-commerce dataset. It moves data from raw ingestion to a structured Gold-layer star schema, culminating in a predictive model and an automated intervention service.

[Portfolio](https://www.datascienceportfol.io/lindahkima2) | [LinkedIn](https://www.linkedin.com/in/lindah-kima/) | [Medium](https://github.com/Lindah-Kima) | [Credly](https://www.credly.com/users/lindah-kima)

---

### Pipeline Architecture

I organized the project into seven phases to ensure data integrity and system scalability.

**Phase 1: Infrastructure**
* Hosted PostgreSQL instance via Aiven.
* Used DBeaver for database administration and schema management.
* Managed credentials via `.env` and restricted sensitive files using `.gitignore`.


**Phase 2: Bronze (Raw Ingestion)**
* Ingested 9 source datasets using `VARCHAR` schemas.
* *Decision:* Loading data as `VARCHAR` prevents type-casting errors and data loss during the initial ingestion phase.


**Phase 3: Silver (Normalization)**
* Used Pandas for data profiling, outlier detection, and schema validation.
* Applied `NULLIF` patterns to clean empty strings.
* *Outcome:* Cleaned data ready for conversion to `TIMESTAMP`, `NUMERIC`, and `INTEGER` types.


**Phase 4: Gold (Dimensional Modeling)**
* Applied Kimball Star Schema modeling.
* *Decision:* Resolved many-to-many Cartesian products using SQL CTEs to create clean, BI-ready fact and dimension tables.


**Phase 5: Analytics & BI**
* Developed Power BI reports focusing on transactional velocity and time-intelligence.


**Phase 6: Predictive Pipeline**
* Built an XGBoost/Random Forest model to predict fulfillment delays.
* *Decision:* Applied SHAP values to explain model predictions, moving away from black-box results to feature-level transparency.


**Phase 7: Prescriptive Service & MLOps**
* Deployed an asynchronous FastAPI service to automate responses to delivery delays.
* *Architecture:* Containerized the app with Docker for environment consistency.
* *Agent Integration:* Used the Gemini API to handle logic/reasoning, keeping the compute footprint light and hardware-independent.
* *Execution Loop:* If the pipeline identifies a delay, the agent analyzes the customer history and executes an automated SQL update to the database.



---

### Data Accountability

I used these SQL scripts at each stage to verify data quality:

* `01_create_bronze_tables.sql`: Data ingestion from csv files to postgresql tables in the bronze layer.
* `02_validate_bronze_data.sql`: `COUNT(*)` checks to ensure row fidelity.
* `03_silver_typecast_audit.sql`: Validates successful type-conversion for analytical fields.
* `04_gold_cartesian_reconciliation.sql`: Cross-references aggregate revenue against line items to prevent metric inflation.

---

### Engineering Philosophy

* **Defensive Engineering:** Strict schema separation (Bronze/Silver/Gold) protects downstream models from upstream source changes.
* **Interpretability:** By using SHAP, I ensure every intervention can be audited and understood.
* **Automation:** The FastAPI agent bridges the gap between raw data and business action by updating the database directly based on model output.

---

### Tech Stack

* **Infrastructure:** PostgreSQL (Aiven), DBeaver
* **Data Engineering:** SQL, Python (Pandas, Scikit-Learn)
* **MLOps & Deployment:** Docker, FastAPI, Gemini API
* **Modeling:** Kimball Star Schema, XGBoost, SHAP
* **BI:** Power BI
* **Version Control:** Git, DVC

---
