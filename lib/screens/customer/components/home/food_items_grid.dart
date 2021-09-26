import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'food_item.dart';

class FoodItemsGrid extends StatelessWidget {
  final foodItems;
  FoodItemsGrid({this.foodItems});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: foodItems.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => FoodItemCard(
        key: Key(foodItems[i]['foodItemId']),
        foodItemId: foodItems[i]['foodItemId'],
        imageUrl: foodItems[i]['imageUrl'],
        name: foodItems[i]['name'],
        price: foodItems[i]['price'],
      ),
    );
  }
}
