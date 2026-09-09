# Hala v4.16 — Universal Inventory Availability & Reservation

## الحالة
v4.16.0 — PRELAUNCH

## مكتمل ومختبر محليًا
- Universal Inventory Reservations.
- منع الحجز المتزامن لنفس المخزون عبر PostgreSQL advisory transaction locks + row locks.
- حساب الكمية المتاحة لكل وحدة مع احتساب الحجوزات المتداخلة.
- دعم المخزون الموحد والأسواق الديناميكية.
- ربط الانتقال إلى PAYMENT_PENDING بالحجز الفعلي للمخزون قبل إنشاء الالتزام المالي.
- تفعيل الحجوزات عند نجاح الدفع.
- تحرير الحجوزات عند الإلغاء/الفشل/الإكمال وفق نوع العملية.
- انتهاء حجوزات انتظار الدفع وإفشال الحجز غير المدفوع وإزالة payment lock مع audit + central telemetry.
- API للتوافر العام للعروض الموحدة.
- اختبارات تعاقدية لطبقة التوافر والعامل الدوري.

## نتائج الاختبار المحلي
- 70/70 tests passed.
- Backend/worker JavaScript syntax checks passed.
- Canonical schema: balanced BEGIN/COMMIT.
- Canonical schema: no duplicate CREATE TABLE definitions.
- Production version synchronized to 4.16.0.

## ما لم يتم إثباته في هذه البيئة
لا توجد PostgreSQL/PostGIS أو Docker قيد التشغيل هنا، ولذلك لم يتم ادعاء تنفيذ migration على قاعدة بيانات حقيقية أو اختبار concurrency فعلي بعملاء متوازيين.
كما لم يتم بعد تشغيل بوابة الدفع الحقيقية أو التخزين الخارجي أو WAF/IDS أو اختبارات E2E والضغط والاختراق.

## بوابة الانتقال التالية
قبل اعتماد Production يجب تنفيذ PostgreSQL/PostGIS من قاعدة فارغة، ثم اختبار concurrency فعلي، ثم دورة الدفع/Escrow/Ledger الكاملة.
