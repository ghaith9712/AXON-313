import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/catalog.dart';
import '../state/cart_controller.dart';
import '../theme/app_colors.dart';
import '../utils/formatting.dart';
import '../widgets/axon_card.dart';
import '../widgets/page_scroll.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.id});

  final String id;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = findProduct(widget.id);
    if (product == null) {
      return PageScroll(
        children: [
          const Text('هذا المنتج غير موجود.'),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => context.go('/shop'),
            child: const Text('العودة إلى السوق'),
          ),
        ],
      );
    }

    final theme = Theme.of(context);
    return PageScroll(
      children: [
        AxonCard(
          padding: EdgeInsets.zero,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final image = SizedBox(
                height: 260,
                width: constraints.maxWidth < 720 ? double.infinity : 360,
                child: Image.asset(product.imageAsset, fit: BoxFit.cover),
              );
              final details = Padding(
                padding: const EdgeInsets.all(20),
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
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatIqd(product.priceIqd),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: AppColors.blue,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      product.description,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.muted,
                        height: 1.7,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text('الكمية'),
                        const SizedBox(width: 8),
                        IconButton(
                          tooltip: 'إنقاص',
                          onPressed: _quantity > 1
                              ? () => setState(() => _quantity -= 1)
                              : null,
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        Text('$_quantity', style: theme.textTheme.titleMedium),
                        IconButton(
                          tooltip: 'زيادة',
                          onPressed: _quantity < 20
                              ? () => setState(() => _quantity += 1)
                              : null,
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    FilledButton.icon(
                      onPressed: () {
                        context.read<CartController>().add(
                          product,
                          quantity: _quantity,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تمت الإضافة إلى السلة'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_bag_outlined),
                      label: const Text('أضف إلى السلة'),
                    ),
                  ],
                ),
              );
              if (constraints.maxWidth < 720) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [image, details],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  image,
                  Expanded(child: details),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
