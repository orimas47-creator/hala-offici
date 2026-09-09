# Hala v4.17 — Security Resilience & Webhook Replay Defense

## الحالة
v4.17.0 — PRELAUNCH

## المكتمل والمختبر محليًا
- مخزون وتوافر موحد مع منع التداخل المتزامن عبر advisory transaction locks + row locks.
- دورة دفع/كتابة مالية: server-side pricing، idempotency، payment locks، Escrow، Ledger، Commission، Agent routing، والعملات.
- HMAC Webhook مع timestamp في الإنتاج، ونافذة سماح زمنية لمنع replay.
- Inbox idempotency لمنع معالجة eventId نفسه أكثر من مرة.
- ذكاء هلا المركزي مربوط بالأحداث الحساسة، مع fail-open للـtelemetry غير الحرجة حتى لا تصبح قناة الذكاء نقطة فشل واحدة للعمليات التجارية.
- طبقات الحماية التقنية مستقلة عن الذكاء المركزي.
- 82/82 automated tests passed.
- جميع ملفات backend/workers الرئيسية اجتازت syntax check.
- canonical schema: balanced BEGIN/COMMIT.
- canonical schema: no duplicate CREATE TABLE definitions.
- runtime/OpenAPI/package versions synchronized to 4.17.0.

## ما لا يمكن إثباته داخل بيئة المراجعة الحالية
لا توجد Docker أو PostgreSQL/PostGIS عاملة هنا، لذلك لم يتم الادعاء بتنفيذ الـSchema على قاعدة PostgreSQL حقيقية.
كذلك لم تُنفذ فعليًا بوابة دفع خارجية، OTP/SMS، Object Storage/AV scanning، browser E2E، concurrency حقيقية بعملاء متوازيين، WAF/DDoS خارجي، load testing، backup/restore drill، أو penetration test خارجي.

## بوابة المرحلة التالية
تشغيل الحزمة على Docker + PostgreSQL/PostGIS من قاعدة فارغة، ثم تنفيذ E2E كاملة ودفع/Webhook حقيقي في sandbox، ثم اختبار التزامن والهجمات الأمنية قبل Production.
