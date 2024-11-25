import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:furnitui/models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  // Load categories from SharedPreferences
  Future<void> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final String? categoryData = prefs.getString('categories');
    if (categoryData != null) {
      final List<dynamic> jsonData = jsonDecode(categoryData);
      _categories = jsonData.map((data) => Category.fromJson(data)).toList();
      notifyListeners();
    }
  }

  // Add a new category and save it
  Future<void> addCategory(Category category) async {
    _categories.add(category);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('categories', jsonEncode(_categories.map((c) => c.toJson()).toList()));
    notifyListeners();
  }
}
