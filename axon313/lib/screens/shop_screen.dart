import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/catalog.dart';
import '../theme/app_colors.dart';
import '../utils/formatting.dart';
import '../widgets/axon_card.dart';
import '../widgets/page_scroll.dart';
import '../widgets/responsive_cards.dart';
import '../widgets/section_header.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String _category = 'all';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visible = _category == 'all'
        ? products
        : products.where((product) => product.categoryId == _category).toList();

    return PageScroll(
      children: [
        const SectionHeader(
          title: 'السوق الإلكتروني',
          subtitle: 'قسم بسيط للكاميرات وأجهزة التسجيل والباقات البرمجية. الأسعار تقديرية، والتأكيد يتم عبر واتساب.',
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final category in shopCategories)
              ChoiceChip(
                label: Text(category.label),
                selected: _category == category.id,
                onSelected: (_) => setState(() => _category = category.id),
              ),
          ],
        ),
        const SizedBox(height: 16),
        ResponsiveCards(
          children: [
            for (final product in visible)
              AxonCard(
                padding: EdgeInsets.zero,
                onTap: () => context.go('/shop/${product.id}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 150,
                      child: Image.asset(product.imageAsset, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            categoryLabel(product.categoryId),
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: AppColors.gold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            product.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            product.summary,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.muted,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            formatIqd(product.priceIqd),
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: AppColors.goldLight,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
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
