import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/about_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/contact_screen.dart';
import '../screens/gallery_screen.dart';
import '../screens/home_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/service_detail_screen.dart';
import '../screens/services_screen.dart';
import '../screens/shop_screen.dart';
import '../widgets/app_shell.dart';

Page<void> _page(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 460),
    reverseTransitionDuration: const Duration(milliseconds: 320),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final enter = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      final exit = CurvedAnimation(
        parent: secondaryAnimation,
        curve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: ReverseAnimation(exit),
        child: FadeTransition(
          opacity: enter,
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.025),
              end: Offset.zero,
            ).animate(enter),
            child: child,
          ),
        ),
      );
    },
  );
}

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(location: state.uri.path, child: child);
        },
        routes: [
          GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          GoRoute(
            path: '/services',
            pageBuilder: (context, state) =>
                _page(state, const ServicesScreen()),
            routes: [
              GoRoute(
                path: ':id',
                pageBuilder: (context, state) => _page(
                  state,
                  ServiceDetailScreen(id: state.pathParameters['id']!),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/about',
            pageBuilder: (context, state) => _page(state, const AboutScreen()),
          ),
          GoRoute(
            path: '/gallery',
            pageBuilder: (context, state) =>
                _page(state, const GalleryScreen()),
          ),
          GoRoute(
            path: '/shop',
            pageBuilder: (context, state) => _page(state, const ShopScreen()),
            routes: [
              GoRoute(
                path: ':id',
                pageBuilder: (context, state) => _page(
                  state,
                  ProductDetailScreen(id: state.pathParameters['id']!),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/cart',
            pageBuilder: (context, state) => _page(state, const CartScreen()),
          ),
          GoRoute(
            path: '/contact',
            pageBuilder: (context, state) =>
                _page(state, const ContactScreen()),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('الصفحة غير موجودة'))),
  );
}
