import 'package:flutter/material.dart';

// Food Item provider
class Categories with ChangeNotifier {
  List _categories = [
    {
      "categoryId": "123456",
      "categoryName": "Drinks",
      "description": "This is description of drink category",
      "imageUrl": "https://picsum.photos/id/237/300/200",
    },
    {
      "categoryId": "123457",
      "categoryName": "Kottu",
      "description": "This is description of drink category",
      "imageUrl": "https://picsum.photos/id/238/300/200",
    },
    {
      "categoryId": "123458",
      "categoryName": "Rice",
      "description": "This is description of drink category",
      "imageUrl": "https://picsum.photos/id/234/300/200",
    },
    {
      "categoryId": "123459",
      "categoryName": "Pizza",
      "description": "This is description of drink category",
      "imageUrl": "https://picsum.photos/id/230/300/200",
    },
    {
      "categoryId": "123457",
      "categoryName": "Kottu",
      "description": "This is description of drink category",
      "imageUrl": "https://picsum.photos/id/239/300/200",
    },
    {
      "categoryId": "123458",
      "categoryName": "Rice",
      "description": "This is description of drink category",
      "imageUrl": "https://picsum.photos/id/237/300/200",
    },
    {
      "categoryId": "123459",
      "categoryName": "Pizza",
      "description": "This is description of drink category",
      "imageUrl": "https://picsum.photos/id/235/300/200",
    },
    {
      "categoryId": "123457",
      "categoryName": "Kottu",
      "description": "This is description of drink category",
      "imageUrl": "https://picsum.photos/id/231/300/200",
    },
    {
      "categoryId": "123458",
      "categoryName": "Rice",
      "description": "This is description of drink category",
      "imageUrl": "https://picsum.photos/id/232/300/200",
    },
    {
      "categoryId": "123459",
      "categoryName": "Pizza",
      "description": "This is description of drink category",
      "imageUrl": "https://picsum.photos/id/233/300/200",
    },
  ];

  List get categories {
    return [..._categories];
  }

  Map findById(String foodItemId) {
    return _categories.firstWhere((foodItem) => foodItem.id == foodItemId);
  }

  // TODO: Implement add product logic
  void addCategory() {}
}
