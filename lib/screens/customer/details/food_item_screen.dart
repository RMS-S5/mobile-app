import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/constants.dart';
import '../../../providers/food_items.dart';
import '../../../widgets/drawers/customer_app_drawer.dart';

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
    // if(route == null) return SizedBox.shrink();
    // final foodItemId =
    //     route.settings.arguments as String;

    final loadedFoddItem = Provider.of<FoodItems>(
      context,
      listen: false,
    ).findById('123456');

    loadedFoddItem['foodVariants'].map((item) => print(item["variant_name"]));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDrawerBackgroudColor,
        title: Text(
          loadedFoddItem['name'],
          style: heading1Style,
        ),
      ),
      drawer: CustomerAppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: media.size.height * 0.4,
              width: double.infinity,
              child: Image.network(
                loadedFoddItem['imageUrl'],
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Rs. ${loadedFoddItem['name']}',
              style: heading1Style2,
            ),
            SizedBox(height: 10),
            Text(
              'Rs. ${loadedFoddItem['price']}',
              style: largePriceStyle1,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6),
              width: double.infinity,
              child: Text(
                loadedFoddItem['description'],
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
            Row(
              children: loadedFoddItem['foodVariants']
                  .map((variant) => Text(variant['variant_name'])

                      // Column(
                      //   key: Key(variant['variant_id']),
                      //   children: [
                      //     Icon(Icons.add),
                      //     Text(variant['variant_name'])
                      //   ],
                      // ),
                      )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
