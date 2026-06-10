### Technical decisions Notes – Bronze Layer Ingestion Challenges

#### Why change `VARCHAR` to `TEXT`?

Review comments contained unpredictable free-form customer text, including multiline content and special characters. Using `TEXT` removed length limitations and reduced the risk of import failures caused by oversized values.

#### Why disable "Set empty strings to NULL"?

DBeaver was throwing Null Pointer Exceptions (NPEs) when processing blank review fields. Disabling this setting prevented the parser from incorrectly handling empty values during import.

#### Why enable "Trim whitespace"?

To remove leading and trailing spaces that could trigger validation issues or create inconsistent text values in the Bronze layer.

#### Why set Quote Character = `"` and Escape Character = `#`?

The source data contained literal backslashes (`\`) and embedded quotes. Using a dummy escape character (`#`) prevented DBeaver from interpreting backslashes as escape sequences, allowing the data to load without altering the original text.

#### Why reduce the batch commit size?

Large transactions were causing the import to stall around 70k records. Smaller commit batches reduced transaction overhead and improved load stability.

#### Why validate schema constraints and column lengths?

To ensure incoming data matched the destination table structure and avoid hidden load failures caused by datatype or length mismatches.

#### Why use "Truncate before load"?

To guarantee a clean reload and eliminate potential conflicts from previously loaded records.

#### How was the fix validated?

Compared imported record counts against source files and reviewed DBeaver import logs to confirm successful ingestion.
