//  --no-sound-null-safety
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import './services/local_notification_service.dart';
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
import './loading_screen.dart';
import './screens/auth/auth-screen.dart';
import './screens/profile-screen.dart';
import './screens/change_password_screen.dart';
import './screens/notifications_screen.dart';

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
import './screens/waiter/serving_orders_screen.dart';
import './screens/waiter/serving_order_view_screen.dart';
import './screens/waiter/served_orders_screen.dart';
import './screens/waiter/served_order_view_screen.dart';

import './screens/waiter/verify_table_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.initialize();
  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
                  user.userData['userId'] ?? '',
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
          home: LoadingScreen(),
          // initialRoute: WelcomeScreen.routeName,
          routes: {
            NotificationScreen.routeName: (ctx) => NotificationScreen(),
            WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            ChangePasswordScreen.routeName: (ctx) => ChangePasswordScreen(),
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
            WaiterServingOrdersScreen.routeName: (ctx) =>
                WaiterServingOrdersScreen(),
            WaiterServingOrderViewScreen.routeName: (ctx) =>
                WaiterServingOrderViewScreen(),
            WaiterServedOrdersScreen.routeName: (ctx) =>
                WaiterServedOrdersScreen(),
            WaiterServedOrderViewScreen.routeName: (ctx) =>
                WaiterServedOrderViewScreen(),
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
