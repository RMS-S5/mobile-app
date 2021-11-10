import 'package:flutter/material.dart';

import '../api/api.dart';

// Food Item provider
class FoodItems with ChangeNotifier {
  List _foodItems = [];

  String _token = "";

  FoodItems(this._token, previousFoodItemData) {
    // this._token = token;
    this._foodItems = previousFoodItemData;
  }

  // Return all the food items
  List get foodItems {
    return [..._foodItems];
  }

  // Get food items only by category filter
  List getFoodItemByCategory(String categoryId) {
    if (categoryId == '0') {
      return [..._foodItems];
    } else {
      return _foodItems
          .where((foodItem) => foodItem['categoryId'] == categoryId)
          .toList();
    }
  }

  // Get food items filter by category and search keyword
  List getFoodItemByCategoryAndSearch(String categoryId, String searchKey) {
    var _viewFoodItems = [];
    if (categoryId == '0') {
      _viewFoodItems = [..._foodItems];
    } else {
      _viewFoodItems = _foodItems
          .where((foodItem) => foodItem['categoryId'] == categoryId)
          .toList();
    }
    if (searchKey == "") {
      return _viewFoodItems;
    } else {
      return _viewFoodItems
          .where((foodItem) =>
              foodItem['name'].toLowerCase().contains(searchKey.toLowerCase()))
          .toList();
    }
  }

  // Find food item by food item id
  Map findById(String foodItemId) {
    return _foodItems
        .firstWhere((foodItem) => foodItem['foodItemId'] == foodItemId);
  }

  // Fetch and set all food items
  Future<void> fetchAndSetFoodItems() async {
    try {
      final response = await API.foodItemAPI.getAllFoodItems();
      _foodItems = response['data'] ?? [];
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
