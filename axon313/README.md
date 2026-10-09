# AXON-313

تطبيق واحد بـ Flutter و Dart لخدمات **AXON-313** في كربلاء: تصميم البرامج والأنظمة الرقمية، كاميرات المراقبة، والخدمات الرقمية، مع سوق إلكتروني بسيط.

الواجهة عربية ومن اليمين إلى اليسار. نفس المشروع يعمل كتطبيق ويب، وتطبيق أندرويد، وتطبيق ويندوز.

السوق يعرض منتجات وأسعاراً تقديرية بالدينار العراقي. السلة ترسل الطلب إلى واتساب، ولا يوجد دفع إلكتروني ولا حسابات مستخدمين.

لتعديل النصوص والأسعار راجع:

- `lib/data/company.dart` لبيانات التواصل
- `lib/data/catalog.dart` للخدمات والمنتجات ومعرض الصور

## التشغيل

ثبّت [Flutter](https://docs.flutter.dev/get-started/install) ثم من مجلد `axon313`:

```bash
flutter pub get
flutter run -d chrome
```

للهاتف بعد توصيل جهاز أو تشغيل محاكي:

```bash
flutter run -d android
```

## البناء

```bash
flutter build web
flutter build apk
flutter build windows
```

`flutter build windows` يُنفَّذ على جهاز ويندوز لأن نظام لينكس لا ينتج ملف `.exe`. ناتج الويب يكون في `build/web`، وملف أندرويد في `build/app/outputs`.

## الاختبار

```bash
flutter analyze
flutter test
```
