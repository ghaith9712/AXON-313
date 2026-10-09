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

  String get _title {
    if (location.startsWith('/services/')) return 'تفاصيل الخدمة';
    if (location.startsWith('/services')) return 'خدماتنا';
    if (location.startsWith('/shop/')) return 'تفاصيل المنتج';
    if (location.startsWith('/shop')) return 'السوق';
    if (location.startsWith('/gallery')) return 'معرض الأعمال';
    if (location.startsWith('/contact')) return 'تواصل معنا';
    if (location.startsWith('/about')) return 'عن AXON-313';
    if (location.startsWith('/cart')) return 'السلة';
    return 'الرئيسية';
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
    final extended = MediaQuery.sizeOf(context).width >= 1200;
    final hidden = _index < 0;
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: extended,
            minExtendedWidth: 220,
            backgroundColor: AppColors.primaryDark,
            selectedIndex: hidden ? 0 : _index,
            groupAlignment: -1,
            onDestinationSelected: (index) => context.go(_paths[index]),
            indicatorColor: hidden
                ? Colors.transparent
                : AppColors.gold.withValues(alpha: 0.18),
            selectedIconTheme: IconThemeData(
              color: hidden ? AppColors.muted : AppColors.gold,
            ),
            unselectedIconTheme: const IconThemeData(color: AppColors.muted),
            selectedLabelTextStyle: Theme.of(context).textTheme.labelLarge
                ?.copyWith(
                  color: hidden ? AppColors.muted : AppColors.gold,
                  fontWeight: FontWeight.w700,
                ),
            unselectedLabelTextStyle: Theme.of(context).textTheme.labelLarge
                ?.copyWith(color: AppColors.muted),
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 12),
              child: InkWell(
                onTap: () => context.go('/'),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  child: Text(
                    extended ? 'AXON-313' : 'AX',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.gold,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('الرئيسية'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.design_services_outlined),
                selectedIcon: Icon(Icons.design_services),
                label: Text('الخدمات'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.storefront_outlined),
                selectedIcon: Icon(Icons.storefront),
                label: Text('السوق'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.photo_library_outlined),
                selectedIcon: Icon(Icons.photo_library),
                label: Text('المعرض'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.chat_outlined),
                selectedIcon: Icon(Icons.chat),
                label: Text('تواصل'),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: Column(
              children: [
                _bar(context, title: _title),
                Expanded(child: child),
              ],
            ),
          ),
        ],
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
