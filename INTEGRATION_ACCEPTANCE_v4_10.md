# Hala v4.10 — Integration & Pre-Launch Acceptance Report

## Scope
This release was reviewed as one connected system: canonical PostgreSQL/PostGIS schema, backend/API, workers, customer portal, market shell, admin Market Builder, payment/escrow/ledger paths, and Hala Central Intelligence supervision.

## Verified in the current environment
- Backend automated tests: **41/41 passed**.
- All backend `.mjs` files passed Node syntax checks.
- Inline JavaScript in customer market and offline demo passed syntax checks.
- Docker Compose YAML parsed successfully.
- Canonical SQL transaction count is balanced: **10 BEGIN / 10 COMMIT**.
- Canonical schema has no duplicate `CREATE TABLE` definitions.
- Required market, demand, listing, supervisor, webhook, OTP, and provider-application objects are present.
- Nginx customer/admin configurations pass `nginx -t` when evaluated inside a valid `http/server` wrapper; Docker service-name DNS is expected to resolve `backend` inside the Compose network.
- Real HTTP smoke test: `/health` returned **200** with backend v4.10.0.
- `/ready` correctly returned **503** in this environment because PostgreSQL/driver are unavailable, proving readiness is not falsely reported as healthy.
- Unsigned payment webhook was rejected with **401**.
- Protected wallet endpoint without authentication was rejected with **401**.
- Oversized JSON request was rejected with **413**.
- Production settings explicitly disable development actor/OTP bypass.
- Sensitive provider creation was changed to application + explicit admin approval.
- Payment webhook worker now uses the same settlement transaction path as privileged manual verification for verified/failed events.
- Every market remains bound to `platform_supervisor` with `INHERIT_AND_RESTRICT`.
- Provider applications, OTP IP throttling/cooldown, DB readiness, logout/session revocation, and non-root Node execution were added.

## Not yet honestly certifiable from this environment
The following require actual runtime infrastructure and cannot be simulated by static tests:
1. PostgreSQL/PostGIS migration from an empty volume, including every FK/check/index/extension at runtime.
2. Full booking journey with real persisted records and concurrency.
3. Real payment provider sandbox, signed webhooks, retries, reconciliation and refund provider flows.
4. Real queue/worker processing against PostgreSQL.
5. Real object storage and malware scanning.
6. Real SMS/OTP delivery.
7. Backup/restore drill.
8. Load, race-condition and soak testing.
9. External WAF/DDoS controls and a professional penetration test.
10. Live technology/security intelligence feeds for Hala Central Intelligence.

## Release rule
This package is a **pre-production integrated build**, not a statement of zero vulnerabilities. Production launch requires running `START_REAL_PRELAUNCH.sh` on a host with Docker and outbound access as appropriate, then completing the runtime E2E/payment/security gates above.
