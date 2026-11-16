# تطبيق iLogia لنظام iOS (iPhone & iPad) 🍏

تم إنشاء تطبيق iOS بالكامل باستخدام أحدث تقنيات أبل: **Swift + SwiftUI + WKWebView**.

---

## 📁 هيكل المشروع (`ios/`):
```text
ios/
├── iLogia.xcodeproj/           # ملف مشروع Xcode الجاهز للفتح
├── iLogiaApp/
│   ├── iLogiaApp.swift         # نقطة البداية لتطبيق SwiftUI
│   ├── Views/
│   │   ├── ContentView.swift   # الواجهة الرئيسية وإدارة الحالة
│   │   ├── WebViewContainer.swift # محرك WKWebView المتقدم وإدارة الجلسات
│   │   └── OfflineView.swift   # شاشة عدم توفر اتصال بالإنترنت
│   ├── Services/
│   │   └── NetworkMonitor.swift# فحص الاتصال بالشبكة لحظياً
│   └── Resources/
│       ├── Info.plist          # إعدادات الصلاحيات والاسم والـ Bundle
│       └── Assets.xcassets/    # أيقونات التطبيق وألوان الهوية
```

---

## 🚀 طرق تشغيل وتثبيت التطبيق على الآيفون:

### الطريقة الأولى: إذا كان لديك جهاز Mac
1. افتح المجلد في تطبيق **Xcode**: انقر مرتين على `ios/iLogia.xcodeproj`.
2. وصّل جهاز الآيفون الخاص بك بالماك بواسطة الكابل.
3. اختر جهازك من شريط الأجهزة بالأعلى (Target Device).
4. اضغط على زر **Run (▶)** لتثبيت التطبيق مباشرة على هاتفك.

---

### الطريقة الثانية: بدون جهاز Mac (عبر GitHub Actions مجاناً)
إذا لم يكن لديك ماك، تم تجهيز مسار عمل سحابي تلقائي في:
`.github/workflows/build-ios.yml`

1. ارفع المشروع إلى حسابك على GitHub (مستودع خاص أو عام).
2. افتح تبويب **Actions** في صفحة المشروع على GitHub.
3. اختر **Build iOS IPA** واضغط على **Run workflow**.
4. ستقوم سيرفرات أبل (macOS) بتجميع التطبيق في دقائق وإعطائك ملف جاهز للتحميل: `iLogia-unsigned.ipa`.
5. لتثبيته على هاتفك الآيفون من جهاز الكمبيوتر (ويندوز):
   - استخدم برنامج [Sideloadly](https://sideloadly.io/) (مجاني وسهل جداً).
   - أو برنامج [AltStore](https://altstore.io/).
   - اسحب ملف `iLogia-unsigned.ipa` وأدخل حسابك في أبل وسيتم تثبيت التطبيق على آيفونك فوراً.
