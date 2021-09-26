import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/constants.dart';
import 'variant_dialog.dart';
import 'variant_list.dart';
import '../../../widgets/simple_error_dialog.dart';
import '../../../providers/cart.dart';

class FoodItemDetails extends StatefulWidget {
  final loadedFoodItem;

  const FoodItemDetails({required this.loadedFoodItem, Key? key})
      : super(key: key);

  @override
  State<FoodItemDetails> createState() => _FoodItemDetailsState();
}

class _FoodItemDetailsState extends State<FoodItemDetails> {
  // int _quantity = 0;

  // handleQuantityChange(String qunatity) {
  //   if (qunatity == "" || qunatity == null) return;
  //   setState(() {
  //     _quantity = int.parse(qunatity);
  //   });
  // }

  Future<void> handleAddToCart(context, foodItemData, quantity) async {
    try {
      if (quantity <= 0) return;
      await Provider.of<Cart>(context).addCartItem(
          foodItemData['foodItemId'], foodItemData['price'], quantity,
          variantId: foodItemData['foodVariantId']);
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
      'foodItemId': widget.loadedFoodItem['foodItemId'],
      'price': widget.loadedFoodItem['price'],
    };
    final media = MediaQuery.of(context);
    return Container(
      width: media.size.width,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(
            '${widget.loadedFoodItem['name']}',
            style: heading1Style,
          ),
          SizedBox(height: 10),
          Text(
            'Rs. ${widget.loadedFoodItem['price']}',
            style: largePriceStyle1,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6),
            width: double.infinity,
            child: Text(
              widget.loadedFoodItem['description'],
              textAlign: TextAlign.center,
              softWrap: true,
              style: descriptionStyle1,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Choices',
            style: heading1Style2,
          ),
          SizedBox(height: 10),
          (widget.loadedFoodItem['foodVariants'].length == 0)
              ? Container(
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kPrimaryColor),
                    ),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (ctx) => VariantDialog(
                                cartItemData: cartItemData,
                                onAddToCart: handleAddToCart,
                                onUndo: handleUndo,
                              ));
                    },
                    icon: Icon(Icons.shopping_cart, size: 18),
                    label: Text("Add to Cart"),
                  ),
                )
              : VariantList(loadedFoodItem: widget.loadedFoodItem)
        ],
      ),
    );
  }
}
