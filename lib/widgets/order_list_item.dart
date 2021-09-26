import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import '../../../config/constants.dart';

class OrderListItem extends StatelessWidget {
  final String orderId;
  final int tableNumber;
  final placedTime;
  final cartItems;
  final orderViewRouteName;

  OrderListItem(
      {required this.orderId,
      required this.tableNumber,
      required this.placedTime,
      required this.cartItems,
      required this.orderViewRouteName});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: ListTile(
        leading: CircleAvatar(
            backgroundImage: Image.asset(
          pendingOrderImageUrl,
          fit: BoxFit.cover,
        ).image),
        title: Text(
          'Table : ${tableNumber.toString()}',
          style: titleTextStyle1,
        ),
        subtitle: Text(
          'Placed Time : ${DateFormat.jm().format(DateTime.parse(placedTime))}',
          style: descriptionStyle1,
        ),
        trailing: FittedBox(
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.visibility),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    orderViewRouteName,
                    arguments: orderId,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
