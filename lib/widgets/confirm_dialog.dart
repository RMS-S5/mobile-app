import 'package:flutter/material.dart';

import '../config/constants.dart';

Future<bool> confirmDialog(BuildContext context,
    {Function? onPressed, String? message}) async {
  bool _out = false;
  await showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        'Confirm ?',
        style: titleTextStyle1,
      ),
      // content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text('Confirm', style: titleTextStyle1),
          onPressed: () {
            _out = true;
            Navigator.of(ctx).pop();
          },
        ),
        TextButton(
          child: Text('Exit', style: titleTextStyle1),
          onPressed: () {
            _out = false;
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
  return _out;
}
