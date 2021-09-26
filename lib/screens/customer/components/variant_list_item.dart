import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/constants.dart';
import '../../../providers/cart.dart';
import 'variant_dialog.dart';
import '../../../widgets/simple_error_dialog.dart';

class VariantListItem extends StatelessWidget {
  final variant;
  final loadedFoodItem;

  VariantListItem(
      {required this.variant, required this.loadedFoodItem, Key? key})
      : super(key: key);

  Future<void> handleAddToCart(context, cartItemData, quantity) async {
    try {
      if (int.parse(quantity) <= 0) {
        return;
      }
      await Provider.of<Cart>(context, listen: false).addCartItem(
          cartItemData['foodItemId'], cartItemData['price'], quantity,
          variantId: cartItemData['foodVariantId']);
    } catch (error) {
      const message = "Something went wrong.";
      showErrorDialog(message, context);
    }
  }

  handleUndo(quantity) {
    print("Handle undo");
    print(quantity);
  }

  @override
  Widget build(BuildContext context) {
    final cartItemData = {
      'foodItemId': loadedFoodItem['foodItemId'],
      'price': variant['price'],
      'foodVariantId': variant['foodVariantId']
    };
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: RichText(
              text: TextSpan(
                  text: variant['variantName'], style: titleTextStyle1),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'Rs. ${variant['price']?.toString()}',
                style: titleTextStyle1,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              constraints: BoxConstraints(),
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => VariantDialog(
                          cartItemData: cartItemData,
                          onAddToCart: handleAddToCart,
                          onUndo: handleUndo,
                        ));
              },
            ),
          ),
          //   child: Material(
          //     child: InkWell(
          //       customBorder: CircleBorder(
          //           side: BorderSide(
          //         width: 1,
          //       )),
          //       onTap: () {
          //         showDialog(
          //             context: context,
          //             builder: (ctx) => VariantDialog(
          //                   onAddToCart: handleAddToCart,
          //                   onUndo: handleUndo,
          //                 ));
          //       },
          //       splashColor: kPrimaryColor,
          //       child: Icon(
          //         Icons.shopping_cart_rounded,
          //         color: kPrimaryColor,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
