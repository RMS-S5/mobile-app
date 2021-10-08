import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import './simple_error_dialog.dart';

import '../../../providers/notifications.dart';
import '../../../config/constants.dart';

class NotificationItem extends StatelessWidget {
  final _notificationId;
  final _title;
  final _description;

  NotificationItem(this._notificationId, this._title, this._description);

  removeNotification(String _notificationId, BuildContext context) {
    Provider.of<Notifications>(context, listen: false)
        .removeNotification(_notificationId);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(_notificationId),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        removeNotification(_notificationId, context);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: ListTile(
          leading: Icon(Icons.notifications),
          title: Text(
            _title,
            style: titleTextStyle1,
          ),
          subtitle: Padding(
            padding: EdgeInsets.all(2),
            child: Text(
              _description,
              style: inputTextStyle.copyWith(fontSize: 14),
            ),
          ),
          trailing: FittedBox(
              child: IconButton(
            icon: Icon(Icons.delete),
            color: kRejectButtonColor,
            onPressed: () {
              removeNotification(_notificationId, context);
            },
          )),
        ),
      ),
    );
  }
}
