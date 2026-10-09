import 'package:flutter/material.dart';

import '../models/catalog_models.dart';

const services = <ServiceOffering>[
  ServiceOffering(
    id: 'software',
    title: 'تصميم البرامج والأنظمة الرقمية',
    summary: 'مواقع وتطبيقات وأنظمة إدارة تُبنى على طريقة عملك، بالعربية ومن اليمين إلى اليسار.',
    description: 'نصمم ونبرمج البرامج من أول سؤال عن الإجراء اليومي حتى واجهة يستطيع فريقك استخدامها. يشمل ذلك المواقع التعريفية، تطبيقات الهاتف، لوحات المتابعة، وأنظمة المبيعات والمخزون. نفس الفكرة يمكن أن تعمل على الويب وويندوز والهاتف عندما يكون ذلك مناسباً للمشروع.',
    icon: Icons.laptop_mac_outlined,
    points: [
      'تطبيقات ويب وهاتف بواجهة عربية',
      'أنظمة إدارة للمبيعات والمخزون والعملاء',
      'ربط التنبيهات والطلبات مع واتساب',
      'تسليم مع شرح مختصر لطريقة الاستخدام',
    ],
  ),
  ServiceOffering(
    id: 'cameras',
    title: 'كاميرات المراقبة',
    summary: 'تغطية للمنازل والمحال والمباني، مع تسجيل ومشاهدة من الهاتف بعد التركيب.',
    description: 'نحدد عدد الكاميرات ومكانها حسب المداخل والزوايا والإضاءة، ثم نركّب الكاميرات وأجهزة التسجيل ونراجع الصورة معك قبل إنهاء العمل. يمكن اختيار كاميرا داخلية أو خارجية أو دوارة بحسب المسافة والمكان.',
    icon: Icons.videocam_outlined,
    points: [
      'كاميرات داخلية وخارجية بدقات مختلفة',
      'أجهزة تسجيل بعدد قنوات يناسب الموقع',
      'تخزين ومشاهدة عن بعد من الهاتف',
      'معاينة المكان قبل تثبيت العدد النهائي',
    ],
  ),
  ServiceOffering(
    id: 'digital',
    title: 'الخدمات الرقمية',
    summary: 'شبكات وبنية تحتية وحضور رقمي يربط الأجهزة والأنظمة في مكان واحد.',
    description: 'نرتب شبكة البيانات، ونربط الأجهزة والفروع، ونجهّز حضوراً رقمياً بسيطاً للنشاط. الهدف أن تعمل الكاميرات والبرامج والاتصال معاً بدل أن يبقى كل جزء مستقلاً عن الآخر.',
    icon: Icons.hub_outlined,
    points: [
      'تمديد وتنظيم شبكات البيانات',
      'ربط الأجهزة ضمن بنية واحدة',
      'صفحات تعريفية للنشاط',
      'استشارة عملية قبل بدء التنفيذ',
    ],
  ),
];

const shopCategories = <ShopCategory>[
  ShopCategory(id: 'all', label: 'الكل'),
  ShopCategory(id: 'cameras', label: 'كاميرات'),
  ShopCategory(id: 'recorders', label: 'أجهزة تسجيل'),
  ShopCategory(id: 'software', label: 'باقات برمجية'),
];

const products = <Product>[
  Product(
    id: 'cam-dome',
    name: 'كاميرا قبة داخلية',
    categoryId: 'cameras',
    summary: 'مناسبة للمحال والممرات الداخلية بإضاءة عادية.',
    description: 'كاميرا قبة داخلية بدقة 2 ميغابكسل للمداخل والردهات. السعر تقديري ويختلف حسب مسافة التمديد وعدد النقاط.',
    priceIqd: 75000,
    icon: Icons.videocam_outlined,
    imageAsset: 'assets/images/camera.webp',
  ),
  Product(
    id: 'cam-bullet',
    name: 'كاميرا خارجية 4 ميغابكسل',
    categoryId: 'cameras',
    summary: 'هيكل مقاوم للعوامل الجوية للواجهات والمواقف.',
    description: 'كاميرا خارجية بدقة 4 ميغابكسل لتغطية الواجهة أو الموقف. نحدد العدسة بعد رؤية المسافة والإضاءة الليلية.',
    priceIqd: 145000,
    icon: Icons.videocam_outlined,
    imageAsset: 'assets/images/camera.webp',
  ),
  Product(
    id: 'cam-ptz',
    name: 'كاميرا دوارة',
    categoryId: 'cameras',
    summary: 'تحريك وتقريب لمساحة واسعة من نقطة واحدة.',
    description: 'كاميرا PTZ للساحات والمواقع التي تحتاج متابعة حركة واسعة. التركيب يشمل توجيهاً أولياً ونقاط الحفظ.',
    priceIqd: 390000,
    icon: Icons.control_camera_outlined,
    imageAsset: 'assets/images/camera.webp',
  ),
  Product(
    id: 'nvr-4',
    name: 'جهاز تسجيل 4 قنوات',
    categoryId: 'recorders',
    summary: 'لموقع صغير بعدد محدود من الكاميرات.',
    description: 'مسجل شبكي لأربع قنوات مع إمكانية المشاهدة من الهاتف. القرص يُباع بشكل منفصل حسب مدة الاحتفاظ بالتسجيل.',
    priceIqd: 165000,
    icon: Icons.dns_outlined,
    imageAsset: 'assets/images/industrial.jpg',
  ),
  Product(
    id: 'nvr-8',
    name: 'جهاز تسجيل 8 قنوات',
    categoryId: 'recorders',
    summary: 'للمحال والمباني التي تحتاج تغطية أوسع.',
    description: 'مسجل لثماني قنوات يناسب توسيع النظام لاحقاً دون تغيير الجهاز عند إضافة كاميرات ضمن الحد.',
    priceIqd: 275000,
    icon: Icons.dns_outlined,
    imageAsset: 'assets/images/industrial.jpg',
  ),
  Product(
    id: 'hdd-2',
    name: 'قرص تخزين 2 تيرابايت',
    categoryId: 'recorders',
    summary: 'مساحة تسجيل مخصصة لأجهزة المراقبة.',
    description: 'قرص مخصص للتسجيل المستمر. مدة الاحتفاظ تعتمد على عدد الكاميرات ودقتها وساعات العمل.',
    priceIqd: 89000,
    icon: Icons.storage_outlined,
    imageAsset: 'assets/images/network.jpg',
  ),
  Product(
    id: 'pkg-site',
    name: 'باقة موقع تعريفي',
    categoryId: 'software',
    summary: 'صفحة عربية تعرض الخدمات وطريقة التواصل.',
    description: 'موقع تعريفي من صفحة أو أكثر، مع نموذج تواصل وربط واتساب. المحتوى النصي الأساسي يُجهّز معك قبل البرمجة.',
    priceIqd: 450000,
    icon: Icons.language_outlined,
    imageAsset: 'assets/images/webapp.jpg',
  ),
  Product(
    id: 'pkg-app',
    name: 'باقة تطبيق هاتف وويب',
    categoryId: 'software',
    summary: 'تطبيق واحد يعمل في المتصفح وعلى الهاتف.',
    description: 'تصميم وبرمجة تطبيق بسيط بواجهات عربية، مناسب لعرض الخدمات أو إدارة طلبات محدودة. النطاق يُحدد في جلسة أولى قبل السعر النهائي.',
    priceIqd: 1500000,
    icon: Icons.phone_android_outlined,
    imageAsset: 'assets/images/webapp.jpg',
  ),
  Product(
    id: 'pkg-system',
    name: 'باقة نظام إدارة',
    categoryId: 'software',
    summary: 'متابعة عملاء أو مخزون أو طلبات من لوحة واحدة.',
    description: 'نظام إدارة بسيط حسب إجراء عملك: عملاء، منتجات، أو طلبات. السعر المعروض نقطة بداية ويتغير مع عدد الشاشات والصلاحيات.',
    priceIqd: 2800000,
    icon: Icons.dashboard_outlined,
    imageAsset: 'assets/images/control.jpg',
  ),
];

const galleryWorks = <GalleryWork>[
  GalleryWork(
    asset: 'assets/images/electrical.webp',
    title: 'تأسيس كهربائي',
    caption: 'تأسيس دقيق لمسار الطاقة داخل مشروع سكني.',
  ),
  GalleryWork(
    asset: 'assets/images/camera.webp',
    title: 'مراقبة بالكاميرات',
    caption: 'تغطية بكاميرات عالية الدقة لموقع يحتاج متابعة مستمرة.',
  ),
  GalleryWork(
    asset: 'assets/images/control.jpg',
    title: 'أنظمة تحكم',
    caption: 'تركيب أنظمة تحكم في مبنى تجاري.',
  ),
  GalleryWork(
    asset: 'assets/images/network.jpg',
    title: 'بنية تحتية رقمية',
    caption: 'شبكة بيانات منظمة كأساس لبقية الأنظمة.',
  ),
  GalleryWork(
    asset: 'assets/images/webapp.jpg',
    title: 'تطبيق ويب',
    caption: 'واجهة ويب لمتابعة العمل من المتصفح.',
  ),
  GalleryWork(
    asset: 'assets/images/industrial.jpg',
    title: 'تحكم صناعي',
    caption: 'لوحة ومتابعة لنظام يحتاج دقة في التشغيل.',
  ),
];

ServiceOffering? findService(String id) {
  for (final service in services) {
    if (service.id == id) return service;
  }
  return null;
}

Product? findProduct(String id) {
  for (final product in products) {
    if (product.id == id) return product;
  }
  return null;
}

String categoryLabel(String id) {
  for (final category in shopCategories) {
    if (category.id == id) return category.label;
  }
  return id;
}
