import 'package:flutter/material.dart';

import '../../config/constants.dart';
import './drawer_item.dart';

enum DrawerItems { HOME, CART, CATEGORIES, FOODITEM, ORDERS }

class CustomerAppDrawer extends StatefulWidget {
  @override
  _CustomerAppDrawerState createState() => _CustomerAppDrawerState();
}

class _CustomerAppDrawerState extends State<CustomerAppDrawer> {
  DrawerItems selectedDrawerItem = DrawerItems.HOME;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                'Hello Friend!',
                style: drawerHeadingStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              automaticallyImplyLeading: false,
            ),
            Divider(),
            DrawerItem(
              selectedDrawerItem: selectedDrawerItem,
              drawerItemName: DrawerItems.HOME,
              label: "Home",
              leadingIcon: Icons.home,
              ontapFunction: () {},
            ),
            Divider(),
            DrawerItem(
              selectedDrawerItem: selectedDrawerItem,
              drawerItemName: DrawerItems.CATEGORIES,
              label: "Categories",
              leadingIcon: Icons.category,
              ontapFunction: () {},
            ),
            Divider(),
            DrawerItem(
              selectedDrawerItem: selectedDrawerItem,
              drawerItemName: DrawerItems.CART,
              label: "Order",
              leadingIcon: Icons.food_bank,
              ontapFunction: () {},
            ),
          ],
        ),
      ),
    );
  }
}
