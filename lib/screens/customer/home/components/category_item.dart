import 'package:flutter/material.dart';
import '../../../../config/constants.dart';

class CategoryItem extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final Function onPress;
  final activeCategoryId;

  const CategoryItem({
    required Key key,
    required this.categoryId,
    required this.categoryName,
    required this.activeCategoryId,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(categoryId),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: <Widget>[
            Text(
              categoryName,
              style: (activeCategoryId == categoryId)
                  ? TextStyle(
                      color: kTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )
                  : TextStyle(fontSize: 14),
            ),
            if (activeCategoryId == categoryId)
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: 3,
                width: 22,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
