import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/catalog.dart';
import '../theme/app_colors.dart';
import '../utils/external_links.dart';
import '../widgets/axon_card.dart';
import '../widgets/page_scroll.dart';

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

    final theme = Theme.of(context);
    return PageScroll(
      children: [
        AxonCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(service.icon, color: AppColors.green, size: 40),
              const SizedBox(height: 16),
              Text(
                service.title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                service.description,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.muted,
                  height: 1.8,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AxonCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ماذا يشمل العمل',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              for (final point in service.points)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: AppColors.green,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          point,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
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
              label: const Text('اطلب هذه الخدمة'),
            ),
            OutlinedButton.icon(
              onPressed: () => openExternal(
                whatsAppUri('أرغب بالاستفسار عن خدمة: ${service.title}'),
              ),
              icon: const Icon(Icons.chat_outlined),
              label: const Text('واتساب'),
            ),
          ],
        ),
      ],
    );
  }
}
