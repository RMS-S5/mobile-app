import 'package:flutter/material.dart';

import './order_list_item.dart';

ListView orderList(List<dynamic> pendingOrders, String orderViewRouteName) {
  return ListView.builder(
    itemCount: pendingOrders.length,
    itemBuilder: (ctx, i) => Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: OrderListItem(
        orderId: pendingOrders[i]["orderId"],
        tableNumber: pendingOrders[i]["tableNumber"],
        placedTime: pendingOrders[i]["placedTime"],
        cartItems: pendingOrders[i]["cartItems"],
        orderViewRouteName: orderViewRouteName,
      ),
    ),
  );
}
