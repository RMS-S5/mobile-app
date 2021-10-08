import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import './simple_error_dialog.dart';

import '../providers/user.dart';
import '../providers/orders.dart';
import '../providers/notifications.dart';
import '../services/local_notification_service.dart';

import '../screens/splash-screen.dart';

class NotificationWrapper extends StatefulWidget {
  Widget child;
  NotificationWrapper(this.child, {Key? key}) : super(key: key);
  @override
  _NotificationWrapperState createState() => _NotificationWrapperState();
}

class _NotificationWrapperState extends State<NotificationWrapper> {
  String? _fmToken;
  bool _isLoading = false;

  // Handle incoming notifications
  Future<void> handleNotifications(RemoteMessage message) async {
    try {
      final accountType = Provider.of<User>(context, listen: false).accountType;
      final tableData = Provider.of<Orders>(context, listen: false).tableData;
      print(accountType);
      LocalNotificationService.display(message);

      Provider.of<Notifications>(context, listen: false)
          .addNotifications(message);

      if (message.data != null) {
        final type = message.data['type'];
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
      print(error);
      showErrorDialog("Notification Receiving Error!", context);
    }
  }

  void initState() {
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print(message.notification?.title);
      }
    });

    // While app on the foreground
    FirebaseMessaging.onMessage.listen((message) async {
      print("on message received in notification wrapper");
      await handleNotifications(message);
    });

    // App in the background and opened when tap
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      await handleNotifications(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? CircularProgressIndicator() : widget.child;
  }
}
