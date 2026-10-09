import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/catalog.dart';
import '../data/company.dart';
import '../theme/app_colors.dart';
import '../widgets/page_scroll.dart';
import '../widgets/product_tile.dart';
import '../widgets/responsive_cards.dart';
import '../widgets/section_header.dart';
import '../widgets/service_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wide = MediaQuery.sizeOf(context).width >= 860;
    final titleSize = wide ? 58.0 : 36.0;

    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.greenLight,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'استوديو رقمي · كربلاء',
            style: theme.textTheme.labelLarge?.copyWith(
              color: AppColors.green,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'نصوغ المستقبل\nبدقة هندسية',
          style: theme.textTheme.displaySmall?.copyWith(
            fontSize: titleSize,
            fontWeight: FontWeight.w900,
            height: 1.12,
            color: AppColors.blue,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'برامج وأنظمة، كاميرات مراقبة، وخدمات رقمية. تختار من السوق، ونؤكد السعر على واتساب.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppColors.muted,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton(
              onPressed: () => context.go('/services'),
              child: const Text('اكتشف خدماتنا'),
            ),
            OutlinedButton(
              onPressed: () => context.go('/shop'),
              child: const Text('تسوق الآن'),
            ),
          ],
        ),
      ],
    );

    final portrait = const _HeroPortrait();

    return PageScroll(
      children: [
        const SizedBox(height: 8),
        if (wide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 6, child: copy),
              const SizedBox(width: 36),
              const Expanded(flex: 5, child: _HeroPortrait()),
            ],
          )
        else ...[
          portrait,
          const SizedBox(height: 28),
          copy,
        ],
        const SectionHeader(
          title: 'ثلاث خدمات، ومسار واحد',
          subtitle: 'من الفكرة إلى التركيب، بدون قوائم مكررة.',
        ),
        for (var i = 0; i < services.length; i++)
          ServiceRow(service: services[i], index: i),
        const SectionHeader(
          title: 'مختارات من السوق',
          subtitle: 'أسعار تقديرية. الطلب يُؤكد قبل الدفع والتوصيل.',
        ),
        ResponsiveCards(
          children: [
            for (final product in products.take(3))
              ProductTile(product: product),
          ],
        ),
        const SizedBox(height: 8),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton(
            onPressed: () => context.go('/shop'),
            child: const Text('كل المنتجات'),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          decoration: BoxDecoration(
            color: AppColors.greenLight,
            borderRadius: BorderRadius.circular(22),
          ),
          child: const ResponsiveCards(
            children: [
              _Note(
                title: 'تنفيذ حسب المكان',
                body: 'العدد والمواصفات بعد رؤية الموقع.',
              ),
              _Note(
                title: 'واجهة عربية',
                body: 'البرامج من اليمين إلى اليسار.',
              ),
              _Note(
                title: 'تواصل مباشر',
                body: 'الهاتف وواتساب خلال أوقات العمل.',
              ),
              _Note(
                title: 'سعر قبل العمل',
                body: 'السعر النهائي يُرسل قبل التنفيذ.',
              ),
            ],
          ),
        ),
        const SectionHeader(title: 'من الأعمال'),
        ResponsiveCards(
          children: [
            for (final work in galleryWorks.take(3))
              _WorkTile(asset: work.asset, title: work.title),
          ],
        ),
        const SizedBox(height: 28),
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ابدأ بوصف مختصر',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'برنامج، كاميرات، أو شبكة. نرد لنحدد الخطوة التالية.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.86),
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.blue,
                    ),
                    onPressed: () => context.go('/contact'),
                    child: const Text('تواصل معنا'),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                    ),
                    onPressed: () => context.go('/about'),
                    child: const Text('عن AXON-313'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Text(
          '© 2026 ${Company.name}',
          style: theme.textTheme.bodySmall?.copyWith(color: AppColors.muted),
        ),
      ],
    );
  }
}

class _HeroPortrait extends StatelessWidget {
  const _HeroPortrait();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: SizedBox(
        height: 460,
        width: double.infinity,
        child: Image.asset('assets/images/camera.webp', fit: BoxFit.cover),
      ),
    );
  }
}

class _Note extends StatelessWidget {
  const _Note({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.green,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.text,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkTile extends StatelessWidget {
  const _WorkTile({required this.asset, required this.title});

  final String asset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        onTap: () => context.go('/gallery'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 190, child: Image.asset(asset, fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.blue,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
