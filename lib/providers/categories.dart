import 'package:flutter/material.dart';

import '../api/api.dart';

// Food Item provider
class Categories with ChangeNotifier {
  List _categories = [];

  // Return all the categories
  List get categories {
    return [..._categories];
  }

  // Return category by category id
  Map findById(String foodItemId) {
    return _categories.firstWhere((foodItem) => foodItem.id == foodItemId);
  }

  // Fetch and set categories
  Future<void> fetAndSetCategories() async {
    try {
      final response = await API.foodItemAPI.getAllCategories();
      _categories = response['data'] ?? [];
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
