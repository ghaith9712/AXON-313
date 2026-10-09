import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/catalog.dart';
import '../theme/app_colors.dart';
import '../widgets/axon_card.dart';
import '../widgets/page_scroll.dart';
import '../widgets/responsive_cards.dart';
import '../widgets/section_header.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PageScroll(
      children: [
        const SectionHeader(
          title: 'خدماتنا',
          subtitle: 'تصميم البرامج والأنظمة الرقمية، كاميرات المراقبة، والخدمات الرقمية.',
        ),
        ResponsiveCards(
          children: [
            for (final service in services)
              AxonCard(
                onTap: () => context.go('/services/${service.id}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(service.icon, color: AppColors.gold, size: 34),
                    const SizedBox(height: 14),
                    Text(
                      service.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service.summary,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.muted,
                        height: 1.7,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: () => context.go('/services/${service.id}'),
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('اعرف المزيد'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
