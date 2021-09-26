import 'package:flutter/material.dart';
import 'package:rms_mobile_app/screens/customer/food_item_screen.dart';
import '../../../../config/constants.dart';

/**
 * Food Item card for the Food grid view
 */
class FoodItemCard extends StatelessWidget {
  final foodItemId;
  final name;
  final imageUrl;
  final price;

  const FoodItemCard(
      {this.foodItemId, this.name, this.imageUrl, this.price, required Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  CustomerFoodItemScreen.routeName,
                  arguments: foodItemId,
                );
              },
              child: FadeInImage.assetNetwork(
                  placeholder: foodItemFadeImageUrl, image: imageUrl)
              // child: Image.network(
              //   imageUrl,
              //   fit: BoxFit.cover,
              // ),
              ),
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            // leading: Icon(Icons.favorite),
            title: RichText(
              text: TextSpan(text: name),
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
            ),
            subtitle: RichText(
              text: TextSpan(text: price.toString()),
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  CustomerFoodItemScreen.routeName,
                  arguments: foodItemId,
                );
              },
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
