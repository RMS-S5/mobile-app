import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rms_mobile_app/models/http_exception.dart';
import 'package:rms_mobile_app/widgets/simple_error_dialog.dart';

import '../../../providers/cart.dart';
import '../../../config/constants.dart';

class CartItem extends StatelessWidget {
  final String cartItemId;
  final String foodItemId;
  final String name;
  final quantity;
  final price;
  final variantName;
  final imageUrl;

  CartItem(
      {required this.cartItemId,
      required this.foodItemId,
      required this.name,
      required this.quantity,
      this.variantName = null,
      required this.imageUrl,
      required this.price});

  Future<void> removeCartItem(String cartItemId, BuildContext context) async {
    try {
      await Provider.of<Cart>(context, listen: false).removeItem(cartItemId);
    } on HttpException catch (error) {
      showErrorDialog(error.toString(), context);
    } catch (error) {
      showErrorDialog('Something went wrong.', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItemId),
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
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              'Do you want to remove the item from the cart?',
            ),
            actions: <Widget>[
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () async {
                  Navigator.of(ctx).pop(true);
                  try {
                    await removeCartItem(cartItemId, context);
                    // Navigator.of(ctx).pop(true);
                  } catch (error) {
                    // Navigator.of(ctx).pop(true);
                    showErrorDialog(error.toString(), context);
                  }
                },
              ),
            ],
          ),
        );
      },
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        await removeCartItem(cartItemId, context);
      },
      child: Card(
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
              'Rs.${double.parse(price).toStringAsFixed(2)}',
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
                  '${quantity.toString()} x',
                  style: inputTextStyle,
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: kRejectButtonColor,
                  onPressed: () async {
                    await removeCartItem(cartItemId, context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
