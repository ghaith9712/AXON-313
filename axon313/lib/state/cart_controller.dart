import 'package:flutter/foundation.dart';

import '../models/catalog_models.dart';

class CartLine {
  CartLine({required this.product, required this.quantity});

  final Product product;
  int quantity;
}

class CartController extends ChangeNotifier {
  final List<CartLine> _lines = [];

  List<CartLine> get lines => List.unmodifiable(_lines);

  int get count => _lines.fold(0, (sum, line) => sum + line.quantity);

  int get total => _lines.fold(
    0,
    (sum, line) => sum + line.product.priceIqd * line.quantity,
  );

  void add(Product product, {int quantity = 1}) {
    if (quantity < 1) return;
    final index = _lines.indexWhere((line) => line.product.id == product.id);
    if (index >= 0) {
      _lines[index].quantity += quantity;
    } else {
      _lines.add(CartLine(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void setQuantity(String productId, int quantity) {
    final index = _lines.indexWhere((line) => line.product.id == productId);
    if (index < 0) return;
    if (quantity < 1) {
      _lines.removeAt(index);
    } else {
      _lines[index].quantity = quantity;
    }
    notifyListeners();
  }

  void remove(String productId) {
    final before = _lines.length;
    _lines.removeWhere((line) => line.product.id == productId);
    if (_lines.length != before) notifyListeners();
  }

  void clear() {
    if (_lines.isEmpty) return;
    _lines.clear();
    notifyListeners();
  }
}
