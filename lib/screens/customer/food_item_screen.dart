import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/constants.dart';
import '../../providers/food_items.dart';
import '../../widgets/drawers/customer_app_drawer.dart';
import './components/food_item_details.dart';
import './components/app_bar.dart';

class CustomerFoodItemScreen extends StatefulWidget {
  static const routeName = '/customer/view-food-item';
  const CustomerFoodItemScreen({Key? key}) : super(key: key);

  @override
  _CustomerFoodItemScreenState createState() => _CustomerFoodItemScreenState();
}

class _CustomerFoodItemScreenState extends State<CustomerFoodItemScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final route = ModalRoute.of(context);
    if (route == null) return SizedBox.shrink();
    final foodItemId = route.settings.arguments as String;

    final loadedFoodItem = Provider.of<FoodItems>(
      context,
      listen: false,
    ).findById(foodItemId);
    return Scaffold(
      appBar: customerAppBar(context),
      // AppBar(
      //   iconTheme: IconThemeData(color: kTextColor),
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     loadedFoodItem['name'],
      //     style: heading1Style,
      //   ),
      // ),
      // drawer: CustomerAppDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: (media.orientation == Orientation.portrait)
                  ? media.size.height * 0.4
                  : media.size.height * 0.6,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: FadeInImage.assetNetwork(
                    placeholder: foodItemFadeImageUrl,
                    image: loadedFoodItem['imageUrl'],
                    fit: BoxFit.cover,
                  ))
                ],
              ),
            ),
            FoodItemDetails(
              loadedFoodItem: loadedFoodItem,
            ),
          ],
        ),
      ),
    );
  }
}
