// //  --no-sound-null-safety
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// import './config/constants.dart';

// /**
//  * Providers imports
//  */
// import './providers/categories.dart';
// import './providers/food_items.dart';
// import './providers/cart.dart';
// import './providers/orders.dart';
// import './providers/notifications.dart';
// import './providers/user.dart';

// import './my_app.dart';

// class ProviderSetClass extends StatefulWidget {
//   const ProviderSetClass({Key? key}) : super(key: key);

//   @override
//   _ProviderSetClassState createState() => _ProviderSetClassState();
// }

// class _ProviderSetClassState extends State<ProviderSetClass> {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
      //   ChangeNotifierProvider(
      //     create: (_) => User(),
      //   ),
      //   ChangeNotifierProxyProvider<User, FoodItems>(
      //       create: (_) => FoodItems(),
      //       update: (ctx, user, previousFoodItems) => FoodItems(
      //           token: user.token ?? '',
      //           previousFoodItemData: previousFoodItems != null
      //               ? previousFoodItems.foodItems
      //               : [])),
      //   ChangeNotifierProvider(
      //     create: (_) => Categories(),
      //   ),
      //   ChangeNotifierProxyProvider<User, Cart>(
      //       create: (_) => Cart('', []),
      //       update: (ctx, user, previousCartItems) => Cart(user.token ?? '',
      //           previousCartItems != null ? previousCartItems.cartItems : [])),
      //   ChangeNotifierProxyProvider<User, Notifications>(
      //       create: (_) => Notifications('', []),
      //       update: (ctx, user, previousNotifications) => Notifications(
      //             user.token ?? '',
      //             previousNotifications != null
      //                 ? previousNotifications.notifications
      //                 : [],
      //           )),
      //   ChangeNotifierProxyProvider<User, Orders>(
      //       create: (_) => Orders('', '', [], {}, []),
      //       update: (ctx, user, previousOrders) => Orders(
      //             user.token ?? '',
      //             user.userData['userId'] ?? '',
      //             previousOrders != null ? previousOrders.activeOrders : [],
      //             previousOrders != null ? previousOrders.tableOrder : {},
      //             previousOrders != null
      //                 ? previousOrders.waiterServedOrders
      //                 : [],
      //           )),
      // ],
//       // child: MyApp(),
//       builder: (context, child) {
//         return MyApp();
//       },
//     );
//   }
// }


// //  --no-sound-null-safety
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// import 'providers_set.dart';



