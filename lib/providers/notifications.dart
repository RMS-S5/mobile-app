import 'package:flutter/foundation.dart';

class Notifications with ChangeNotifier {
  List _notifications = [];
  String _token;

  Notifications(this._token, this._notifications) {}

  List get notifications {
    return [..._notifications];
  }

  int get notificationCount {
    return _notifications.length;
  }
}
