import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  Future<void> addProduct(Product product) async {}
  Future<void> updateProduct(String id, Product product) async {}
}
