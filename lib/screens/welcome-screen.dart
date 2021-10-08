import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';
import '../config/constants.dart';
import './customer/customer_home_screen.dart';
import './auth/auth-screen.dart';

class WelcomeScreen extends StatelessWidget {
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
                SizedBox(
                  height: 40,
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    child: Text(
                      'Login as a User',
                      style: titleTextStyle1.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(AuthScreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      onPrimary: kTextColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 42, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    child: Text(
                      'Guest User',
                      style: titleTextStyle1.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    onPressed: () async {
                      await Provider.of<User>(context, listen: false).logout();
                      Navigator.of(context)
                          .pushNamed(CustomerHomePageScreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      onPrimary: kTextColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: 42.0, vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
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
