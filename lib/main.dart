//  --no-sound-null-safety
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rms_mobile_app/screens/customer/home/components/food_items_grid.dart';

import 'config/constants.dart';
import 'providers/categories.dart';
import 'providers/food_items.dart';

//Route Imports
import 'screens/customer/home/customer_home_screen.dart';
import 'screens/customer/details/food_item_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FoodItems(),
        ),
        ChangeNotifierProvider(
          create: (_) => Categories(),
        )
      ],
      child: MaterialApp(
        title: 'RMS',
        theme: ThemeData(
          fontFamily: fontFamily,
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: CustomerHomePageScreen(),
        initialRoute: CustomerHomePageScreen.routeName,
        routes: {
          CustomerHomePageScreen.routeName: (ctx) => CustomerHomePageScreen(),
          CustomerFoodItemScreen.routeName: (ctx) => CustomerFoodItemScreen(),
        },
      ),
    );
  }
}
