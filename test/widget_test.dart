// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rms_mobile_app/main.dart';
import 'package:rms_mobile_app/config/constants.dart';

/**
 * Providers imports
 */
import 'package:rms_mobile_app/providers/categories.dart';
import 'package:rms_mobile_app/providers/food_items.dart';
import 'package:rms_mobile_app/providers/cart.dart';
import 'package:rms_mobile_app/providers/orders.dart';
import 'package:rms_mobile_app/providers/notifications.dart';
import 'package:rms_mobile_app/providers/user.dart';

//Widgets
import 'package:rms_mobile_app/screens/auth/auth-screen.dart';
import 'package:rms_mobile_app/screens/customer/customer_home_screen.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  testWidgets('Login page', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AuthScreen()));
    expect(find.text('Forgot Password?'), findsWidgets);
  });

  testWidgets('Customer Home Page', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => User(),
        ),
        ChangeNotifierProxyProvider<User, FoodItems>(
            create: null,
            update: (ctx, user, previousFoodItems) => FoodItems(
                user.token ?? '',
                previousFoodItems != null ? previousFoodItems.foodItems : [])),
        ChangeNotifierProvider(
          create: (_) => Categories(),
        ),
        ChangeNotifierProxyProvider<User, Cart>(
            create: null,
            update: (ctx, user, previousCartItems) => Cart(user.token ?? '',
                previousCartItems != null ? previousCartItems.cartItems : [])),
        ChangeNotifierProxyProvider<User, Notifications>(
            create: null,
            update: (ctx, user, previousNotifications) => Notifications(
                  user.token ?? '',
                  previousNotifications != null
                      ? previousNotifications.notifications
                      : [],
                )),
        ChangeNotifierProxyProvider<User, Orders>(
            create: null,
            update: (ctx, user, previousOrders) => Orders(
                user.token ?? '',
                user.userData['userId'] ?? '',
                previousOrders != null ? previousOrders.activeOrders : [],
                previousOrders != null ? previousOrders.tableOrders : [],
                previousOrders != null ? previousOrders.waiterServedOrders : [],
                previousOrders != null ? previousOrders.fcmToken : null)),
      ],
      child: Consumer<User>(builder: (ctx, user, _) {
        return MaterialApp(
          title: 'NPNFood',
          theme: ThemeData(
            fontFamily: fontFamily,
            primaryColor: kPrimaryColor,
            accentColor: kSecondaryColor,
            errorColor: kRejectButtonColor,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: CustomerHomePageScreen(),
        );
      }),
    ));
    expect(find.text('Chicken'), findsNothing);
  });
}
