import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './customer_home_screen.dart';
import '../../widgets/drawers/customer_app_drawer.dart';
import 'components/app_bar.dart';
import '../../providers/cart.dart';
import 'components/order_item.dart';
import '../../providers/orders.dart';
import '../../config/constants.dart';
import '../../widgets/simple_error_dialog.dart';
import '../../widgets/notification_wrapper.dart';

class CustomerOrderScreen extends StatefulWidget {
  static const routeName = '/customer/my-order';

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Orders>(context).fetchAndSetTableOrder().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).onError((error, stackTrace) {
        setState(() {
          _isLoading = false;
        });
        showErrorDialog(error.toString(), context,
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(CustomerHomePageScreen.routeName));
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context).tableOrder;
    return Scaffold(
        appBar: customerAppBar(context),
        drawer: CustomerAppDrawer(
          drawerItemName: DrawerItems.ORDER,
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  await Provider.of<Orders>(context, listen: false)
                      .fetchAndSetTableOrder();
                },
                child: Stack(
                  children: [
                    ListView(),
                    (orderData.isEmpty)
                        ? Column(
                            children: <Widget>[
                              Card(
                                margin: EdgeInsets.all(15),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'No order Found',
                                        style: titleTextStyle1,
                                      ),
                                      Spacer(),
                                      // Chip(
                                      //   label: Text('${orderData["orderStatus"]}',
                                      //       style: inputTextStyle),
                                      //   backgroundColor: Theme.of(context).primaryColor,
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: <Widget>[
                              Card(
                                margin: EdgeInsets.all(15),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Order Status',
                                        style: titleTextStyle1,
                                      ),
                                      Spacer(),
                                      Chip(
                                        label: Text(
                                            '${orderData["orderStatus"]}',
                                            style: inputTextStyle),
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: orderData["cartItems"]?.length,
                                  itemBuilder: (ctx, i) => OrderItem(
                                    cartItemId: orderData["cartItems"]?[i]
                                        ["cartItemId"],
                                    foodItemId: orderData["cartItems"]?[i]
                                        ["foodItemId"],
                                    imageUrl: orderData["cartItems"]?[i]
                                        ["imageUrl"],
                                    name: orderData["cartItems"]?[i]["name"],
                                    price: orderData["cartItems"][i]["price"],
                                    quantity: orderData["cartItems"]?[i]
                                        ["quantity"],
                                    variantName: orderData["cartItems"]?[i]
                                        ['variant_name'],
                                  ),
                                ),
                              )
                            ],
                          ),
                  ],
                )));
  }
}
