import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';

import '../providers/notifications.dart';

import '../../config/constants.dart';
import 'badge.dart';

AppBar commonAppBar(BuildContext context, {String? title}) {
  return AppBar(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: kTextColor),
    elevation: 0,
    title: Row(
      children: [
        RichText(
          text: TextSpan(
            style: heading1Style.copyWith(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: "NPN",
                style: TextStyle(color: kSecondaryColor),
              ),
              TextSpan(
                text: "Food",
                style: TextStyle(color: kPrimaryColor),
              ),
            ],
          ),
        ),
        if (title != null)
          SizedBox(
            width: 25,
          ),
        if (title != null)
          Expanded(
            child: AutoSizeText(
              title,
              style: titleTextStyle1.copyWith(color: kSecondaryColor),
              maxFontSize: 18,
              minFontSize: 12,
              maxLines: 1,
            ),
          ),
      ],
    ),
  );
}
