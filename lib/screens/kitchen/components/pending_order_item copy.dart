import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart.dart';
import '../../../config/constants.dart';

class PendingOrderItem extends StatelessWidget {
  final String orderId;
  final int tableNumber;
  final placedTime;
  final cartItems;

  PendingOrderItem(
      {required this.orderId,
      required this.tableNumber,
      required this.placedTime,
      required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(orderId),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(orderId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    RichText(
                        text: TextSpan(text: "Table", style: inputTextStyle)),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        '${tableNumber.toString()}',
                        style: titleTextStyle1,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: cartItems
                      .map<Widget>(
                        (cartItem) => FittedBox(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Text(
                                  cartItem["name"],
                                  style: descriptionStyle1,
                                ),
                                SizedBox(width: 18),
                                Text(
                                  cartItem["variant_name"],
                                  style: descriptionStyle1,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '${cartItem["quantity"].toString()} x',
                                  style: descriptionStyle1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.check),
                      color: kSuccessButtonColor,
                      onPressed: () {},
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      color: kRejectButtonColor,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
