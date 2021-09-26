import 'package:flutter/material.dart';
import 'variant_list_item.dart';

class VariantList extends StatelessWidget {
  final loadedFoodItem;
  const VariantList({required this.loadedFoodItem, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: loadedFoodItem['foodVariants']
          .map<Widget>((variant) =>
              VariantListItem(variant: variant, loadedFoodItem: loadedFoodItem))
          .toList(),
    );
  }
}
