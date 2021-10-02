import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rms_mobile_app/widgets/simple_error_dialog.dart';

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
    print(accountType);
    await FirebaseMessaging.instance
        .unsubscribeFromTopic('order-kitchen-staff');
    await FirebaseMessaging.instance.unsubscribeFromTopic('order-customer');
    await FirebaseMessaging.instance.unsubscribeFromTopic('order-waiter');
    switch (accountType) {
      case 'Customer':
        print('Customer topic');
        await FirebaseMessaging.instance.subscribeToTopic('order-customer');
        break;
      case 'Kitchen Staff':
        print('Kitchen topic');
        await FirebaseMessaging.instance
            .subscribeToTopic('order-kitchen-staff');
        break;
      case 'Waiter':
        print('Waiter topic');
        await FirebaseMessaging.instance.subscribeToTopic('order-waiter');
        break;
      default:
        break;
    }
  }

  // Handle incoming notifications
  Future<void> handleNotifications(RemoteMessage message) async {
    try {
      print("Handle notification called");
      final accountType = Provider.of<User>(context, listen: false).accountType;
      final tableData = Provider.of<Orders>(context, listen: false).tableData;
      print("this is accountttt");
      print(accountType);
      LocalNotificationService.display(message);

      Provider.of<Notifications>(context, listen: false)
          .addNotifications(message);

      if (message.data != null) {
        final type = message.data['type'];
        print("this is type");
        print(type);
        switch (type) {
          case 'customer':
            if (tableData.isEmpty) {
              break;
              return;
            }
            await Provider.of<Orders>(context, listen: false)
                .fetchAndSetTableOrder();
            break;
          case 'staff':
            if (accountType == null ||
                accountType == "" ||
                accountType == 'Customer') {
              break;
              return;
            }
            await Provider.of<Orders>(context, listen: false)
                .fetchAndSetActiveOrders();
            break;
          default:
            break;
        }
      }
    } catch (error) {
      print('Handle notifications error');
      print(error);
      // showErrorDialog(error.toString(), context);
    }
  }

  Future<void> setupInteractedMessage() async {
    // Subscribe to relevant topics
    await subscribeToEvent();

    // FirebaseMessaging.instance.getInitialMessage().then((message) {
    //   if (message != null) {
    //     print(message.notification?.title);
    //   }
    // });

    // //TODO : send this with order
    // _fmToken = await FirebaseMessaging.instance.getToken();

    // // While app on the foreground
    // FirebaseMessaging.onMessage.listen((message) async {
    //   await handleNotifications(message);
    // });

    // // App in the background and opened when tap
    // FirebaseMessaging.onMessageOpenedApp.listen((message) async {
    //   print("on message received");
    //   await handleNotifications(message);
    // });
  }

  Future<void> _onLoad() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<User>(context, listen: false).tryAutoLogin();
    await setupInteractedMessage();
    setState(() {
      _isLoading = false;
    });
  }

  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await _onLoad();
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print(message.notification?.title);
      }
    });

    //TODO : send this with order
    // _fmToken = await FirebaseMessaging.instance.getToken();

    // While app on the foreground
    FirebaseMessaging.onMessage.listen((message) async {
      await handleNotifications(message);
    });

    // App in the background and opened when tap
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      print("on message received");
      await handleNotifications(message);
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
