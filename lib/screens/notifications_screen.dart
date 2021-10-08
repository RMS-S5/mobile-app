import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/notifications.dart';
import '../../providers/user.dart';

import '../widgets/notification_item.dart';

import '../../config/constants.dart';
import '../../models/http_exception.dart';
import '../../widgets/simple_error_dialog.dart';
import '../../widgets/common_app_bar.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notifications';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var _isInit = true;
  var _isLoading = false;

  clearAll() {
    Provider.of<Notifications>(context, listen: false).clearNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final notification = Provider.of<Notifications>(context);
    print(notification.notifications);
    return Scaffold(
      appBar: commonAppBar(context),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Spacer(),
                      TextButton(
                        child: Text(
                          'Clear All',
                          style:
                              textButtonStyle1.copyWith(color: kPrimaryColor),
                        ),
                        onPressed: () {
                          clearAll();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: notification.notificationCount,
                    itemBuilder: (ctx, i) => NotificationItem(
                      notification.notifications[i]['id'],
                      notification.notifications[i]['title'],
                      notification.notifications[i]['description'],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
