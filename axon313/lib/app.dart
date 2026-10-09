import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'router/app_router.dart';
import 'state/cart_controller.dart';
import 'theme/app_theme.dart';

class AxonApp extends StatefulWidget {
  const AxonApp({super.key, this.cart});

  final CartController? cart;

  @override
  State<AxonApp> createState() => _AxonAppState();
}

class _AxonAppState extends State<AxonApp> {
  late final CartController _cart;
  late final bool _ownsCart;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _ownsCart = widget.cart == null;
    _cart = widget.cart ?? CartController();
    _router = createRouter();
  }

  @override
  void dispose() {
    _router.dispose();
    if (_ownsCart) _cart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartController>.value(
      value: _cart,
      child: MaterialApp.router(
        title: 'AXON-313',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        locale: const Locale('ar'),
        supportedLocales: const [Locale('ar')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: _router,
      ),
    );
  }
}
