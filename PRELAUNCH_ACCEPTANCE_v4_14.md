# Hala v4.14 — Universal Market / Booking Integration Acceptance

## Scope
This release closes the integration gap between the Universal Market listing engine and the booking lifecycle, and tightens ledger-account visibility.

## Verified in this environment
- Node.js syntax checks for all backend services and workers.
- Frontend inline JavaScript syntax checks for customer/admin pages.
- 60/60 automated repository tests passed.
- Canonical SQL chain contains v4.14 bridge migration.
- Canonical schema has 122 pre-v4.14 tables plus the v4.14 alterations/indexes; no duplicate CREATE TABLE definitions detected by the static scan.
- Production compose excludes pilot seed and disables development identity/OTP bypass.
- Production backend is non-root and gated by database readiness.
- Universal booking accepts `universal_listing_id`, calculates price on the server from `listing_prices`, validates active market/provider membership and operation policy, creates escrow, and records lifecycle history.
- Legacy service-offer bookings remain supported.
- Booking access resolves provider ownership for both legacy offers and universal listings.
- System ledger-account balances require admin/finance access; user-owned ledger accounts remain owner-scoped.
- Customer frontend now sends universal booking requests to the real `/api/v1/bookings` endpoint after OTP authentication instead of creating only local mock orders.
- `pg@8.23.0` is the pinned PostgreSQL client version used by the backend.

## Not honestly verified here
The execution environment has no Docker, PostgreSQL/PostGIS, or network access to install npm dependencies. Therefore this report does not claim successful execution of:
- PostgreSQL/PostGIS schema application from an empty database.
- Real Queue/Workers against PostgreSQL.
- Real object storage and malware scanning.
- Real OTP/SMS provider.
- Real payment provider/webhooks/reconciliation.
- Full browser E2E across all dashboards.
- Load/concurrency testing.
- External WAF/DDoS testing and professional penetration testing.
- Backup/restore drill.

## Production gate
Do not label v4.14 Production Certified until the above environment-dependent tests pass on a real deployment candidate.
