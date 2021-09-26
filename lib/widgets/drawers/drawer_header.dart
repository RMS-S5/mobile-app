import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/auth/auth-screen.dart';
import '../../providers/user.dart';
import '../../config/constants.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<User>(context).userData;
    return (userData['userId'] != null)
        ? UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.white),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(avatarImagePath),
            ),
            accountName: Text('Welcome    ${userData['firstName']}'),
            accountEmail: Offstage(
              offstage: true,
              child: Text('test'),
            ),
          )
        : Container(
            child: DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Hello Friend!",
                    style: drawerHeadingStyle,
                  ),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kPrimaryColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(AuthScreen.routeName);
                    },
                    icon: Icon(Icons.login, size: 18),
                    label: Text(
                      "Login",
                      style: titleTextStyle1.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
