import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/catalog.dart';
import '../models/catalog_models.dart';
import '../theme/app_colors.dart';
import '../utils/external_links.dart';
import '../widgets/cta_band.dart';
import '../widgets/page_scroll.dart';
import '../widgets/process_timeline.dart';
import '../widgets/reveal.dart';
import '../widgets/responsive_cards.dart';
import '../widgets/section_header.dart';
import '../widgets/service_card.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final service = findService(id);
    if (service == null) {
      return PageScroll(
        children: [
          const Text('هذه الخدمة غير موجودة.'),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => context.go('/services'),
            child: const Text('العودة إلى الخدمات'),
          ),
        ],
      );
    }

    final others = services.where((item) => item.id != service.id).toList();
    return PageScroll(
      children: [
        const SizedBox(height: 8),
        _ServiceHero(service: service),
        SectionHeader(
          eyebrow: 'ماذا يشمل العمل',
          title: 'كل ما ستحصل عليه',
          subtitle: 'عناصر العمل الأساسية لهذه الخدمة.',
        ),
        ResponsiveCards(
          minTileWidth: 400,
          maxColumns: 2,
          children: [
            for (var i = 0; i < service.points.length; i++)
              _PointCard(service: service, index: i),
          ],
        ),
        SectionHeader(
          eyebrow: 'مسار العمل',
          title: 'خطواتنا في ${service.shortTitle}',
        ),
        Reveal(
          child: Container(
            padding: EdgeInsets.all(
              MediaQuery.sizeOf(context).width >= 860 ? 36 : 22,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: AppColors.border),
            ),
            child: ProcessTimeline(
              steps: service.steps,
              colors: service.gradient,
            ),
          ),
        ),
        const SectionHeader(eyebrow: 'اكتشف المزيد', title: 'خدمات أخرى'),
        ResponsiveCards(
          minTileWidth: 340,
          maxColumns: 2,
          children: [
            for (final other in others)
              ServiceCard(service: other, index: services.indexOf(other)),
          ],
        ),
        CtaBand(
          title: 'جاهز لطلب ${service.shortTitle}؟',
          body: 'اكتب لنا وصفاً قصيراً لما تحتاجه وسنرد بخطوة واضحة وسعر قبل التنفيذ.',
          primaryLabel: 'اطلب هذه الخدمة',
          secondaryLabel: 'واتساب',
          onSecondary: () => openExternal(
            whatsAppUri('أرغب بالاستفسار عن خدمة: ${service.title}'),
          ),
        ),
      ],
    );
  }
}

class _ServiceHero extends StatelessWidget {
  const _ServiceHero({required this.service});

  final ServiceOffering service;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wide = MediaQuery.sizeOf(context).width >= 860;
    return Reveal(
      offset: 24,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: SizedBox(
          height: wide ? 500 : 560,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: 'service-image-${service.id}',
                child: Image.asset(service.imageAsset, fit: BoxFit.cover),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: wide
                        ? AlignmentDirectional.centerStart
                        : Alignment.bottomCenter,
                    end: wide
                        ? AlignmentDirectional.centerEnd
                        : Alignment.topCenter,
                    stops: const [0, 0.5, 1],
                    colors: [
                      AppColors.navy.withValues(alpha: 0.96),
                      Color.alphaBlend(
                        service.accent.withValues(alpha: 0.5),
                        AppColors.navy,
                      ).withValues(alpha: 0.86),
                      service.accent.withValues(alpha: 0.1),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(wide ? 52 : 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ServiceIconTile(service: service, size: 64),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Text(
                        service.tag,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 640),
                      child: Text(
                        service.title,
                        style: theme.textTheme.displaySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: wide ? 46 : 30,
                          height: 1.25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 620),
                      child: Text(
                        service.description,
                        maxLines: wide ? 4 : 5,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                          height: 1.8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.navy,
                          ),
                          onPressed: () => context.go('/contact'),
                          icon: const Icon(Icons.arrow_back_rounded, size: 20),
                          label: const Text('اطلب هذه الخدمة'),
                        ),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: BorderSide(
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                          onPressed: () => openExternal(
                            whatsAppUri(
                              'أرغب بالاستفسار عن خدمة: ${service.title}',
                            ),
                          ),
                          icon: const Icon(Icons.chat_outlined, size: 20),
                          label: const Text('واتساب'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PointCard extends StatelessWidget {
  const _PointCard({required this.service, required this.index});

  final ServiceOffering service;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: service.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.check_circle_rounded,
              color: service.accent,
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              service.points[index],
              style: theme.textTheme.titleSmall?.copyWith(
                color: AppColors.navy,
                fontWeight: FontWeight.w700,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
