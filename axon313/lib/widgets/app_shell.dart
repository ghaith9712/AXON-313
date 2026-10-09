import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import 'cart_button.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.location, required this.child});

  final String location;
  final Widget child;

  static const _paths = ['/', '/services', '/shop', '/gallery', '/contact'];

  int get _index {
    if (location.startsWith('/services')) return 1;
    if (location.startsWith('/shop') || location.startsWith('/cart')) return 2;
    if (location.startsWith('/gallery')) return 3;
    if (location.startsWith('/contact')) return 4;
    if (location == '/') return 0;
    return -1;
  }

  bool get _showBack {
    if (location == '/cart') return true;
    final parts = location.split('/').where((part) => part.isNotEmpty);
    return parts.length > 1;
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 960;
    return wide ? _wide(context) : _phone(context);
  }

  Widget _phone(BuildContext context) {
    final hidden = _index < 0;
    final bar = NavigationBar(
      selectedIndex: hidden ? 0 : _index,
      onDestinationSelected: (index) => context.go(_paths[index]),
      destinations: _destinations,
    );
    return Scaffold(
      appBar: _bar(context, title: 'AXON-313'),
      body: child,
      bottomNavigationBar: hidden
          ? NavigationBarTheme(
              data: NavigationBarThemeData(
                indicatorColor: Colors.transparent,
                iconTheme: WidgetStateProperty.all(
                  const IconThemeData(color: AppColors.muted),
                ),
                labelTextStyle: WidgetStateProperty.all(
                  Theme.of(context).textTheme.labelMedium
                      ?.copyWith(color: AppColors.muted, fontSize: 12),
                ),
              ),
              child: bar,
            )
          : bar,
    );
  }

  Widget _wide(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _topNav(context),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _topNav(BuildContext context) {
    final theme = Theme.of(context);
    const labels = ['الرئيسية', 'الخدمات', 'السوق', 'المعرض', 'تواصل'];
    return Material(
      key: const Key('desktop-nav'),
      color: AppColors.surface,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: SizedBox(
          height: 74,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Row(
              children: [
                if (_showBack)
                  IconButton(
                    tooltip: 'رجوع',
                    onPressed: () => context.pop(),
                    icon: const BackButtonIcon(),
                  ),
                InkWell(
                  onTap: () => context.go('/'),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: AppColors.greenMid,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'AXON-313',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: AppColors.blue,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 28),
                for (var i = 0; i < labels.length; i++)
                  _navLink(context, labels[i], i),
                const Spacer(),
                IconButton(
                  tooltip: 'من نحن',
                  onPressed: () => context.go('/about'),
                  icon: const Icon(Icons.info_outline),
                ),
                const CartButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navLink(BuildContext context, String label, int index) {
    final selected = _index == index;
    return InkWell(
      onTap: () => context.go(_paths[index]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: selected ? AppColors.blue : AppColors.muted,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              height: 2,
              width: selected ? 22 : 0,
              color: AppColors.greenMid,
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _bar(BuildContext context, {required String title}) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: _showBack ? BackButton(onPressed: () => context.pop()) : null,
      title: Text(title),
      actions: [
        IconButton(
          tooltip: 'من نحن',
          onPressed: () => context.go('/about'),
          icon: const Icon(Icons.info_outline),
        ),
        const CartButton(),
        const SizedBox(width: 4),
      ],
    );
  }

  static const _destinations = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'الرئيسية',
    ),
    NavigationDestination(
      icon: Icon(Icons.design_services_outlined),
      selectedIcon: Icon(Icons.design_services),
      label: 'الخدمات',
    ),
    NavigationDestination(
      icon: Icon(Icons.storefront_outlined),
      selectedIcon: Icon(Icons.storefront),
      label: 'السوق',
    ),
    NavigationDestination(
      icon: Icon(Icons.photo_library_outlined),
      selectedIcon: Icon(Icons.photo_library),
      label: 'المعرض',
    ),
    NavigationDestination(
      icon: Icon(Icons.chat_outlined),
      selectedIcon: Icon(Icons.chat),
      label: 'تواصل',
    ),
  ];
}
