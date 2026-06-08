## 2026-06-08

### Challenge

Missing delivery dates in orders table.

### Investigation

Found cancelled orders have no delivery date.

### Decision

Keep records and flag them instead of deleting.

### Reason

Deleting would distort cancellation metrics.