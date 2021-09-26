import 'package:flutter/material.dart';
import 'category_item.dart';

class CategoryList extends StatelessWidget {
  final categoryData;
  final Function handleCategorySelect;
  final activeCategory;

  const CategoryList(
      {required this.categoryData,
      required this.handleCategorySelect,
      required this.activeCategory,
      required Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CategoryItem(
              key: UniqueKey(),
              categoryId: '0',
              categoryName: 'All',
              onPress: handleCategorySelect,
              activeCategoryId: activeCategory),
          ...categoryData
              .map(
                (category) => CategoryItem(
                    key: UniqueKey(),
                    categoryId: category?['categoryId'],
                    categoryName: category?['categoryName'],
                    onPress: handleCategorySelect,
                    activeCategoryId: activeCategory),
              )
              .toList(),
        ],
      ),
    );
  }
}
