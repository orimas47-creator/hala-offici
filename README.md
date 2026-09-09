
## Current release
v4.17.0 — PRELAUNCH
# Hala v4.9 — Universal Market Builder Integration

## Architectural rule
One Hala system, one shared UI/page/control-panel engine, multiple configurable markets. New markets are data/configuration, not new applications.

## Implemented in this package
- Admin Market Builder API + UI
- Market lifecycle: create/update/activate/pause/archive/restore/soft-delete
- Market sections, dynamic attributes, operation types, UI labels/configuration
- Provider membership per market
- Universal listing creation with sale/rental/rent-insurance validation
- Demand creation and explainable rule-based matching
- Listing media metadata and version/history records
- CORS for browser-to-API local pilot
- Canonical unified database schema v4.9
- Static/unit tests

## Important
The package is designed to be runnable with Docker/PostgreSQL, but this environment does not provide Docker/PostgreSQL, so database execution and full E2E cannot be truthfully claimed as completed here.


## v4.9 verification
- قاعدة البيانات الموحدة تشمل 009_v4_9_operational_hardening.sql.
- كل سوق جديد يرتبط تلقائيًا بمشرف الذكاء المركزي.
- يمكن تمييز السوق المرجعي النشط من لوحة الإدارة.
- واجهة السوق تستدعي /markets/:market/listings عند توفر بيانات تشغيلية حقيقية.
- لا تعتمد حزمة v4.9 وحدها على وجود PostgreSQL داخل بيئة المراجعة الحالية؛ يجب تنفيذ smoke/E2E على PostgreSQL/PostGIS حقيقي قبل الإطلاق.
