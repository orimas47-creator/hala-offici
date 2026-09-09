# Hala v4.7 — Security, Integration and Platform-AI Audit

## What was repaired

1. Authentication identity is now derived from a database-backed Bearer session issued after OTP verification. `X-Actor-Id` is test-only and explicitly disabled unless the deployment enables it outside production.
2. OTP has request-rate limiting, attempt limits, expiration and timing-safe code comparison. The login request no longer exposes the user UUID.
3. Payment verification is privileged to admin/finance roles. Customers cannot self-verify a payment transaction.
4. Booking reads/transitions now have ownership/role checks. Booking financial amounts are computed server-side from the selected offer instead of trusting client-supplied totals.
5. Listing ownership is derived from the authenticated user -> provider relation; the client cannot impersonate another provider id.
6. HTTP payload-size limits, security headers and restricted CORS behavior were added.
7. Global Hala Portal API was added with market selection, advertising and ranking rails.
8. Market Builder can clone operational configuration from an active reference market while keeping the new market's transactional data empty.
9. A platform-level AI supervisor was added above local market AI. Local AI policies are inherited with restriction mode. The supervisor can observe all markets, escalate high-risk activity and quarantine malicious listings through guarded rules.
10. Money, ledger, permissions and legal policy remain outside direct AI authority. AI can observe/recommend/guard; domain services enforce state and financial truth.

## Important runtime gate

The code and migration chain are prepared for real integration, but a fresh or upgraded deployment must actually run PostgreSQL/PostGIS, apply all migrations through v4.7, install dependencies with a lockfile, connect a real OTP/SMS provider, configure object storage, configure payment-provider webhooks, run workers/queues, and execute end-to-end/security/concurrency/backup-restore tests before production traffic.

The current container used for this audit does not contain Docker or PostgreSQL, so database execution and real external-provider tests could not be truthfully claimed as completed here.
