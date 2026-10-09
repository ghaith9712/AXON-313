import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/catalog.dart';
import '../models/catalog_models.dart';
import '../state/cart_controller.dart';
import '../theme/app_colors.dart';
import '../utils/formatting.dart';
import 'hover_lift.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product, this.hero = true});

  final Product product;
  final bool hero;

  Widget _wrapHero(Widget child) {
    if (!hero) return child;
    return Hero(tag: 'product-image-${product.id}', child: child);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return HoverLift(
      radius: 28,
      onTap: () => context.push('/shop/${product.id}'),
      builder: (context, hovered) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 190,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _wrapHero(
                    AnimatedScale(
                      scale: hovered ? 1.08 : 1,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      child: Image.asset(product.imageAsset, fit: BoxFit.cover),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [
                          AppColors.navy.withValues(alpha: 0.4),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 14,
                    start: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(product.icon, size: 14, color: AppColors.green),
                          const SizedBox(width: 5),
                          Text(
                            categoryLabel(product.categoryId),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: AppColors.navy,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.navy,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.summary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.muted,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          formatIqd(product.priceIqd),
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: AppColors.blue,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      IconButton.filledTonal(
                        tooltip: 'إضافة ${product.name} للسلة',
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.greenLight,
                          foregroundColor: AppColors.green,
                        ),
                        onPressed: () {
                          context.read<CartController>().add(product);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text('تمت الإضافة إلى السلة'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                        },
                        icon: const Icon(Icons.add_shopping_cart_rounded),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
