import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:furnitui/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  // Load products from SharedPreferences
  Future<void> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? productData = prefs.getString('products');
    if (productData != null) {
      final List<dynamic> jsonData = jsonDecode(productData);
      _products = jsonData.map((data) => Product.fromJson(data)).toList();
      notifyListeners();
    }
  }

  // Add a new product and save it
  Future<void> addProduct(Product product) async {
    _products.add(product);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('products', jsonEncode(_products.map((p) => p.toJson()).toList()));
    notifyListeners();
  }

  // Filter products by category
  List<Product> filterProductsByCategory(String category) {
    if (category == 'All') {
      return _products;
    }
    return _products.where((product) => product.category == category).toList();
  }
}
