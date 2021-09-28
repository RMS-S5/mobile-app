//  --no-sound-null-safety
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rms_mobile_app/screens/customer/components/home/food_items_grid.dart';

import './config/constants.dart';

/**
 * Providers imports
 */
import './providers/categories.dart';
import './providers/food_items.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/notifications.dart';
import './providers/user.dart';

/**
 * Route imports
 */
// Common Screen
import './screens/auth/auth-screen.dart';
import './screens/profile-screen.dart';

// Customer Screens
import 'screens/customer/customer_home_screen.dart';
import 'screens/customer/food_item_screen.dart';
import 'screens/customer/cart_screen.dart';
import 'screens/customer/order_screen.dart';
import 'screens/customer/table_verification_screen.dart';
import 'screens/customer/qr_scanner.dart';

// Kitchen Staff Screens
import './screens/kitchen/pending_orders_screen.dart';
import './screens/kitchen/pending_order_view_screen.dart';
import './screens/kitchen/preparing_orders_screen.dart';
import './screens/kitchen/preparing_order_view_screen.dart';
import './screens/kitchen/prepared_orders_screen.dart';
import './screens/kitchen/prepared_order_view_screen.dart';
import './screens/welcome-screen.dart';

// Waiter Screens
import './screens/waiter/prepared_orders_screen.dart';
import './screens/waiter/prepared_order_view_screen.dart';
import './screens/waiter/verify_table_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
                  previousOrders != null ? previousOrders.activeOrders : [],
                  previousOrders != null ? previousOrders.tableOrder : {},
                  previousOrders != null
                      ? previousOrders.waiterServedOrders
                      : [],
                )),
      ],
      child: Consumer<User>(
        builder: (ctx, user, _) => MaterialApp(
          title: 'RMS',
          theme: ThemeData(
            fontFamily: fontFamily,
            primaryColor: kPrimaryColor,
            accentColor: kSecondaryColor,
            errorColor: kRejectButtonColor,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: user.isAuth()
              ? userHomeScreen(user.isAuth(), user.accountType)
              : FutureBuilder(
                  future: user.tryAutoLogin(),
                  builder: (ctx, userResultSnapShot) =>
                      userResultSnapShot.connectionState ==
                              ConnectionState.waiting
                          ? WelcomeScreen()
                          : WelcomeScreen(),
                ),
          // initialRoute: WelcomeScreen.routeName,
          routes: {
            WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            CustomerHomePageScreen.routeName: (ctx) => CustomerHomePageScreen(),
            CustomerFoodItemScreen.routeName: (ctx) => CustomerFoodItemScreen(),
            CustomerCartScreen.routeName: (ctx) => CustomerCartScreen(),
            CustomerOrderScreen.routeName: (ctx) => CustomerOrderScreen(),
            TableVerificationScreen.routeName: (ctx) =>
                TableVerificationScreen(),
            KitchenStaffPendingOrdersScreen.routeName: (ctx) =>
                KitchenStaffPendingOrdersScreen(),
            KitchenStaffPendingOrderViewScreen.routeName: (ctx) =>
                KitchenStaffPendingOrderViewScreen(),
            KitchenStaffPreparingOrdersScreen.routeName: (ctx) =>
                KitchenStaffPreparingOrdersScreen(),
            KitchenStaffPreparingOrderViewScreen.routeName: (ctx) =>
                KitchenStaffPreparingOrderViewScreen(),
            KitchenStaffPreparedOrdersScreen.routeName: (ctx) =>
                KitchenStaffPreparedOrdersScreen(),
            KitchenStaffPreparedOrderViewScreen.routeName: (ctx) =>
                KitchenStaffPreparedOrderViewScreen(),
            WaiterPreparedOrdersScreen.routeName: (ctx) =>
                WaiterPreparedOrdersScreen(),
            WaiterPreparedOrderViewScreen.routeName: (ctx) =>
                WaiterPreparedOrderViewScreen(),
            VerifyTableScreen.routeName: (ctx) => VerifyTableScreen(),
            QRScanner.routeName: (ctx) => QRScanner(),
          },
        ),
      ),
    );
  }
}

Widget userHomeScreen(bool loggedIn, String? accountType) {
  if (!loggedIn || accountType == null) {
    return AuthScreen();
  }
  switch (accountType) {
    case 'Customer':
      return CustomerHomePageScreen();
      break;
    case 'Kitchen Staff':
      return KitchenStaffPendingOrdersScreen();
      break;
    case 'Waiter':
      return WaiterPreparedOrdersScreen();
      break;
    default:
      return WelcomeScreen();
      break;
  }
}
