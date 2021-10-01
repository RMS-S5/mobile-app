import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart.dart';
import '../../../providers/notifications.dart';

import '../../../widgets/badge.dart';
import '../cart_screen.dart';
import '../../../../config/constants.dart';
import '../../notifications_screen.dart';

AppBar customerAppBar(BuildContext context) {
  return AppBar(
    iconTheme: IconThemeData(color: kTextColor),
    backgroundColor: Colors.white,
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
          icon: Icon(
            Icons.notifications,
            color: kTextColor,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(NotificationScreen.routeName);
          },
        ),
      ),
      Consumer<Cart>(
        builder: (_, cart, ch) => Badge(
          key: UniqueKey(),
          child: ch,
          value: cart.itemCount.toString(),
        ),
        child: IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: kTextColor,
          ),
          onPressed: () {
            if (ModalRoute.of(context)?.settings.name !=
                CustomerCartScreen.routeName) {
              Navigator.of(context).pushNamed(CustomerCartScreen.routeName);
            }
          },
        ),
      ),
    ],
  );
}
