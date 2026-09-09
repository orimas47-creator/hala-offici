# Hala v4.7 — مراجعة ترابط الملفات وإغلاق فجوات منشئ الأسواق

## النتيجة
المواصفات الحالية كانت تدعم Universal Market وUniversal Listing وSupply/Demand، لكنها لم تكن تصف بصورة كافية «لوحة منشئ السوق» التي تسمح للمدير بتكوين السوق كاملًا من البيانات والإعدادات مع المحافظة على نفس الواجهة. تمت إضافة طبقة v4.6 لسد هذه الفجوة.

## مصفوفة الترابط
| الملف | القرار v4.6 | حالة المواصفة |
|---|---|---|
| Master Reference | سوق جديد = Configuration/Data وليس مشروعًا جديدًا | يحتاج تثبيت النسخة النهائية |
| Technical | UI واحد + Market Builder + Dynamic Catalog/Demand | مطابق بعد التعديل |
| Programming | APIs/Services للإدارة والتكوين وCRUD/versioning | يلزم تنفيذ Backend الفعلي |
| Database | markets + provider membership + UI configs + operation configs + policies + change log | تمت إضافة v4.6 |
| Financial | الطلب/المطابقة لا تنشئ التزامًا ماليًا؛ المال عبر النواة | مطابق |
| Legal | الأسواق المنظمة تخضع للامتثال قبل النشر/المال | مطابق مبدئيًا |
| UI Integration | نفس الصفحات واللوحات، API يغير البيانات والمسميات | يلزم تحويل Mock إلى API |
| Offline Pilot | اختبار تدفق إنشاء السوق/العرض/الطلب، وليس Production | مطابق |
| Backend | المصدر الحقيقي للحالة والمال والتوفر | التنفيذ جزئي حاليًا |

## فجوات أغلقتها v4.6
1. عدم وجود طبقة صريحة لمسميات الواجهة لكل سوق.
2. عدم وجود سجل مخصص واضح لتكوين السوق من لوحة الإدارة.
3. عدم وجود علاقة صريحة بعضوية المنتسب في السوق.
4. عدم تعريف Soft Delete/Archive للسوق مع الحفاظ على التاريخ.
5. عدم وجود سجل تغيير واضح لإدارة إعدادات السوق.
6. الحاجة إلى فصل إعدادات السوق عن State Machines المالية والأمنية.

## قواعد CRUD
- Create: إنشاء سوق/قسم/تصنيف/حقل/إعداد/عضوية منتسب.
- Read: عرض التكوين الفعلي والإصدارات والصلاحيات.
- Update: تعديل بإصدار جديد أو تحديث محكوم.
- Delete: Soft Delete/Archive عند وجود أثر تاريخي.
- Restore: استعادة وفق صلاحية وإجراء مدقق.
- Publish: نشر إعدادات السوق/الواجهة بعد التحقق.
- Audit: كل تغيير حساس يسجل actor/request/time/before/after.

## قاعدة العرض
العرض هو سجل منتسب داخل السوق، وليس صفحة جديدة. Universal Listing يستوعب النوع والخصائص والمتغيرات والوحدات والوسائط والأسعار والتوفر. قاعدة البيانات الحالية تدعم خصائص ديناميكية ونسخًا ومتغيرات ووحدات. fileciteturn35file2L71-L121

## قاعدة الطلب
Demand Request مستقل عن العرض. يمكن للعميل إنشاء طلب بدون وجود listing، ثم يتم إنشاء matches أو provider offers. لا يصبح ماليًا إلا بعد قبول المستخدم والانتقال لمسار المعاملة المالي. fileciteturn35file7L288-L309

## قاعدة البساطة
كل التعقيد يوضع في Backend/Market Engine. العميل والمنتسب يتعاملان مع نفس الشاشة البسيطة، والحقول تظهر فقط إذا عرّفها السوق.

## ملاحظات إنتاجية
المشروع ما زال يحتاج تنفيذًا حقيقيًا للوحدات الناقصة وتشغيل قاعدة PostgreSQL/PostGIS والـWorkers والاختبارات E2E والأمن وBackup/Restore. لا يجوز وصفه Production قبل ذلك. fileciteturn35file6L217-L220


## v4.7 security/control-plane closure
- Bearer session authentication added; legacy X-Actor-Id is opt-in development only.
- Payment verification is privileged and booking financial totals are calculated by the server.
- Provider identity is derived from the authenticated user.
- Global portal API and portal rails/ads are now data-driven.
- New markets may clone the active reference market's operational configuration without copying transactional data.
- Platform Supervisor AI sits above local market AI and inherits restrictive policies across every market.
