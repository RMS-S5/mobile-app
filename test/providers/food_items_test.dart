import 'package:flutter_test/flutter_test.dart';
import 'package:rms_mobile_app/providers/food_items.dart';

void main() {
  group("Cart", () {
    final mockFoodItems = [
      {
        "foodItemId": "359d0cb9-87f6-4e3a-946b-6baa440b4241",
        "name": "Dolphin Kottu",
        "categoryId": "0633ab9a-7bdc-45c0-a1b7-8f9af9c7693f",
        "description": "Delicious Dolphin Kottu",
        "imageUrl": "photos-64cd303f-ff51-46c2-a7df-71983a33f7e4.jpg",
        "price": "250.00",
        "isAvailable": true,
        "active": true,
        "foodVariants": [
          {
            "foodVariantId": "a39ad550-0368-4ed3-981b-6a0a903ca0ae",
            "foodItemId": "359d0cb9-87f6-4e3a-946b-6baa440b4241",
            "variantName": "Small",
            "price": 250
          },
          {
            "foodVariantId": "d8b27bfa-556f-4e29-8e2c-12308c8f35ab",
            "foodItemId": "359d0cb9-87f6-4e3a-946b-6baa440b4241",
            "variantName": "Medium",
            "price": 450
          }
        ]
      },
      {
        "foodItemId": "6c72e518-36f3-42c7-b25c-8748d940251b",
        "name": "Chicken Pizza",
        "categoryId": "2cb02db6-d37e-4d0c-8ff1-a3728426e270",
        "description": "Delicious Chicken Pizza",
        "imageUrl": "photos-ce5b3cee-e364-4f7e-bf31-7f21704c8baa.jpg",
        "price": "700.00",
        "isAvailable": true,
        "active": true,
        "foodVariants": [
          {
            "foodVariantId": "fe07b54c-a99a-4275-a944-7d478b74d32f",
            "foodItemId": "6c72e518-36f3-42c7-b25c-8748d940251b",
            "variantName": "Small",
            "price": 700
          },
          {
            "foodVariantId": "d25481b1-0809-4404-9767-f17432a86ffd",
            "foodItemId": "6c72e518-36f3-42c7-b25c-8748d940251b",
            "variantName": "Medium",
            "price": 1200
          }
        ]
      },
    ];
    test('Given food item with food items return food items', () async {
      // Arrange
      final foodItemProvider = FoodItems("", mockFoodItems);
      // Assert
      expect(foodItemProvider.foodItems, mockFoodItems);
    });

    test('Should return food items belong to the given cateogry', () async {
      // Arrange
      final foodItemProvider = FoodItems("", mockFoodItems);
      // Assert
      expect(
          foodItemProvider
              .getFoodItemByCategory("2cb02db6-d37e-4d0c-8ff1-a3728426e270"),
          [
            {
              "foodItemId": "6c72e518-36f3-42c7-b25c-8748d940251b",
              "name": "Chicken Pizza",
              "categoryId": "2cb02db6-d37e-4d0c-8ff1-a3728426e270",
              "description": "Delicious Chicken Pizza",
              "imageUrl": "photos-ce5b3cee-e364-4f7e-bf31-7f21704c8baa.jpg",
              "price": "700.00",
              "isAvailable": true,
              "active": true,
              "foodVariants": [
                {
                  "foodVariantId": "fe07b54c-a99a-4275-a944-7d478b74d32f",
                  "foodItemId": "6c72e518-36f3-42c7-b25c-8748d940251b",
                  "variantName": "Small",
                  "price": 700
                },
                {
                  "foodVariantId": "d25481b1-0809-4404-9767-f17432a86ffd",
                  "foodItemId": "6c72e518-36f3-42c7-b25c-8748d940251b",
                  "variantName": "Medium",
                  "price": 1200
                }
              ]
            },
          ]);
    });

    test('Should return food items contain given search keyword', () async {
      // Arrange
      final foodItemProvider = FoodItems("", mockFoodItems);
      // Assert
      expect(foodItemProvider.getFoodItemByCategoryAndSearch("0", "pizza"), [
        {
          "foodItemId": "6c72e518-36f3-42c7-b25c-8748d940251b",
          "name": "Chicken Pizza",
          "categoryId": "2cb02db6-d37e-4d0c-8ff1-a3728426e270",
          "description": "Delicious Chicken Pizza",
          "imageUrl": "photos-ce5b3cee-e364-4f7e-bf31-7f21704c8baa.jpg",
          "price": "700.00",
          "isAvailable": true,
          "active": true,
          "foodVariants": [
            {
              "foodVariantId": "fe07b54c-a99a-4275-a944-7d478b74d32f",
              "foodItemId": "6c72e518-36f3-42c7-b25c-8748d940251b",
              "variantName": "Small",
              "price": 700
            },
            {
              "foodVariantId": "d25481b1-0809-4404-9767-f17432a86ffd",
              "foodItemId": "6c72e518-36f3-42c7-b25c-8748d940251b",
              "variantName": "Medium",
              "price": 1200
            }
          ]
        },
      ]);
    });

    test('Should return food items contain given search keyword', () async {
      // Arrange
      final foodItemProvider = FoodItems("", mockFoodItems);
      // Assert
      expect(
        foodItemProvider.findById("6c72e518-36f3-42c7-b25c-8748d940251b"),
        {
          "foodItemId": "6c72e518-36f3-42c7-b25c-8748d940251b",
          "name": "Chicken Pizza",
          "categoryId": "2cb02db6-d37e-4d0c-8ff1-a3728426e270",
          "description": "Delicious Chicken Pizza",
          "imageUrl": "photos-ce5b3cee-e364-4f7e-bf31-7f21704c8baa.jpg",
          "price": "700.00",
          "isAvailable": true,
          "active": true,
          "foodVariants": [
            {
              "foodVariantId": "fe07b54c-a99a-4275-a944-7d478b74d32f",
              "foodItemId": "6c72e518-36f3-42c7-b25c-8748d940251b",
              "variantName": "Small",
              "price": 700
            },
            {
              "foodVariantId": "d25481b1-0809-4404-9767-f17432a86ffd",
              "foodItemId": "6c72e518-36f3-42c7-b25c-8748d940251b",
              "variantName": "Medium",
              "price": 1200
            }
          ]
        },
      );
    });
  });
}
