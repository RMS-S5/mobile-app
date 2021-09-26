import 'package:flutter/material.dart';
import '../../../widgets/order_food_item.dart';

Expanded orderViewItemList(Map<dynamic, dynamic> orderData) {
  return Expanded(
    child: ListView.builder(
      itemCount: orderData["cartItems"].length,
      itemBuilder: (ctx, i) => OrderItem(
        cartItemId: orderData["cartItems"][i]["cartItemId"],
        foodItemId: orderData["cartItems"][i]["foodItemId"],
        imageUrl: orderData["cartItems"][i]["imageUrl"],
        name: orderData["cartItems"][i]["name"],
        price: orderData["cartItems"][i]["price"],
        quantity: orderData["cartItems"][i]["quantity"],
        variantName: orderData["cartItems"][i]['variant_name'],
      ),
    ),
  );
}
