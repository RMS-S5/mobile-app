import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../simple_error_dialog.dart';
import '../../providers/user.dart';
import '../../config/constants.dart';
import './drawer_item.dart';
import './drawer_header.dart';

//Screens import
import '../../screens/waiter/prepared_orders_screen.dart';
import '../../screens/waiter/verify_table_screen.dart';

enum DrawerItems {
  HOME,
  PREPAREDORDERS,
  SERVINGORDERS,
  SERVEDORDERS,
  LOGOUT,
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
            // DrawerItem(
            //   selectedDrawerItem: selectedDrawerItem,
            //   drawerItemName: DrawerItems.PREPARINGORDERS,
            //   label: "Preparing Orders",
            //   leadingIcon: Icons.access_time_outlined,
            //   ontapFunction: () {
            //     setSelectedScreen(DrawerItems.PREPARINGORDERS);
            //     Navigator.of(context).pushReplacementNamed(
            //         KitchenStaffPreparingOrdersScreen.routeName);
            //   },
            // ),
            // Divider(),
            // DrawerItem(
            //   selectedDrawerItem: selectedDrawerItem,
            //   drawerItemName: DrawerItems.PREPAREDORDERS,
            //   label: "Prepared Orders",
            //   leadingIcon: Icons.food_bank,
            //   ontapFunction: () {
            //     setSelectedScreen(DrawerItems.PREPAREDORDERS);
            //     Navigator.of(context).pushReplacementNamed(
            //         KitchenStaffPreparedOrdersScreen.routeName);
            //   },
            // ),
            // Divider(),
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
            SizedBox(
              height: 20,
            ),
            Divider(),
            DrawerItem(
              selectedDrawerItem: selectedDrawerItem,
              drawerItemName: DrawerItems.LOGOUT,
              label: "Logout",
              leadingIcon: Icons.exit_to_app,
              ontapFunction: () async {
                setSelectedScreen(DrawerItems.LOGOUT);
                Navigator.of(context).pop();
                Provider.of<User>(context, listen: false).logout();
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
