import 'dart:developer';

import 'package:flutter/material.dart';
import '../config/constants.dart';

class Badge extends StatelessWidget {
  const Badge({
    required Key key,
    required this.child,
    required this.value,
    this.color = null,
  }) : super(key: key);

  final Widget child;
  final String value;
  final color;

  @override
  Widget build(BuildContext context) {
    var countEmpty = false;
    if (value == '0') {
      countEmpty = true;
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color != null
                  ? color
                  : (countEmpty)
                      ? kSecondaryColor
                      : kPrimaryColor,
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}
