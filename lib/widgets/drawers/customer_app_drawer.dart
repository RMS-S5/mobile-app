import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rms_mobile_app/screens/profile-screen.dart';

import '../../screens/kitchen/pending_orders_screen.dart';
import '../../screens/customer/cart_screen.dart';
import '../../screens/customer/customer_home_screen.dart';
import '../../screens/customer/order_screen.dart';
import '../../screens/customer/table_verification_screen.dart';
import '../../screens/profile-screen.dart';

import '../../providers/user.dart';

import './drawer_header.dart';
import '../../config/constants.dart';
import './drawer_item.dart';

enum DrawerItems {
  HOME,
  CART,
  CATEGORIES,
  FOODITEM,
  ORDER,
  KITCHEN,
  TABLE,
  PROFILE,
  LOGOUT
}

class CustomerAppDrawer extends StatefulWidget {
  final DrawerItems drawerItemName;

  CustomerAppDrawer({required this.drawerItemName});

  @override
  _CustomerAppDrawerState createState() => _CustomerAppDrawerState();
}

class _CustomerAppDrawerState extends State<CustomerAppDrawer> {
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
    final isAuth = Provider.of<User>(context, listen: false).isAuth();
    return Drawer(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomDrawerHeader(),
              // Divider(),
              DrawerItem(
                selectedDrawerItem: selectedDrawerItem,
                drawerItemName: DrawerItems.HOME,
                label: "Home",
                leadingIcon: Icons.home,
                ontapFunction: () {
                  setSelectedScreen(DrawerItems.HOME);
                  Navigator.of(context)
                      .pushReplacementNamed(CustomerHomePageScreen.routeName);
                },
              ),
              Divider(),
              DrawerItem(
                selectedDrawerItem: selectedDrawerItem,
                drawerItemName: DrawerItems.CART,
                label: "Cart",
                leadingIcon: Icons.shopping_cart,
                ontapFunction: () {
                  setSelectedScreen(DrawerItems.CART);
                  Navigator.of(context).pushNamed(CustomerCartScreen.routeName);
                },
              ),
              Divider(),
              DrawerItem(
                selectedDrawerItem: selectedDrawerItem,
                drawerItemName: DrawerItems.ORDER,
                label: "Order",
                leadingIcon: Icons.food_bank,
                ontapFunction: () {
                  setSelectedScreen(DrawerItems.ORDER);
                  Navigator.of(context)
                      .pushReplacementNamed(CustomerOrderScreen.routeName);
                },
              ),
              Divider(),
              DrawerItem(
                selectedDrawerItem: selectedDrawerItem,
                drawerItemName: DrawerItems.TABLE,
                label: "Table Verification",
                leadingIcon: Icons.domain_verification,
                ontapFunction: () {
                  setSelectedScreen(DrawerItems.TABLE);
                  Navigator.of(context)
                      .pushReplacementNamed(TableVerificationScreen.routeName);
                },
              ),
              isAuth
                  ? Column(
                      children: [
                        Divider(),
                        DrawerItem(
                          selectedDrawerItem: selectedDrawerItem,
                          drawerItemName: DrawerItems.PROFILE,
                          label: "Profile",
                          leadingIcon: Icons.account_circle_outlined,
                          ontapFunction: () {
                            setSelectedScreen(DrawerItems.PROFILE);
                            Navigator.of(context)
                                .pushNamed(ProfileScreen.routeName);
                          },
                        ),
                        Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        DrawerItem(
                          selectedDrawerItem: selectedDrawerItem,
                          drawerItemName: DrawerItems.LOGOUT,
                          label: "Logout",
                          leadingIcon: Icons.exit_to_app,
                          ontapFunction: () {
                            setSelectedScreen(DrawerItems.LOGOUT);
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacementNamed('/');
                            Provider.of<User>(context, listen: false).logout();
                          },
                        ),
                        Divider(),
                      ],
                    )
                  : Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
