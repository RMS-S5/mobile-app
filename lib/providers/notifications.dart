import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:uuid/uuid.dart';

class Notifications with ChangeNotifier {
  List _notifications = [];
  String _token;

  Notifications(this._token, this._notifications) {}

  // Get all notifications
  List get notifications {
    return [..._notifications];
  }

  // Return notification count
  int get notificationCount {
    return _notifications.length;
  }

  // Add notification from Firebase Cloud message
  void addNotifications(RemoteMessage message) {
    final uuid = Uuid();
    final msg = {
      'id': uuid.v4(),
      'title': message.notification?.title,
      'description': message.notification?.body
    };
    _notifications.add(msg);
    notifyListeners();
  }

  // Remove gven notification
  void removeNotification(messageId) {
    _notifications.removeWhere((item) => item['id'] == messageId);
    notifyListeners();
  }

  // Clear all notifications
  void clearNotifications() {
    _notifications = [];
    notifyListeners();
  }
}
