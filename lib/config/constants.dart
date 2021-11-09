import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Brakpoints

// Global constraints
final String fontFamily = 'Open Sans';
final String? fileAPI = "${dotenv.env['BACKEND_URL']}/file/";

// colour constants
final Color kPrimaryColor = Color(0xFFFFC61F);
// final Color kPrimaryColor = Color(0xFFFFC800);
final Color kSecondaryColor = Color(0xFFB5BFD0);
const Color kTextColor = Color(0xFF50505D);
const Color kTextLightColor = Color(0xFF6A727D);

final Color kSuccessButtonColor = Color(0xFF51E85C);
final Color kRejectButtonColor = Color(0xFFe76f51);
final Color kColor1 = Color(0xf4a261);
final Color kDrawerBackgroudColor = Color(0xff111216);
final Color kDrawerUnselectedIconColor = kTextColor;
final Color kDrawerSelectedIconColor = Color(0xffDCA721);

//Text Styles

final TextStyle heading1Style =
    TextStyle(color: kTextColor, fontSize: 20, fontFamily: fontFamily);

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
    TextStyle(color: kTextColor, fontSize: 16, fontFamily: fontFamily);

final TextStyle inputTextStyle1 =
    TextStyle(color: Colors.white, fontSize: 16, fontFamily: fontFamily);

final TextStyle textButtonStyle1 =
    TextStyle(fontFamily: fontFamily, fontSize: 17);

final TextStyle titleTextStyle1 =
    TextStyle(color: kTextColor, fontSize: 17, fontFamily: fontFamily);

final TextStyle largePriceStyle1 =
    TextStyle(color: kTextColor, fontSize: 18, fontFamily: fontFamily);

final TextStyle descriptionStyle1 =
    TextStyle(color: kTextLightColor, fontSize: 15, fontFamily: fontFamily);

// Image URLS
final pendingOrderImageUrl = "assets/images/food-item-fade.jpg";

final avatarImagePath = "assets/images/avatar.png";
final authScreenBackgroundImagePath = "assets/images/auth-bg1.svg";
final welcomeBackGroudImagePath = "assets/images/welcome-3.png";
final foodItemFadeImageUrl = "assets/images/food-item-fade.jpg";
final imageNotFoundImageUrl =
    "https://bitsofco.de/content/images/2018/12/Screenshot-2018-12-16-at-21.06.29.png";

String getAWSImages(imageUrl) {
  final String? fileAPI = "https://rms-backend-cs3202.herokuapp.com/file/";
  return "${fileAPI}${imageUrl}";
}

// OrderTypes
const kOrderStatusTypes = {
  "Placed": "Placed",
  "Preparing": "Preparing",
  "Prepared": "Prepared",
  "Waiter Assigned": "Waiter Assigned",
  "Rejected": "Rejected",
  "Served": "Served",
  "Closed": "Closed"
};
