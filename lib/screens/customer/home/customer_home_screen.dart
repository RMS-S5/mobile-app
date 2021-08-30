import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rms_mobile_app/providers/food_items.dart';

import '../common_components/app_bar.dart';
import './components/search_box.dart';
import '../../../widgets/drawers/customer_app_drawer.dart';
import 'components/category_item.dart';
import './components/food_items_grid.dart';

import '../../../providers/categories.dart';
import '../../../providers/food_items.dart';
import 'components/food_item.dart';

class CustomerHomePageScreen extends StatefulWidget {
  static const routeName = '/customer/home';
  const CustomerHomePageScreen({Key? key}) : super(key: key);

  @override
  _CustomerHomePageScreenState createState() => _CustomerHomePageScreenState();
}

class _CustomerHomePageScreenState extends State<CustomerHomePageScreen> {
  var activeCategory = "0";
  final globalCustomerScaffoldKey = GlobalKey<ScaffoldState>();

  void searchBarOnChange(value) {
    print(value);
  }

  void handleCategorySelect(categoryId) {
    setState(() {
      activeCategory = categoryId;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Category Data
    final categoryData = Provider.of<Categories>(
      context,
      listen: false,
    ).categories;

    final foodItemsData = Provider.of<FoodItems>(
      context,
      listen: false,
    ).foodItems;

    return Scaffold(
      key: globalCustomerScaffoldKey,
      appBar: CustomerAppBar(context),
      drawer: CustomerAppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SearchBox(onChanged: searchBarOnChange),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                categoryId: category['categoryId'],
                                categoryName: category['categoryName'],
                                onPress: handleCategorySelect,
                                activeCategoryId: activeCategory),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          FoodItemsGrid(foodItems: foodItemsData),
        ],
      ),
    );
  }
}
