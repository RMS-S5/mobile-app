import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../api/sub/cart-api.dart';
import '../../models/http_exception.dart';
import '../../providers/food_items.dart';
import './components/home/category_list.dart';

import 'components/app_bar.dart';
import 'components/home/search_box.dart';
import '../../widgets/drawers/customer_app_drawer.dart';
import 'components/home/category_item.dart';
import 'components/home/food_items_grid.dart';
import '../../widgets/simple_error_dialog.dart';
import '../../providers/categories.dart';
import '../../providers/food_items.dart';
import '../../../providers/cart.dart';
import '../../../providers/notifications.dart';
import 'components/home/food_item.dart';

class CustomerHomePageScreen extends StatefulWidget {
  static const routeName = '/customer/home';
  const CustomerHomePageScreen({Key? key}) : super(key: key);

  @override
  _CustomerHomePageScreenState createState() => _CustomerHomePageScreenState();
}

class _CustomerHomePageScreenState extends State<CustomerHomePageScreen> {
  var activeCategory = "0";
  var searchKey = "";
  final globalCustomerScaffoldKey = GlobalKey<ScaffoldState>();
  bool firstTime = true;
  TextEditingController searchController = TextEditingController();

  Future<void> _refreshItems(BuildContext context, refresh) async {
    print(firstTime);
    if (!firstTime && !refresh) {
      return;
    }
    print("refresh item works");
    try {
      await Provider.of<FoodItems>(context, listen: false)
          .fetchAndSetFoodItems();
      await Provider.of<Categories>(context, listen: false)
          .fetAndSetCategories();
      final cartId = await Provider.of<Cart>(context, listen: false).cartId;
      if (cartId == null || cartId == "") {
        await Provider.of<Cart>(context, listen: false).checkAndSetCart();
      }
      await Provider.of<Cart>(context, listen: false)
          .fetchAndSetCartItemsData();
      firstTime = false;
    } on HttpException catch (error) {
      showErrorDialog(error.toString(), context);
    } catch (error) {
      final errorMessage = 'Something went wrong.';
      showErrorDialog(errorMessage, context);
    }
  }

  void searchBarOnChange(value) {
    setState(() {
      searchKey = value;
    });
  }

  void handleCategorySelect(categoryId) {
    setState(() {
      activeCategory = categoryId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: globalCustomerScaffoldKey,
      appBar: customerAppBar(context),
      drawer: CustomerAppDrawer(drawerItemName: DrawerItems.HOME),
      body: Column(
        children: [
          SearchBox(
            onChanged: searchBarOnChange,
          ),
          Expanded(
            child: FutureBuilder(
                future: _refreshItems(context, false),
                builder: (ctx, snapshot) => snapshot.connectionState ==
                        ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: () => _refreshItems(context, true),
                        child: Container(
                          height: size.height,
                          child: Column(
                            children: [
                              Consumer<Categories>(
                                builder: (ctx, categoryData, _) => CategoryList(
                                    categoryData: categoryData.categories,
                                    handleCategorySelect: handleCategorySelect,
                                    activeCategory: activeCategory,
                                    key: UniqueKey()),
                              ),
                              Consumer<FoodItems>(
                                builder: (ctx, foodItemData, _) => Expanded(
                                  child: FoodItemsGrid(
                                      foodItems: foodItemData
                                          .getFoodItemByCategoryAndSearch(
                                              activeCategory, searchKey)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
          ),
        ],
      ),
    );
  }
}
