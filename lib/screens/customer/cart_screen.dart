import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart.dart';
import '../../providers/orders.dart';

import 'components/app_bar.dart';
import 'components/cart_item.dart';

import '../../config/constants.dart';
import '../../models/http_exception.dart';
import '../../widgets/simple_error_dialog.dart';

class CustomerCartScreen extends StatefulWidget {
  static const routeName = '/customer/cart';

  @override
  State<CustomerCartScreen> createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends State<CustomerCartScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Cart>(context, listen: false)
          .fetchAndSetCartItemsData()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      }).onError((error, stackTrace) {
        setState(() {
          _isLoading = false;
        });
        showErrorDialog(
            "Something went wrong! Check your internet connection.", context);
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _order(dynamic orderData) async {
    try {
      await Provider.of<Orders>(context, listen: false).addOrder(orderData);
      Provider.of<Cart>(context, listen: false).clear();
      final snackBar = SnackBar(
        content: const Text('Order added successfully'),
        duration: Duration(
          milliseconds: 2000,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on HttpException catch (error) {
      showErrorDialog(error.toString(), context);
    } catch (error) {
      showErrorDialog('Something went wrong.', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: customerAppBar(context),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.all(15),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total',
                          style: titleTextStyle1,
                        ),
                        Spacer(),
                        Chip(
                          label: Text(
                            'Rs.${cart.totalAmount.toStringAsFixed(2)}',
                            style: inputTextStyle,
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        TextButton(
                          child: Text(
                            'ORDER NOW',
                            style:
                                textButtonStyle1.copyWith(color: kPrimaryColor),
                          ),
                          onPressed: () async {
                            final cartItemsIds = cart.cartItemsIds;
                            if (cartItemsIds.isEmpty) {
                              showErrorDialog('Cart is empty!', context);
                            }
                            final orderD = {
                              'totalAmount': cart.totalAmount,
                              'cartItems': cartItemsIds
                            };
                            await _order(orderD);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (ctx, i) => CartItem(
                      cartItemId: cart.cartItems[i]["cartItemId"],
                      foodItemId: cart.cartItems[i]["foodItemId"],
                      imageUrl: cart.cartItems[i]["imageUrl"],
                      name: cart.cartItems[i]["name"],
                      price: cart.cartItems[i]["price"],
                      quantity: cart.cartItems[i]["quantity"],
                      variantName: cart.cartItems[i]['variantName'],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
