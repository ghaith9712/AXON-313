import 'package:flutter/material.dart';

import '../data/catalog.dart';
import '../theme/app_colors.dart';
import '../widgets/page_scroll.dart';
import '../widgets/product_tile.dart';
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
    final visible = _category == 'all'
        ? products
        : products.where((product) => product.categoryId == _category).toList();

    return PageScroll(
      children: [
        const SectionHeader(
          title: 'السوق الإلكتروني',
          subtitle: 'كاميرات، أجهزة تسجيل، وباقات برمجية. الأسعار تقديرية والتأكيد عبر واتساب.',
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final category in shopCategories)
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: _category == category.id
                      ? AppColors.green
                      : AppColors.muted,
                  backgroundColor: _category == category.id
                      ? AppColors.greenLight
                      : Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: const StadiumBorder(),
                ),
                onPressed: () => setState(() => _category = category.id),
                child: Text(category.label),
              ),
          ],
        ),
        const SizedBox(height: 18),
        ResponsiveCards(
          children: [
            for (final product in visible) ProductTile(product: product),
          ],
        ),
      ],
    );
  }
}
