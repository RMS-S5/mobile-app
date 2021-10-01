import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/constants.dart';

class SplashScreen extends StatelessWidget {
  static final routeName = "/welcome";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: size.height,
            child: Image(
              image: AssetImage(welcomeBackGroudImagePath),
              fit: BoxFit.cover,
            ),
            color: Colors.white,
          ),
          Container(
            width: size.width,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                    child: FittedBox(
                      child: RichText(
                        text: TextSpan(
                          style: heading1Style.copyWith(
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: "NPN",
                              style: TextStyle(color: kSecondaryColor)
                                  .copyWith(fontSize: 50),
                            ),
                            TextSpan(
                              text: "Food",
                              style: TextStyle(color: kPrimaryColor)
                                  .copyWith(fontSize: 50),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
