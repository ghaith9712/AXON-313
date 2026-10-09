import 'package:axon313/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void _setSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

// The home hero and call-to-action areas loop forever, so pumpAndSettle would
// never finish. Advance time in fixed steps instead.
Finder _tab(String label) =>
    find.descendant(of: find.byType(NavigationBar), matching: find.text(label));

Future<void> _advance(WidgetTester tester, [int milliseconds = 1500]) async {
  await tester.pump();
  for (var elapsed = 0; elapsed < milliseconds; elapsed += 100) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  testWidgets('phone navigation adds a product to the cart', (tester) async {
    _setSize(tester, const Size(390, 844));

    await tester.pumpWidget(const AxonApp());
    await _advance(tester);

    expect(find.text('AXON-313'), findsWidgets);
    expect(find.byType(NavigationBar), findsOneWidget);

    await tester.tap(_tab('السوق'));
    await _advance(tester);

    expect(find.text('كاميرا قبة داخلية'), findsOneWidget);
    await tester.tap(find.text('كاميرا قبة داخلية'));
    await _advance(tester);

    await tester.ensureVisible(find.text('أضف إلى السلة'));
    await _advance(tester, 300);
    await tester.tap(find.text('أضف إلى السلة'));
    await _advance(tester, 400);

    await tester.tap(find.byTooltip('السلة'));
    await _advance(tester);

    expect(find.text('كاميرا قبة داخلية'), findsWidgets);
    expect(find.textContaining('75,000'), findsWidgets);
  });

  testWidgets('services list opens a service detail page', (tester) async {
    _setSize(tester, const Size(390, 844));

    await tester.pumpWidget(const AxonApp());
    await _advance(tester);

    await tester.tap(_tab('الخدمات'));
    await _advance(tester);

    expect(find.text('كاميرات المراقبة'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('كاميرات المراقبة'), 300);
    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, 250),
    );
    await _advance(tester, 300);
    await tester.tap(find.text('كاميرات المراقبة'));
    await _advance(tester);

    expect(find.text('اطلب هذه الخدمة'), findsWidgets);
    expect(find.byTooltip('رجوع'), findsOneWidget);
  });

  testWidgets('wide layout shows a top navigation bar', (tester) async {
    _setSize(tester, const Size(1400, 900));

    await tester.pumpWidget(const AxonApp());
    await _advance(tester);

    expect(find.byKey(const Key('desktop-nav')), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.text('AXON-313'), findsWidgets);
    expect(find.text('اطلب خدمة'), findsOneWidget);
  });
}
