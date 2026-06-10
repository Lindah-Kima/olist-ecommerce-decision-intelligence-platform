### Data Ingestion – Bronze Layer (Olist Dataset)

**Status:** Resolved
**Category:** Data Engineering | ETL | Troubleshooting

#### Challenge 1: Customer Data Import Stalling

**Problem**
Customer data ingestion repeatedly stalled at approximately 70,000 records during bulk loading.

**Resolution**

* Reduced batch commit size to improve transaction stability.
* Validated destination schema and column constraints.
* Used **Truncate before load** to eliminate potential key conflicts.
* Verified record counts and reviewed load logs after ingestion.

**Outcome**
Successfully loaded the complete customer dataset and validated all records.

---

#### Challenge 2: Parsing Unstructured Order Reviews Data

**Problem**
Review data import failed due to Portuguese text fields containing backslashes (`\`), escaped quotes, blank values, and multi-line comments, resulting in parser validation errors, column misalignment, and DBeaver NPE crashes.

**Resolution**

* Changed `review_comment_title` and `review_comment_message` from `VARCHAR` to `TEXT`.
* Disabled **Set empty strings to NULL** to prevent parser crashes.
* Enabled **Trim whitespace** during ingestion.
* Configured custom quote and escape characters to preserve literal backslashes and correctly parse quoted text.

**Outcome**
Successfully ingested review data while preserving original text content and structure.

---