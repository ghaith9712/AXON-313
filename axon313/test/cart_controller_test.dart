import 'package:axon313/data/catalog.dart';
import 'package:axon313/state/cart_controller.dart';
import 'package:axon313/utils/formatting.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('cart totals quantities and builds an order message', () {
    final cart = CartController();
    final camera = products.first;
    final recorder = products.firstWhere((product) => product.id == 'nvr-4');

    cart.add(camera);
    cart.add(camera);
    cart.add(recorder, quantity: 2);

    expect(cart.count, 4);
    expect(cart.total, camera.priceIqd * 2 + recorder.priceIqd * 2);

    cart.setQuantity(camera.id, 1);
    expect(cart.count, 3);
    expect(cart.lines.first.quantity, 1);

    final message = buildOrderMessage(
      cart: cart,
      name: 'غيث',
      phone: '07842555287',
      note: 'تركيب في اليرموك',
    );
    expect(message, contains('كاميرا قبة داخلية × 1'));
    expect(message, contains('جهاز تسجيل 4 قنوات × 2'));
    expect(message, contains('تركيب في اليرموك'));
    expect(message, contains(formatIqd(cart.total)));

    cart.remove(recorder.id);
    expect(cart.lines, hasLength(1));
    cart.clear();
    expect(cart.lines, isEmpty);
    expect(cart.total, 0);
  });

  test('formatIqd groups thousands', () {
    expect(formatIqd(75000), '75,000 د.ع');
    expect(formatIqd(1500000), '1,500,000 د.ع');
  });
}
