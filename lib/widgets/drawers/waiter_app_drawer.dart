import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../simple_error_dialog.dart';
import '../../providers/user.dart';
import '../../providers/notifications.dart';
import '../../config/constants.dart';
import './drawer_item.dart';
import './drawer_header.dart';

//Screens import
import '../../screens/waiter/prepared_orders_screen.dart';
import '../../screens/waiter/serving_orders_screen.dart';
import '../../screens/waiter/served_orders_screen.dart';
import '../../screens/waiter/verify_table_screen.dart';

import '../../screens/welcome-screen.dart';
import '../../screens/profile-screen.dart';

enum DrawerItems {
  HOME,
  PREPAREDORDERS,
  SERVINGORDERS,
  SERVEDORDERS,
  LOGOUT,
  PROFILE,
  VERIFYTABLE
}

class WaiterAppDrawer extends StatefulWidget {
  final DrawerItems drawerItemName;

  WaiterAppDrawer({required this.drawerItemName});

  @override
  _WaiterAppDrawerState createState() => _WaiterAppDrawerState();
}

class _WaiterAppDrawerState extends State<WaiterAppDrawer> {
  var selectedDrawerItem;

  void initState() {
    super.initState();
    selectedDrawerItem = widget.drawerItemName;
  }

  setSelectedScreen(DrawerItems drawerItem) {
    setState(() {
      selectedDrawerItem = drawerItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CustomDrawerHeader(),
            DrawerItem(
              selectedDrawerItem: selectedDrawerItem,
              drawerItemName: DrawerItems.PREPAREDORDERS,
              label: "Prepared Orders",
              leadingIcon: Icons.pending_actions,
              ontapFunction: () {
                setSelectedScreen(DrawerItems.PREPAREDORDERS);
                Navigator.of(context)
                    .pushReplacementNamed(WaiterPreparedOrdersScreen.routeName);
              },
            ),
            Divider(),
            DrawerItem(
              selectedDrawerItem: selectedDrawerItem,
              drawerItemName: DrawerItems.SERVINGORDERS,
              label: "Serving Orders",
              leadingIcon: Icons.dinner_dining,
              ontapFunction: () {
                setSelectedScreen(DrawerItems.SERVINGORDERS);
                Navigator.of(context)
                    .pushReplacementNamed(WaiterServingOrdersScreen.routeName);
              },
            ),
            Divider(),
            DrawerItem(
              selectedDrawerItem: selectedDrawerItem,
              drawerItemName: DrawerItems.SERVEDORDERS,
              label: "Served Orders",
              leadingIcon: Icons.dining_outlined,
              ontapFunction: () {
                setSelectedScreen(DrawerItems.SERVEDORDERS);
                Navigator.of(context)
                    .pushReplacementNamed(WaiterServedOrdersScreen.routeName);
              },
            ),
            Divider(),
            DrawerItem(
              selectedDrawerItem: selectedDrawerItem,
              drawerItemName: DrawerItems.VERIFYTABLE,
              label: "Verify Table",
              leadingIcon: Icons.verified_outlined,
              ontapFunction: () {
                setSelectedScreen(DrawerItems.VERIFYTABLE);
                Navigator.of(context)
                    .pushReplacementNamed(VerifyTableScreen.routeName);
              },
            ),
            Divider(),
            DrawerItem(
              selectedDrawerItem: selectedDrawerItem,
              drawerItemName: DrawerItems.PROFILE,
              label: "Profile",
              leadingIcon: Icons.account_circle_outlined,
              ontapFunction: () {
                setSelectedScreen(DrawerItems.PROFILE);
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              },
            ),
            Divider(),
            SizedBox(
              height: 20,
            ),
            Divider(),
            DrawerItem(
              selectedDrawerItem: selectedDrawerItem,
              drawerItemName: DrawerItems.LOGOUT,
              label: "Logout",
              leadingIcon: Icons.exit_to_app,
              ontapFunction: () {
                setSelectedScreen(DrawerItems.LOGOUT);
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushReplacementNamed(WelcomeScreen.routeName);
                Provider.of<Notifications>(context, listen: false)
                    .clearNotifications();
                Provider.of<User>(context, listen: false).logout();
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
