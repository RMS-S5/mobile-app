import 'package:flutter/material.dart';
import '../../config/constants.dart';

class NoDataFound extends StatelessWidget {
  String _message;
  NoDataFound(this._message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
          child: FittedBox(
            child: RichText(
              text: TextSpan(
                style: heading1Style.copyWith(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: _message,
                    style: TextStyle(color: kSecondaryColor)
                        .copyWith(fontSize: 40),
                  ),
                  // TextSpan(
                  //   text: "Food",
                  //   style: TextStyle(color: kPrimaryColor)
                  //       .copyWith(fontSize: 50),
                  // ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
          child: FittedBox(
              child: Icon(
            Icons.search_off,
            color: kSecondaryColor,
            size: 40,
          )),
        )
      ],
    );
  }
}
