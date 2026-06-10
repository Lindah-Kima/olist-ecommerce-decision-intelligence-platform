### Data Ingestion – Bronze Layer (Olist Dataset)

**Status:** Resolved

**Category:** Data Engineering | ETL | Troubleshooting

#### Challenge 1: Customer Data Import Stalling

**Problem**
Customer data ingestion repeatedly stalled at ~70,000 records during bulk loading.

**Resolution**

* Reduced **Commit after row insert** batch size from 10000 to 1000 to improve transaction stability.
* Validated schema constraints and column lengths.
* Used **Truncate before load** to eliminate potential key conflicts.
* Verified ingestion using record counts and import logs.

**Outcome**
Successfully loaded and validated the complete customer dataset.

---

#### Challenge 2: Parsing Unstructured Order Reviews Data

**Problem**
Review data import failed due to Portuguese review comments containing backslashes (`\`), escaped quotes, blank values, and multi-line text, causing parser validation errors, column misalignment, and DBeaver NPE crashes.

**Resolution**

* Changed `review_comment_title` and `review_comment_message` from `VARCHAR` to `TEXT`.
* Disabled **Set empty strings to NULL**.
* Enabled **Trim whitespace**.
* Set **Quote Character** = `"` and **Escape Character** = `#` to preserve literal backslashes and correctly parse quoted text.

**Outcome**
Successfully loaded review data while preserving original text structure.

---


