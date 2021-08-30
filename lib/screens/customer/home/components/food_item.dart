import 'package:flutter/material.dart';
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              'customer/view-food-item',
              arguments: foodItemId,
            );
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          leading: Icon(Icons.favorite),
          title: Text(
            name,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {},
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
