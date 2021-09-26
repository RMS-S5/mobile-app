import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rms_mobile_app/models/http_exception.dart';

import '../../../providers/cart.dart';
import '../../../config/constants.dart';
import '../../../widgets/simple_error_dialog.dart';

class VariantDialog extends StatelessWidget {
  final quantityController = TextEditingController();
  final Function onAddToCart;
  final Function onUndo;
  final cartItemData;

  VariantDialog(
      {required this.onAddToCart,
      required this.onUndo,
      required this.cartItemData,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return AlertDialog(
      content: TextField(
        decoration: InputDecoration(
          labelText: 'Insert Quantity',
        ),
        keyboardType: TextInputType.number,
        controller: quantityController,
      ),
      actions: [
        ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          ),
          onPressed: () async {
            if (quantityController.text == null ||
                quantityController.text == "") {
              return;
            }
            try {
              await Provider.of<Cart>(context, listen: false).addCartItem(
                  cartItemData['foodItemId'],
                  cartItemData['price'],
                  int.parse(quantityController.text),
                  variantId: cartItemData['foodVariantId']);

              final snackBar = SnackBar(
                content: const Text('Food item is added to the cart!'),
                // action: SnackBarAction(
                //   label: 'Undo',
                //   onPressed: () => onUndo(quantityController.text),
                // ),
                duration: Duration(
                  milliseconds: 2000,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.of(context).pop();
            } on HttpException catch (error) {
              showErrorDialog(error.toString(), context);
            } catch (error) {
              print(error);
              const message = "Something went wrong.";
              showErrorDialog(message, context);
            }

            // SnackBar to display undo option
          },
          icon: Icon(Icons.shopping_cart, size: 18),
          label: Text("Add to Cart"),
        ),
        ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(kRejectButtonColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.cancel, size: 18),
          label: Text("Cancel"),
        ),
      ],
    );
  }
}
