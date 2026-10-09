import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../state/cart_controller.dart';
import '../theme/app_colors.dart';
import '../utils/external_links.dart';
import '../utils/formatting.dart';
import '../widgets/axon_card.dart';
import '../widgets/page_scroll.dart';
import '../widgets/section_header.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _note = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _send(CartController cart) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sending = true);
    final message = buildOrderMessage(
      cart: cart,
      name: _name.text,
      phone: _phone.text,
      note: _note.text,
    );
    final opened = await openExternal(whatsAppUri(message));
    if (!mounted) return;
    setState(() => _sending = false);
    if (!opened) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر فتح واتساب على هذا الجهاز.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();
    final theme = Theme.of(context);
    if (cart.lines.isEmpty) {
      return PageScroll(
        children: [
          const SectionHeader(title: 'السلة'),
          AxonCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.shopping_bag_outlined,
                  color: AppColors.green,
                  size: 36,
                ),
                const SizedBox(height: 12),
                Text(
                  'السلة فارغة',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'أضف منتجاً من السوق ثم أرسل الطلب عبر واتساب.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => context.go('/shop'),
                  child: const Text('تصفح السوق'),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return PageScroll(
      children: [
        const SectionHeader(
          title: 'السلة',
          subtitle:
              'راجع الكميات ثم أرسل الطلب. لا يوجد دفع إلكتروني داخل التطبيق.',
        ),
        for (final line in cart.lines) ...[
          AxonCard(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final info = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      line.product.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatIqd(line.product.priceIqd * line.quantity),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.blue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                );
                final controls = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: 'إنقاص',
                      onPressed: () =>
                          cart.setQuantity(line.product.id, line.quantity - 1),
                      icon: const Icon(Icons.remove),
                    ),
                    Text('${line.quantity}'),
                    IconButton(
                      tooltip: 'زيادة',
                      onPressed: () =>
                          cart.setQuantity(line.product.id, line.quantity + 1),
                      icon: const Icon(Icons.add),
                    ),
                    IconButton(
                      tooltip: 'حذف',
                      onPressed: () => cart.remove(line.product.id),
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                );
                if (constraints.maxWidth < 520) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [info, controls],
                  );
                }
                return Row(
                  children: [
                    Expanded(child: info),
                    controls,
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),
        ],
        Text(
          'المجموع: ${formatIqd(cart.total)}',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: AppColors.blue,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 16),
        AxonCard(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'بيانات الطلب',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'الاسم'),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'الاسم مطلوب'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'رقم الهاتف'),
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    if (!RegExp(r'^[0-9+\s-]{8,}$').hasMatch(text)) {
                      return 'أدخل رقماً يمكن الاتصال به';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _note,
                  minLines: 2,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'ملاحظة (اختياري)',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _sending ? null : () => _send(cart),
                  icon: const Icon(Icons.chat_outlined),
                  label: const Text('إرسال الطلب عبر واتساب'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
