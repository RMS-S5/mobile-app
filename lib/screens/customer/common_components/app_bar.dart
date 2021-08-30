import 'package:flutter/material.dart';
import 'package:rms_mobile_app/config/constants.dart';

AppBar CustomerAppBar(BuildContext context) {
  return AppBar(
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
      IconButton(
        icon: Icon(Icons.notifications),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(Icons.shopping_cart),
        onPressed: () {},
      )
    ],
  );
}
