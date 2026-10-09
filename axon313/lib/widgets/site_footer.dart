import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/company.dart';
import '../theme/app_colors.dart';
import 'brand_mark.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final links = <(String, String)>[
      ('الخدمات', '/services'),
      ('السوق', '/shop'),
      ('المعرض', '/gallery'),
      ('من نحن', '/about'),
      ('تواصل', '/contact'),
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 56),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 22),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 14,
            spacing: 24,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BrandMark(size: 30),
                  const SizedBox(width: 10),
                  Text(
                    Company.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.navy,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: 4,
                children: [
                  for (final link in links)
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.muted,
                        visualDensity: VisualDensity.compact,
                      ),
                      onPressed: () => context.go(link.$2),
                      child: Text(link.$1),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '© 2026 ${Company.name} · ${Company.city}',
            style: theme.textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}
