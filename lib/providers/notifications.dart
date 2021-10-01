import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Notifications with ChangeNotifier {
  List _notifications = [];
  String _token;

  Notifications(this._token, this._notifications) {
    // messaging = FirebaseMessaging.instance;
    // FirebaseMessaging.onMessage.listen((message) async {

    // })
  }

  List get notifications {
    return [..._notifications];
  }

  int get notificationCount {
    return _notifications.length;
  }

  void addNotifications(RemoteMessage message) {
    final msg = {
      'id': message.messageId,
      'title': message.notification?.title,
      'description': message.notification?.body
    };
    _notifications.add(msg);
    notifyListeners();
  }

  void removeNotification(messageId) {
    _notifications.removeWhere((item) => item['messageId'] == messageId);
    notifyListeners();
  }

  void clearNotifications() {
    _notifications = [];
    notifyListeners();
  }
}
