import 'package:flutter/material.dart';

import '../api/api.dart';

// Food Item provider
class Categories with ChangeNotifier {
  List _categories = [];

  List get categories {
    return [..._categories];
  }

  Map findById(String foodItemId) {
    return _categories.firstWhere((foodItem) => foodItem.id == foodItemId);
  }

  Future<void> fetAndSetCategories() async {
    try {
      final response = await API.foodItemAPI.getAllCategories();
      _categories = response['data'] ?? [];
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // TODO: Implement add product logic
  void addCategory() {}
}
