import 'package:axon313/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void _setSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('phone navigation adds a product to the cart', (tester) async {
    _setSize(tester, const Size(390, 844));

    await tester.pumpWidget(const AxonApp());
    await tester.pumpAndSettle();

    expect(find.text('AXON-313'), findsWidgets);
    expect(find.byType(NavigationBar), findsOneWidget);

    await tester.tap(find.text('السوق'));
    await tester.pumpAndSettle();

    expect(find.text('كاميرا قبة داخلية'), findsOneWidget);
    await tester.tap(find.text('كاميرا قبة داخلية'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('أضف إلى السلة'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.byTooltip('السلة'));
    await tester.pumpAndSettle();

    expect(find.text('كاميرا قبة داخلية'), findsWidgets);
    expect(find.textContaining('75,000'), findsWidgets);
  });

  testWidgets('wide layout shows a side rail', (tester) async {
    _setSize(tester, const Size(1400, 900));

    await tester.pumpWidget(const AxonApp());
    await tester.pumpAndSettle();

    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.text('AXON-313'), findsWidgets);
  });
}
