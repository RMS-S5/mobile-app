import 'package:flutter/material.dart';
import '../../config/constants.dart';

class DrawerItem extends StatelessWidget {
  final selectedDrawerItem;
  final drawerItemName;
  final String label;
  final IconData leadingIcon;
  final Function ontapFunction;

  DrawerItem(
      {@required this.selectedDrawerItem,
      @required this.drawerItemName,
      required this.label,
      required this.leadingIcon,
      required this.ontapFunction,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(5.0),
      //   color: Colors.white,
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey,
      //       offset: Offset(0.0, 0.2), //(x,y)
      //       blurRadius: 6.0,
      //     ),
      //   ],
      // ),
      child: ListTile(
        leading: Icon(
          leadingIcon,
          color: (selectedDrawerItem == drawerItemName
              ? kDrawerSelectedIconColor
              : kDrawerUnselectedIconColor),
        ),
        title: Text(
          label,
          style: drawerItemStyleM(
            selectedDrawerItem: selectedDrawerItem,
            drawerItemName: drawerItemName,
          ),
        ),
        onTap: () => ontapFunction(),
      ),
    );
  }
}
