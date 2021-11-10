import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../widgets/notification_wrapper.dart';
import '../widgets/simple_error_dialog.dart';

import './providers/user.dart';
import './providers/orders.dart';
import './providers/notifications.dart';
import './services/local_notification_service.dart';

/**
 * Route imports
 */
// Common Screen
import './screens/auth/auth-screen.dart';
import './screens/profile-screen.dart';
import './screens/change_password_screen.dart';
import './screens/splash-screen.dart';

// Customer Screens
import 'screens/customer/customer_home_screen.dart';

// Kitchen Staff Screens
import './screens/kitchen/pending_orders_screen.dart';
import './screens/welcome-screen.dart';

// Waiter Screens
import './screens/waiter/prepared_orders_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String? _fmToken;
  bool _isLoading = false;

  Future<void> subscribeToEvent() async {
    final accountType = Provider.of<User>(context, listen: false).accountType;

    if (accountType == null || accountType == 'customer') {
      final _fcmToken = await FirebaseMessaging.instance.getToken();
      print('tokenset');
      print(_fcmToken);
      Provider.of<Orders>(context, listen: false).setFCMToken(_fcmToken);
      return;
    }
    // If subscribed earlier, unsubscribe them.
    // await FirebaseMessaging.instance
    //     .unsubscribeFromTopic('order-kitchen-staff');
    // await FirebaseMessaging.instance.unsubscribeFromTopic('order-customer');
    // await FirebaseMessaging.instance.unsubscribeFromTopic('order-waiter');

    // switch (accountType) {
    //   case 'Kitchen Staff':
    //     print('Kitchen topic');
    //     await FirebaseMessaging.instance
    //         .subscribeToTopic('order-kitchen-staff');
    //     break;
    //   case 'Waiter':
    //     print('Waiter topic');
    //     await FirebaseMessaging.instance.subscribeToTopic('order-waiter');
    //     break;
    //   default:
    //     break;
    // }
  }

  Future<void> _onLoad() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<User>(context, listen: false).tryAutoLogin();
    setState(() {
      _isLoading = false;
    });
    await subscribeToEvent();
  }

  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await _onLoad();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return _isLoading
        ? SplashScreen()
        : user.isAuth()
            ? userHomeScreen(user.isAuth(), user.accountType)
            : WelcomeScreen();
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
