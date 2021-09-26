import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/notifications.dart';

import '../../config/constants.dart';
import 'badge.dart';

AppBar staffAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: kTextColor),
    elevation: 0,
    title: RichText(
      text: TextSpan(
        style: heading1Style.copyWith(fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: "NPN",
            style: TextStyle(color: kSecondaryColor),
          ),
          TextSpan(
            text: "Food",
            style: TextStyle(color: kPrimaryColor),
          ),
        ],
      ),
    ),
    actions: <Widget>[
      Consumer<Notifications>(
        builder: (_, notificationData, ch) => Badge(
          key: UniqueKey(),
          child: ch,
          value: notificationData.notificationCount.toString(),
        ),
        child: IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
      ),
    ],
  );
}
