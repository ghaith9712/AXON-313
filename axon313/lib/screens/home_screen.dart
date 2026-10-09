import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/catalog.dart';
import '../data/company.dart';
import '../theme/app_colors.dart';
import '../utils/formatting.dart';
import '../widgets/axon_card.dart';
import '../widgets/page_scroll.dart';
import '../widgets/responsive_cards.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleSize = MediaQuery.sizeOf(context).width < 600 ? 32.0 : 48.0;
    return PageScroll(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColors.heroStart,
                AppColors.background,
                AppColors.heroEnd,
              ],
            ),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Company.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.green,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'نصوغ المستقبل\nبدقة هندسية وإبداع رقمي',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w900,
                  height: 1.25,
                  color: AppColors.blue,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'برامج وأنظمة رقمية، كاميرات مراقبة، وخدمات رقمية. والسوق هنا بسيط: تختار المنتج، وترسل الطلب على واتساب ليُؤكد السعر والتوصيل.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.muted,
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 22),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton.icon(
                    onPressed: () => context.go('/services'),
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('اكتشف خدماتنا'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => context.go('/shop'),
                    icon: const Icon(Icons.storefront_outlined),
                    label: const Text('تسوق الآن'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SectionHeader(
          title: 'خدمات مصممة للتنفيذ',
          subtitle: 'ثلاث مسارات واضحة، وكل مسار له صفحة تفاصيل وطلب تواصل.',
        ),
        ResponsiveCards(
          children: [
            for (final service in services)
              AxonCard(
                onTap: () => context.go('/services/${service.id}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(service.icon, color: AppColors.green, size: 32),
                    const SizedBox(height: 14),
                    Text(
                      service.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service.summary,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.muted,
                        height: 1.6,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(height: 14),
                    Text(
                      'التفاصيل',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppColors.green,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SectionHeader(
          title: 'من السوق',
          subtitle:
              'أسعار تقديرية بالدينار العراقي. الطلب لا يُدفع داخل التطبيق.',
        ),
        ResponsiveCards(
          children: [
            for (final product in products.take(3))
              AxonCard(
                onTap: () => context.go('/shop/${product.id}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryLabel(product.categoryId),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppColors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.summary,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.muted,
                        height: 1.6,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(height: 12),
                    Text(
                      formatIqd(product.priceIqd),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.blue,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton(
            onPressed: () => context.go('/shop'),
            child: const Text('كل المنتجات'),
          ),
        ),
        const SectionHeader(title: 'لماذا AXON-313'),
        const ResponsiveCards(
          children: [
            _ValueCard(
              icon: Icons.straighten_outlined,
              title: 'تنفيذ حسب المكان',
              body: 'العدد والمواصفات تُحدد بعد فهم الموقع، لا من قائمة جاهزة فقط.',
            ),
            _ValueCard(
              icon: Icons.translate_outlined,
              title: 'واجهة عربية',
              body: 'البرامج تُصمم من اليمين إلى اليسار وبلغة يستخدمها الفريق يومياً.',
            ),
            _ValueCard(
              icon: Icons.support_agent_outlined,
              title: 'تواصل مباشر',
              body: 'الهاتف وواتساب مفتوحان خلال أوقات العمل، بلا لوحة وسيطة.',
            ),
            _ValueCard(
              icon: Icons.verified_outlined,
              title: 'سعر يُؤكد قبل العمل',
              body: 'أرقام السوق تقديرية، والسعر النهائي يُرسل لك قبل التنفيذ.',
            ),
          ],
        ),
        const SectionHeader(title: 'من الأعمال'),
        ResponsiveCards(
          children: [
            for (final work in galleryWorks.take(3))
              AxonCard(
                padding: EdgeInsets.zero,
                onTap: () => context.go('/gallery'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 150,
                      child: Image.asset(work.asset, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Text(
                        work.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        AxonCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ابدأ بوصف مختصر',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'اكتب ما تحتاجه: برنامج، كاميرات، أو شبكة. نرد عليك لتحديد الخطوة التالية.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.muted,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton.icon(
                    onPressed: () => context.go('/contact'),
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('تواصل معنا'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => context.go('/about'),
                    icon: const Icon(Icons.info_outline),
                    label: const Text('عن AXON-313'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Text(
          '© 2026 ${Company.name} – جميع الحقوق محفوظة',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(color: AppColors.muted),
        ),
      ],
    );
  }
}

class _ValueCard extends StatelessWidget {
  const _ValueCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AxonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.green),
          const SizedBox(height: 12),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.muted,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
