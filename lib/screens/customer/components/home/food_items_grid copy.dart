import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'food_item.dart';

class FoodItemsGrid extends StatelessWidget {
  final foodItems;

  FoodItemsGrid({this.foodItems});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 10,
      ),
      delegate: SliverChildBuilderDelegate(
          (BuildContext context, int i) => FoodItemCard(
                key: Key(foodItems[i]['foodItemId']),
                foodItemId: foodItems[i]['foodItemId'],
                imageUrl: foodItems[i]['imageUrl'],
                name: foodItems[i]['name'],
                price: foodItems[i]['price'],
              ),
          childCount: foodItems.length),
    );
  }
}
