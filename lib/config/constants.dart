import 'package:flutter/material.dart';

// Brakpoints

// Global constraints
final String fontFamily = 'Roboto';

// colour constants
final Color kPrimaryColor = Color(0xFFFFC61F);
final Color kSecondaryColor = Color(0xFFB5BFD0);
const Color kTextColor = Color(0xFF50505D);
const Color kTextLightColor = Color(0xFF6A727D);

final Color kSuccessButtonColor = Color(0x51E85C);
final Color kRejectButtonColor = Color(0xe76f51);
final Color kColor1 = Color(0xf4a261);
final Color kDrawerBackgroudColor = Color(0xff111216);
// final Color drawerBackgroudColor = Color(0xffb74093);
// final Color drawerUnselectedIconColor = Color(0xff6B5B2B);
final Color kDrawerUnselectedIconColor = kTextColor;
final Color kDrawerSelectedIconColor = Color(0xffDCA721);

// Text styles
final TextStyle heading1Style =
    TextStyle(color: Colors.white, fontSize: 20, fontFamily: fontFamily);

final TextStyle heading1Style2 = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
);

final TextStyle drawerHeadingStyle =
    TextStyle(color: kTextColor, fontSize: 18, fontFamily: fontFamily);

TextStyle drawerItemStyleM(
        {@required selectedDrawerItem, @required drawerItemName}) =>
    TextStyle(
        color: (selectedDrawerItem == drawerItemName
            ? kDrawerSelectedIconColor
            : kDrawerUnselectedIconColor),
        fontSize: 15,
        fontFamily: fontFamily);

final TextStyle inputTextStyle =
    TextStyle(color: Colors.white, fontSize: 16, fontFamily: fontFamily);

final TextStyle largePriceStyle1 = TextStyle(
    color: kDrawerBackgroudColor, fontSize: 25, fontFamily: fontFamily);

final TextStyle descriptionStyle1 = TextStyle(
    color: kDrawerBackgroudColor, fontSize: 16, fontFamily: fontFamily);
