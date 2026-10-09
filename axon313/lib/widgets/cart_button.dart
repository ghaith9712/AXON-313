import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../state/cart_controller.dart';
import '../theme/app_colors.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.watch<CartController>().count;
    return IconButton(
      tooltip: 'السلة',
      onPressed: () => context.go('/cart'),
      style: IconButton.styleFrom(
        backgroundColor: AppColors.blueSoft,
        foregroundColor: AppColors.blue,
      ),
      icon: Badge(
        isLabelVisible: count > 0,
        label: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: Text('$count', key: ValueKey(count)),
        ),
        backgroundColor: AppColors.green,
        textColor: Colors.white,
        child: const Icon(Icons.shopping_bag_outlined),
      ),
    );
  }
}
