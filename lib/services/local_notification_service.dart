import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uuid/uuid.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    _notificationsPlugin.initialize(initializationSettings);
  }

  static void display(RemoteMessage message) async {
    try {
      final id = Uuid();
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "npn_notification_channel_id",
        "npn notification channel",
        'npn channel',
        importance: Importance.max,
        priority: Priority.high,
      ));

      await _notificationsPlugin.show(id.hashCode, message.notification!.title,
          message.notification!.body, notificationDetails);
    } catch (error) {
      print(error);
    }
  }
}
