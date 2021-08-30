import 'package:flutter/material.dart';

// Food Item provider
class FoodItems with ChangeNotifier {
  List _foodItems = [
    {
      "foodItemId": "123456",
      "name": "Cheese Burger",
      "description": "This is descriptoin about cheese Burger",
      "price": 450.00,
      "imageUrl": "https://picsum.photos/seed/picsum/300/200",
      "foodVariants": {
        {"variant_id": "1234", "variant_name": "small", "price": 250},
        {"variant_id": "12345", "variant_name": "Medium", "price": 650},
        {"variant_id": "456132", "variant_name": "Large", "price": 850},
      }
    },
    {
      "foodItemId": "123456",
      "name": "Hot Burger",
      "description": "This is descriptoin about cheese Burger",
      "price": 450.00,
      "imageUrl": "https://picsum.photos/seed/picsum/300/200",
      "foodVariants": {}
    },
    {
      "foodItemId": "123458",
      "name": "Rowdy Burger",
      "description": "This is descriptoin about cheese Burger",
      "price": 450.00,
      "imageUrl": "https://picsum.photos/seed/picsum/300/200",
      "foodVariants": {}
    },
    {
      "foodItemId": "123459",
      "name": "Fish Burger",
      "description": "This is descriptoin about cheese Burger",
      "price": 450.00,
      "imageUrl": "https://picsum.photos/seed/picsum/300/200",
      "foodVariants": {}
    },
    {
      "foodItemId": "123456",
      "name": "Hot Burger",
      "description": "This is descriptoin about cheese Burger",
      "price": 450.00,
      "imageUrl": "https://picsum.photos/seed/picsum/300/200",
      "foodVariants": {}
    },
    {
      "foodItemId": "123458",
      "name": "Rowdy Burger",
      "description": "This is descriptoin about cheese Burger",
      "price": 450.00,
      "imageUrl": "https://picsum.photos/seed/picsum/300/200",
      "foodVariants": {}
    },
    {
      "foodItemId": "123459",
      "name": "Fish Burger",
      "description": "This is descriptoin about cheese Burger",
      "price": 450.00,
      "imageUrl": "https://picsum.photos/seed/picsum/300/200",
      "foodVariants": {}
    },
    {
      "foodItemId": "123456",
      "name": "Hot Burger",
      "description": "This is descriptoin about cheese Burger",
      "price": 450.00,
      "imageUrl": "https://picsum.photos/seed/picsum/300/200",
      "foodVariants": {}
    },
    {
      "foodItemId": "123458",
      "name": "Rowdy Burger",
      "description": "This is descriptoin about cheese Burger",
      "price": 450.00,
      "imageUrl": "https://picsum.photos/seed/picsum/300/200",
      "foodVariants": {}
    },
    {
      "foodItemId": "123459",
      "name": "Fish Burger",
      "description": "This is descriptoin about cheese Burger",
      "price": 450.00,
      "imageUrl": "https://picsum.photos/seed/picsum/300/200",
      "foodVariants": {}
    },
  ];

  List get foodItems {
    return [..._foodItems];
  }

  Map findById(String foodItemId) {
    return _foodItems
        .firstWhere((foodItem) => foodItem['foodItemId'] == foodItemId);
  }

  // TODO: Implement add product logic
  void addFoodItem() {}
}
