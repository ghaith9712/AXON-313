import 'package:flutter/material.dart';

import '../data/catalog.dart';
import '../models/catalog_models.dart';
import '../theme/app_colors.dart';
import '../widgets/page_banner.dart';
import '../widgets/page_scroll.dart';
import '../widgets/product_tile.dart';
import '../widgets/reveal.dart';
import '../widgets/responsive_cards.dart';

enum _Sort { featured, priceLow, priceHigh }

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String _category = 'all';
  String _query = '';
  _Sort _sort = _Sort.featured;

  List<Product> get _visible {
    final needle = _query.trim();
    final list = products.where((product) {
      final inCategory = _category == 'all' || product.categoryId == _category;
      final matches =
          needle.isEmpty ||
          product.name.contains(needle) ||
          product.summary.contains(needle);
      return inCategory && matches;
    }).toList();
    switch (_sort) {
      case _Sort.featured:
        break;
      case _Sort.priceLow:
        list.sort((a, b) => a.priceIqd.compareTo(b.priceIqd));
      case _Sort.priceHigh:
        list.sort((a, b) => b.priceIqd.compareTo(a.priceIqd));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visible = _visible;
    return PageScroll(
      children: [
        const SizedBox(height: 8),
        PageBanner(
          eyebrow: 'السوق الإلكتروني',
          title: 'كل ما تحتاجه للمراقبة والبرمجة',
          subtitle: 'كاميرات، أجهزة تسجيل، وباقات برمجية. الأسعار تقديرية والتأكيد عبر واتساب.',
          bottom: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: TextField(
              onChanged: (value) => setState(() => _query = value),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'ابحث عن منتج',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _query.isEmpty
                    ? null
                    : const Icon(Icons.filter_list_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(
                    color: AppColors.greenMid,
                    width: 1.6,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 18),
              ),
            ),
          ),
        ),
        const SizedBox(height: 26),
        Reveal(
          offset: 16,
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final category in shopCategories)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 8),
                          child: _CategoryPill(
                            category: category,
                            selected: _category == category.id,
                            onTap: () =>
                                setState(() => _category = category.id),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              PopupMenuButton<_Sort>(
                tooltip: 'ترتيب',
                initialValue: _sort,
                onSelected: (value) => setState(() => _sort = value),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                itemBuilder: (context) => const [
                  PopupMenuItem(value: _Sort.featured, child: Text('الأبرز')),
                  PopupMenuItem(
                    value: _Sort.priceLow,
                    child: Text('الأقل سعراً'),
                  ),
                  PopupMenuItem(
                    value: _Sort.priceHigh,
                    child: Text('الأعلى سعراً'),
                  ),
                ],
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.swap_vert_rounded, size: 18),
                      const SizedBox(width: 6),
                      Text('ترتيب', style: theme.textTheme.labelLarge),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Text(
              '${visible.length} منتجات',
              key: ValueKey(visible.length),
              style: theme.textTheme.labelLarge?.copyWith(
                color: AppColors.muted,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 320),
          switchInCurve: Curves.easeOutCubic,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.03),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          layoutBuilder: (current, previous) => Stack(
            alignment: Alignment.topCenter,
            children: [...previous, ?current],
          ),
          child: visible.isEmpty
              ? const _EmptyState(key: ValueKey('empty'))
              : ResponsiveCards(
                  key: ValueKey('$_category|$_query|${_sort.name}'),
                  children: [
                    for (final product in visible)
                      ProductTile(product: product),
                  ],
                ),
        ),
      ],
    );
  }
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final ShopCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: selected ? AppColors.navy : AppColors.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: selected ? AppColors.navy : AppColors.border),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: AppColors.navy.withValues(alpha: 0.22),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ]
            : const [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(26),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  category.icon,
                  size: 18,
                  color: selected ? AppColors.mint : AppColors.muted,
                ),
                const SizedBox(width: 8),
                Text(
                  category.label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: selected ? Colors.white : AppColors.text,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 56,
            color: AppColors.greenMid,
          ),
          const SizedBox(height: 12),
          Text(
            'لا توجد منتجات مطابقة',
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(color: AppColors.muted, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
