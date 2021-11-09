import 'package:flutter_test/flutter_test.dart';
import 'package:rms_mobile_app/providers/orders.dart';

void main() {
  group("Order", () {
    final mockOrders = [
      {
        "orderId": "095af31d-23a8-4791-803f-cdd0c3a1c9ae",
        "customerId": null,
        "totalAmount": "500.00",
        "tableNumber": 1,
        "branchId": "6d691e41-0d3b-4377-804f-3b01a34cfabe",
        "orderStatus": "Preparing",
        "fcmToken":
            "flHmb9tTTwGtJJXG8NY-Q-:APA91bF3Ogk5dZun11AojFtopeR35-iQKrDa_OhIC2PhaYSM3D8NRm3J-C7UiLAELFQqKxFs-jMo63rEiN4E3q8BA3hmLHZl9bcVYR3UagV-W6m43XhoNXLyHbtmVQKDGNGdRcfZ3GHv",
        "placedTime": "2021-11-04T13:04:01.277Z",
        "waiterId": null,
        "kitchenStaffId": "93dd76d3-479f-456f-a112-2e09943147c0",
        "active": true,
        "cartItems": [
          {
            "cartItemId": "35710557-8df6-4d87-aba4-6719694a6e86",
            "foodItemId": "359d0cb9-87f6-4e3a-946b-6baa440b4241",
            "variantId": "a39ad550-0368-4ed3-981b-6a0a903ca0ae",
            "price": 500,
            "cartId": "c6969d88-f85a-4d62-bbc1-09de62606b90",
            "imageUrl": "photos-64cd303f-ff51-46c2-a7df-71983a33f7e4.jpg",
            "description": "Delicious Dolphin Kottu",
            "quantity": 2,
            "name": "Dolphin Kottu",
            "categoryId": "0633ab9a-7bdc-45c0-a1b7-8f9af9c7693f",
            "variantName": "Small"
          }
        ]
      },
      {
        "orderId": "0c2deb10-f288-4aa9-b81b-7e5f8dc267dd",
        "customerId": null,
        "totalAmount": "1350.00",
        "tableNumber": 1,
        "branchId": "6d691e41-0d3b-4377-804f-3b01a34cfabe",
        "orderStatus": "Placed",
        "fcmToken":
            "flHmb9tTTwGtJJXG8NY-Q-:APA91bF3Ogk5dZun11AojFtopeR35-iQKrDa_OhIC2PhaYSM3D8NRm3J-C7UiLAELFQqKxFs-jMo63rEiN4E3q8BA3hmLHZl9bcVYR3UagV-W6m43XhoNXLyHbtmVQKDGNGdRcfZ3GHv",
        "placedTime": "2021-11-04T18:44:41.172Z",
        "waiterId": null,
        "kitchenStaffId": null,
        "active": true,
        "cartItems": [
          {
            "cartItemId": "289232b1-2c1c-4d63-81a6-24943109ec27",
            "foodItemId": "0b4db77a-0fea-49ce-a1bf-7ebd581e1ea7",
            "variantId": "4f4a6051-17a2-40da-b257-9f737a7ec310",
            "price": 750,
            "cartId": "0c1d7da1-9ce5-4d3c-8168-1e0d496fbd44",
            "imageUrl": "photos-731c6feb-d8b5-4c24-8d91-df462e0220bb.jpg",
            "description": "Delicious Cheese Pizza",
            "quantity": 1,
            "name": "Cheese Pizza",
            "categoryId": "2cb02db6-d37e-4d0c-8ff1-a3728426e270",
            "variantName": "Small"
          },
          {
            "cartItemId": "34592545-adeb-4374-92df-b445b5c16544",
            "foodItemId": "1a853675-df20-4e17-9184-47fcf0de57df",
            "variantId": "bb4d2f4d-d795-4239-ae59-331f26b4c234",
            "price": 600,
            "cartId": "0c1d7da1-9ce5-4d3c-8168-1e0d496fbd44",
            "imageUrl": "photos-15d4c517-6137-4033-be4d-0d4a9e39d9c1.jpg",
            "description": "Delicious Veggie Pizza",
            "quantity": 1,
            "name": "Veggie Pizza",
            "categoryId": "2cb02db6-d37e-4d0c-8ff1-a3728426e270",
            "variantName": "Small"
          }
        ]
      },
    ];
    test('Given order with active orders return active orders', () async {
      // Arrange
      final orderProvider =
          Orders("", "", mockOrders, mockOrders, mockOrders, "");
      // Assert
      expect(orderProvider.activeOrders, mockOrders);
    });

    test('Given order with active orders return active orders count', () async {
      // Arrange
      final orderProvider =
          Orders("", "", mockOrders, mockOrders, mockOrders, "");
      // Assert
      expect(orderProvider.activeOrderCount, 2);
    });

    test('Given order with table orders return table orders', () async {
      // Arrange
      final orderProvider =
          Orders("", "", mockOrders, mockOrders, mockOrders, "");
      // Assert
      expect(orderProvider.tableOrders, mockOrders);
    });

    test('Given order with waiter served orders return waiter servied orders',
        () async {
      // Arrange
      final orderProvider =
          Orders("", "", mockOrders, mockOrders, mockOrders, "");
      // Assert
      expect(orderProvider.waiterServedOrders, mockOrders);
    });

    test('Without verifying table should return empty verfication code',
        () async {
      // Arrange
      final orderProvider =
          Orders("", "", mockOrders, mockOrders, mockOrders, "");
      // Assert
      expect(orderProvider.verificationCode, "");
    });

    test('Should return total amount of table orders', () async {
      // Arrange
      final orderProvider =
          Orders("", "", mockOrders, mockOrders, mockOrders, "");
      // Assert
      expect(orderProvider.tableTotalAmount, 1850.00);
    });

    test('Should return orders with given order status', () async {
      // Arrange
      final orderProvider =
          Orders("", "", mockOrders, mockOrders, mockOrders, "");
      // Assert
      expect(orderProvider.getOrdersByStatus("Placed"), [
        {
          "orderId": "0c2deb10-f288-4aa9-b81b-7e5f8dc267dd",
          "customerId": null,
          "totalAmount": "1350.00",
          "tableNumber": 1,
          "branchId": "6d691e41-0d3b-4377-804f-3b01a34cfabe",
          "orderStatus": "Placed",
          "fcmToken":
              "flHmb9tTTwGtJJXG8NY-Q-:APA91bF3Ogk5dZun11AojFtopeR35-iQKrDa_OhIC2PhaYSM3D8NRm3J-C7UiLAELFQqKxFs-jMo63rEiN4E3q8BA3hmLHZl9bcVYR3UagV-W6m43XhoNXLyHbtmVQKDGNGdRcfZ3GHv",
          "placedTime": "2021-11-04T18:44:41.172Z",
          "waiterId": null,
          "kitchenStaffId": null,
          "active": true,
          "cartItems": [
            {
              "cartItemId": "289232b1-2c1c-4d63-81a6-24943109ec27",
              "foodItemId": "0b4db77a-0fea-49ce-a1bf-7ebd581e1ea7",
              "variantId": "4f4a6051-17a2-40da-b257-9f737a7ec310",
              "price": 750,
              "cartId": "0c1d7da1-9ce5-4d3c-8168-1e0d496fbd44",
              "imageUrl": "photos-731c6feb-d8b5-4c24-8d91-df462e0220bb.jpg",
              "description": "Delicious Cheese Pizza",
              "quantity": 1,
              "name": "Cheese Pizza",
              "categoryId": "2cb02db6-d37e-4d0c-8ff1-a3728426e270",
              "variantName": "Small"
            },
            {
              "cartItemId": "34592545-adeb-4374-92df-b445b5c16544",
              "foodItemId": "1a853675-df20-4e17-9184-47fcf0de57df",
              "variantId": "bb4d2f4d-d795-4239-ae59-331f26b4c234",
              "price": 600,
              "cartId": "0c1d7da1-9ce5-4d3c-8168-1e0d496fbd44",
              "imageUrl": "photos-15d4c517-6137-4033-be4d-0d4a9e39d9c1.jpg",
              "description": "Delicious Veggie Pizza",
              "quantity": 1,
              "name": "Veggie Pizza",
              "categoryId": "2cb02db6-d37e-4d0c-8ff1-a3728426e270",
              "variantName": "Small"
            }
          ]
        },
      ]);
    });

    test('Should return order with given order id', () async {
      // Arrange
      final orderProvider =
          Orders("", "", mockOrders, mockOrders, mockOrders, "");
      // Assert
      expect(
        orderProvider
            .getOrdersByOrderId("0c2deb10-f288-4aa9-b81b-7e5f8dc267dd"),
        {
          "orderId": "0c2deb10-f288-4aa9-b81b-7e5f8dc267dd",
          "customerId": null,
          "totalAmount": "1350.00",
          "tableNumber": 1,
          "branchId": "6d691e41-0d3b-4377-804f-3b01a34cfabe",
          "orderStatus": "Placed",
          "fcmToken":
              "flHmb9tTTwGtJJXG8NY-Q-:APA91bF3Ogk5dZun11AojFtopeR35-iQKrDa_OhIC2PhaYSM3D8NRm3J-C7UiLAELFQqKxFs-jMo63rEiN4E3q8BA3hmLHZl9bcVYR3UagV-W6m43XhoNXLyHbtmVQKDGNGdRcfZ3GHv",
          "placedTime": "2021-11-04T18:44:41.172Z",
          "waiterId": null,
          "kitchenStaffId": null,
          "active": true,
          "cartItems": [
            {
              "cartItemId": "289232b1-2c1c-4d63-81a6-24943109ec27",
              "foodItemId": "0b4db77a-0fea-49ce-a1bf-7ebd581e1ea7",
              "variantId": "4f4a6051-17a2-40da-b257-9f737a7ec310",
              "price": 750,
              "cartId": "0c1d7da1-9ce5-4d3c-8168-1e0d496fbd44",
              "imageUrl": "photos-731c6feb-d8b5-4c24-8d91-df462e0220bb.jpg",
              "description": "Delicious Cheese Pizza",
              "quantity": 1,
              "name": "Cheese Pizza",
              "categoryId": "2cb02db6-d37e-4d0c-8ff1-a3728426e270",
              "variantName": "Small"
            },
            {
              "cartItemId": "34592545-adeb-4374-92df-b445b5c16544",
              "foodItemId": "1a853675-df20-4e17-9184-47fcf0de57df",
              "variantId": "bb4d2f4d-d795-4239-ae59-331f26b4c234",
              "price": 600,
              "cartId": "0c1d7da1-9ce5-4d3c-8168-1e0d496fbd44",
              "imageUrl": "photos-15d4c517-6137-4033-be4d-0d4a9e39d9c1.jpg",
              "description": "Delicious Veggie Pizza",
              "quantity": 1,
              "name": "Veggie Pizza",
              "categoryId": "2cb02db6-d37e-4d0c-8ff1-a3728426e270",
              "variantName": "Small"
            }
          ]
        },
      );
    });
  });
}
