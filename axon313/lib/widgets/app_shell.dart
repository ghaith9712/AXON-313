import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import 'brand_mark.dart';
import 'cart_button.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.location, required this.child});

  final String location;
  final Widget child;

  static const _paths = ['/', '/services', '/shop', '/gallery', '/contact'];
  static const _labels = ['الرئيسية', 'الخدمات', 'السوق', 'المعرض', 'تواصل'];

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
    return ColoredBox(
      color: AppColors.background,
      child: Stack(
        children: [
          const Positioned.fill(child: _Backdrop()),
          wide ? _wide(context) : _phone(context),
        ],
      ),
    );
  }

  Widget _phone(BuildContext context) {
    final hidden = _index < 0;
    final bar = NavigationBar(
      selectedIndex: hidden ? 0 : _index,
      onDestinationSelected: (index) => context.go(_paths[index]),
      destinations: _destinations,
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: _showBack ? 0 : 20,
        leading: _showBack
            ? IconButton(
                tooltip: 'رجوع',
                onPressed: () => context.pop(),
                icon: const BackButtonIcon(),
              )
            : null,
        title: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => context.go('/'),
          child: const _Brand(),
        ),
        actions: [
          IconButton(
            tooltip: 'من نحن',
            onPressed: () => context.go('/about'),
            icon: const Icon(Icons.info_outline_rounded),
          ),
          const CartButton(),
          const SizedBox(width: 12),
        ],
      ),
      body: child,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.navy.withValues(alpha: 0.07),
              blurRadius: 24,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: hidden
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
      ),
    );
  }

  Widget _wide(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          _TopNav(
            index: _index,
            showBack: _showBack,
            paths: _paths,
            labels: _labels,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  static const _destinations = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home_rounded),
      label: 'الرئيسية',
    ),
    NavigationDestination(
      icon: Icon(Icons.grid_view_outlined),
      selectedIcon: Icon(Icons.grid_view_rounded),
      label: 'الخدمات',
    ),
    NavigationDestination(
      icon: Icon(Icons.storefront_outlined),
      selectedIcon: Icon(Icons.storefront_rounded),
      label: 'السوق',
    ),
    NavigationDestination(
      icon: Icon(Icons.photo_library_outlined),
      selectedIcon: Icon(Icons.photo_library_rounded),
      label: 'المعرض',
    ),
    NavigationDestination(
      icon: Icon(Icons.chat_bubble_outline_rounded),
      selectedIcon: Icon(Icons.chat_bubble_rounded),
      label: 'تواصل',
    ),
  ];
}

class _Backdrop extends StatelessWidget {
  const _Backdrop();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          PositionedDirectional(
            top: -180,
            end: -140,
            child: _Orb(
              size: 520,
              color: AppColors.mint.withValues(alpha: 0.5),
            ),
          ),
          PositionedDirectional(
            top: 240,
            start: -220,
            child: _Orb(
              size: 520,
              color: AppColors.blueMid.withValues(alpha: 0.16),
            ),
          ),
        ],
      ),
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const BrandMark(size: 34),
        const SizedBox(width: 10),
        Text(
          'AXON-313',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.navy,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}

class _TopNav extends StatelessWidget {
  const _TopNav({
    required this.index,
    required this.showBack,
    required this.paths,
    required this.labels,
  });

  final int index;
  final bool showBack;
  final List<String> paths;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 4),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: DecoratedBox(
            key: const Key('desktop-nav'),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.94),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: AppColors.navy.withValues(alpha: 0.08),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  if (showBack)
                    IconButton(
                      tooltip: 'رجوع',
                      onPressed: () => context.pop(),
                      icon: const BackButtonIcon(),
                    ),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => context.go('/'),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      child: _Brand(),
                    ),
                  ),
                  const Spacer(),
                  for (var i = 0; i < labels.length; i++)
                    _NavItem(
                      label: labels[i],
                      selected: index == i,
                      onTap: () => context.go(paths[i]),
                    ),
                  const Spacer(),
                  IconButton(
                    tooltip: 'من نحن',
                    onPressed: () => context.go('/about'),
                    icon: const Icon(Icons.info_outline_rounded),
                  ),
                  const CartButton(),
                  const SizedBox(width: 8),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                      ),
                    ),
                    onPressed: () => context.go('/contact'),
                    child: const Text('اطلب خدمة'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: widget.onTap,
        onHover: (value) => setState(() => _hovered = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.greenLight
                : _hovered
                ? AppColors.blueSoft
                : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: selected ? AppColors.green : AppColors.muted,
              fontWeight: selected ? FontWeight.w900 : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
