import 'package:flutter_test/flutter_test.dart';
import 'package:rms_mobile_app/providers/cart.dart';

void main() {
  group("Cart", () {
    final mockCartItems = [
      {
        "cartItemId": "ad6cc886-4800-49dc-96d3-16063fa38dae",
        "foodItemId": "6c72e518-36f3-42c7-b25c-8748d940251b",
        "variatnId": "fe07b54c-a99a-4275-a944-7d478b74d32f",
        "price": "1400",
        "cartId": "c1720675-4ac2-4469-af7f-b8ea953118eb",
        "quantity": 2
      },
      {
        "cartItemId": "579169a6-eb9c-4909-bdda-6a113f51b02b",
        "foodItemId": "6c72e518-36f3-42c7-b25c-8748d940251b",
        "variatnId": "fe07b54c-a99a-4275-a944-7d478b74d32f",
        "price": "1000",
        "cartId": "c1720675-4ac2-4469-af7f-b8ea953118eb",
        "quantity": 2
      }
    ];
    test('Given cart with food items return item count', () async {
      // Arrange
      final cartProvider = Cart("", mockCartItems);
      // Assert
      expect(cartProvider.itemCount, 2);
    });

    test('Given cart with food items return total amount', () async {
      // Arrange
      final cartProvider = Cart("", mockCartItems);
      // Assert
      expect(cartProvider.totalAmount, 2400);
    });

    test('Given cart with food items return total amount', () async {
      // Arrange
      final cartProvider = Cart("", mockCartItems);
      // Assert
      expect(cartProvider.cartItemsIds, [
        "ad6cc886-4800-49dc-96d3-16063fa38dae",
        "579169a6-eb9c-4909-bdda-6a113f51b02b"
      ]);
    });
  });
}
