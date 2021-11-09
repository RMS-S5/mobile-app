import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart.dart';
import '../../../config/constants.dart';

class OrderItem extends StatelessWidget {
  final String cartItemId;
  final String foodItemId;
  final String name;
  final quantity;
  final price;
  final variantName;
  final imageUrl;

  OrderItem(
      {required this.cartItemId,
      required this.foodItemId,
      required this.name,
      required this.quantity,
      this.variantName = null,
      required this.imageUrl,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: Image.network(
            imageUrl == null ? imageNotFoundImageUrl : getAWSImages(imageUrl),
            fit: BoxFit.fill,
          ).image,
        ),
        title: Text(
          name,
          style: titleTextStyle1,
        ),
        subtitle: Padding(
          padding: EdgeInsets.all(2),
          child: Text(
            'Total: Rs.${(price.toStringAsFixed(2))}',
            style: inputTextStyle.copyWith(fontSize: 14),
          ),
        ),
        trailing: FittedBox(
          child: Row(
            children: [
              Text(
                (variantName == null) ? "" : variantName,
                style: inputTextStyle,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '$quantity x',
                style: inputTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
