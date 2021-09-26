import 'package:flutter/material.dart';

import '../config/constants.dart';

void showErrorDialog(String message, BuildContext context,
    {Function? onPressed}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        'An Error Occurred!',
        style: TextStyle(color: kRejectButtonColor),
      ),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text('Okay', style: TextStyle(color: kPrimaryColor)),
          onPressed: () {
            Navigator.of(ctx).pop();
            onPressed != null ? onPressed() : () {};
          },
        )
      ],
    ),
  );
}
