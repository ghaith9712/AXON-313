import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/catalog.dart';
import '../models/catalog_models.dart';
import '../state/cart_controller.dart';
import '../theme/app_colors.dart';
import '../utils/external_links.dart';
import '../utils/formatting.dart';
import '../widgets/page_scroll.dart';
import '../widgets/product_tile.dart';
import '../widgets/reveal.dart';
import '../widgets/responsive_cards.dart';
import '../widgets/section_header.dart';

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

    final wide = MediaQuery.sizeOf(context).width >= 860;
    final related = products
        .where(
          (item) =>
              item.categoryId == product.categoryId && item.id != product.id,
        )
        .take(3)
        .toList();

    final image = Hero(
      tag: 'product-image-${product.id}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: SizedBox(
          height: wide ? 540 : 300,
          width: double.infinity,
          child: Image.asset(product.imageAsset, fit: BoxFit.cover),
        ),
      ),
    );

    return PageScroll(
      children: [
        const SizedBox(height: 8),
        if (wide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: image),
              const SizedBox(width: 36),
              Expanded(flex: 5, child: _details(context, product)),
            ],
          )
        else ...[
          image,
          const SizedBox(height: 22),
          _details(context, product),
        ],
        if (related.isNotEmpty) ...[
          const SectionHeader(eyebrow: 'قد يعجبك', title: 'منتجات مشابهة'),
          ResponsiveCards(
            children: [
              for (final item in related)
                ProductTile(product: item, hero: false),
            ],
          ),
        ],
      ],
    );
  }

  Widget _details(BuildContext context, Product product) {
    final theme = Theme.of(context);
    final total = product.priceIqd * _quantity;
    return Reveal(
      offset: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.greenLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(product.icon, size: 16, color: AppColors.green),
                const SizedBox(width: 6),
                Text(
                  categoryLabel(product.categoryId),
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: AppColors.green,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            product.name,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: AppColors.navy,
              fontWeight: FontWeight.w900,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            formatIqd(product.priceIqd),
            style: theme.textTheme.headlineSmall?.copyWith(
              color: AppColors.blue,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            product.description,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.muted,
              height: 1.85,
            ),
          ),
          const SizedBox(height: 22),
          const _Assurance(
            icon: Icons.price_check_rounded,
            text: 'السعر تقديري ويؤكد على واتساب قبل التنفيذ',
          ),
          const _Assurance(
            icon: Icons.handyman_rounded,
            text: 'التركيب بعد معاينة المكان',
          ),
          const _Assurance(
            icon: Icons.support_agent_rounded,
            text: 'دعم مباشر بعد التسليم',
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text('الكمية', style: theme.textTheme.titleSmall),
                    const Spacer(),
                    _Stepper(
                      quantity: _quantity,
                      onMinus: _quantity > 1
                          ? () => setState(() => _quantity -= 1)
                          : null,
                      onPlus: _quantity < 20
                          ? () => setState(() => _quantity += 1)
                          : null,
                    ),
                  ],
                ),
                const Divider(height: 28, color: AppColors.border),
                Row(
                  children: [
                    Text('الإجمالي', style: theme.textTheme.titleSmall),
                    const Spacer(),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(scale: animation, child: child),
                      ),
                      child: Text(
                        formatIqd(total),
                        key: ValueKey(total),
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: AppColors.navy,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: () {
                    context.read<CartController>().add(
                      product,
                      quantity: _quantity,
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('تمت الإضافة إلى السلة'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                  },
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: const Text('أضف إلى السلة'),
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () => openExternal(
                    whatsAppUri('أرغب بالاستفسار عن: ${product.name}'),
                  ),
                  icon: const Icon(Icons.chat_outlined),
                  label: const Text('استفسر عبر واتساب'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Assurance extends StatelessWidget {
  const _Assurance({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: AppColors.blueSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 18, color: AppColors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({
    required this.quantity,
    required this.onMinus,
    required this.onPlus,
  });

  final int quantity;
  final VoidCallback? onMinus;
  final VoidCallback? onPlus;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'إنقاص',
            onPressed: onMinus,
            icon: const Icon(Icons.remove_rounded),
          ),
          SizedBox(
            width: 36,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Text(
                '$quantity',
                key: ValueKey(quantity),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w900),
              ),
            ),
          ),
          IconButton(
            tooltip: 'زيادة',
            onPressed: onPlus,
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}
