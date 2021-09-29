import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rms_mobile_app/widgets/simple_error_dialog.dart';

import '../../providers/user.dart';
import '../../config/constants.dart';
import './drawer_item.dart';
import './drawer_header.dart';

//Screens import
import '../../screens/kitchen/pending_orders_screen.dart';
import '../../screens/kitchen/preparing_orders_screen.dart';
import '../../screens/kitchen/prepared_orders_screen.dart';

import '../../screens/profile-screen.dart';

enum DrawerItems {
  HOME,
  PENDINGORDERS,
  PREPARINGORDERS,
  PREPAREDORDERS,
  CUSTOMER,
  LOGOUT,
  PROFILE
}

class KitchenStaffAppDrawer extends StatefulWidget {
  final DrawerItems drawerItemName;

  KitchenStaffAppDrawer({required this.drawerItemName});

  @override
  _KitchenStaffAppDrawerState createState() => _KitchenStaffAppDrawerState();
}

class _KitchenStaffAppDrawerState extends State<KitchenStaffAppDrawer> {
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
              drawerItemName: DrawerItems.PENDINGORDERS,
              label: "Pending Orders",
              leadingIcon: Icons.pending_actions,
              ontapFunction: () {
                setSelectedScreen(DrawerItems.PENDINGORDERS);
                Navigator.of(context).pushReplacementNamed(
                    KitchenStaffPendingOrdersScreen.routeName);
              },
            ),
            Divider(),
            DrawerItem(
              selectedDrawerItem: selectedDrawerItem,
              drawerItemName: DrawerItems.PREPARINGORDERS,
              label: "Preparing Orders",
              leadingIcon: Icons.access_time_outlined,
              ontapFunction: () {
                setSelectedScreen(DrawerItems.PREPARINGORDERS);
                Navigator.of(context).pushReplacementNamed(
                    KitchenStaffPreparingOrdersScreen.routeName);
              },
            ),
            Divider(),
            DrawerItem(
              selectedDrawerItem: selectedDrawerItem,
              drawerItemName: DrawerItems.PREPAREDORDERS,
              label: "Prepared Orders",
              leadingIcon: Icons.food_bank,
              ontapFunction: () {
                setSelectedScreen(DrawerItems.PREPAREDORDERS);
                Navigator.of(context).pushReplacementNamed(
                    KitchenStaffPreparedOrdersScreen.routeName);
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
              ontapFunction: () async {
                setSelectedScreen(DrawerItems.LOGOUT);
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
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
