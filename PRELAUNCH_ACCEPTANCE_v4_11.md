# Hala v4.12 — Pre-Launch Acceptance Report

## Completed and verified in this environment
- Canonical PostgreSQL/PostGIS schema chain includes v4.12 resilience migration.
- Production compose no longer loads pilot seed data.
- Pilot seed is explicitly separated into `infra/docker/docker-compose.pilot.yml`.
- Backend source syntax check: passed for all `src` and `tests` `.mjs` files.
- Automated test suite: **49/49 passed**.
- HTTP process smoke test: `/health` returned 200 and version `4.12.0`.
- Protected API without a session returned 401.
- `/ready` correctly returned 503 when PostgreSQL is unavailable; the service does not falsely claim readiness.
- Booking access was tightened to customer/provider/privileged scope and no longer exposes booking existence to unauthorized callers.
- Global portal provider advertising now requires an active provider membership in the target market.
- Payment webhook worker now supports bounded retries/backoff and moves poison events to human review after the limit.
- Central supervisor worker records platform health telemetry snapshots.
- Production UI ports are bound to loopback in the pre-launch compose file.
- Backend and workers are configured with `no-new-privileges`; backend/workers drop Linux capabilities.

## Not yet executable in this environment
The current execution environment has no Docker daemon, no PostgreSQL/PostGIS server, and the `pg` npm package cannot be installed because package download times out here. Therefore the following cannot honestly be marked PASS here:
- Fresh PostgreSQL/PostGIS initialization from an empty volume.
- Actual SQL execution and constraint/index validation against PostgreSQL.
- End-to-end OTP/SMS flow with a real provider.
- Real payment gateway + signed webhook + settlement/reconciliation.
- Queue/worker execution against the real database.
- Object storage + file malware scanning.
- Backup/restore drill.
- Concurrent load/lock/race testing.
- External WAF/DDoS behavior.
- Professional penetration testing.

## Production blockers
1. Run the clean production compose on a host with Docker + PostgreSQL/PostGIS.
2. Execute the full E2E financial and booking journey against the actual database.
3. Execute security/load/backup/restore testing before public launch.
4. Replace browser-side remote CDNs/assets with self-hosted, pinned production assets before final release if the chosen deployment requires a fully controlled/offline frontend supply chain.

## Release status
**PRELAUNCH / NOT PRODUCTION CERTIFIED**

The v4.12 package is suitable as the next controlled test build. It must not be treated as a claim of zero vulnerabilities or production certification until the blocked runtime tests are executed on the real target environment.
