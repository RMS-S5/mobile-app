import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './order_screen.dart';

import '../../providers/orders.dart';
import '../../widgets/staff_app_bar.dart';
import '../../widgets/order_list.dart';
import '../../widgets/drawers/customer_app_drawer.dart';

import '../../config/constants.dart';
import '../../widgets/no_data_found.dart';
import '../../widgets/simple_error_dialog.dart';
import '../../models/http_exception.dart';

class CustomerTableOrders extends StatelessWidget {
  static final routeName = "customer/table-orders";
  final customerOrderViewScreen = CustomerOrderViewScreen.routeName;

  Future<void> _refreshItems(BuildContext context) async {
    try {
      await Provider.of<Orders>(context, listen: false).fetchAndSetTableOrder();
    } on HttpException catch (error) {
      showErrorDialog(error.toString(), context);
    } catch (error) {
      final errorMessage =
          "Something went wrong! Check your internet connection.";
      showErrorDialog(errorMessage, context);
    }
  }

  Future<void> _payAll(BuildContext context) async {
    final totalAmount =
        Provider.of<Orders>(context, listen: false).tableTotalAmount;
    if (totalAmount == 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No any unpaid orders!')));
      return;
    }
    Map paymentObject = {
      "sandbox": true, // true if using Sandbox Merchant ID
      "merchant_id": "1218108", // Replace your Merchant ID
      "merchant_secret": dotenv.env['MERCHANT_SECRET'], // See step 4e
      "notify_url": "http://sample.com/notify",
      "order_id": Uuid().v4(),
      "items": "NPNFoods food order",
      "amount": totalAmount.toString(),
      "currency": "LKR",
      "first_name": "NPN",
      "last_name": "Foods",
      "email": "npnFoods@gmail.com",
      "phone": "0771234567",
      "address": "",
      "city": "Colombo",
      "country": "Sri Lanka",
      "delivery_address": "",
      "delivery_city": "",
      "delivery_country": "Sri Lanka",
      // "custom_1": "",
      // "custom_2": ""
    };

    PayHere.startPayment(paymentObject, (paymentId) async {
      print("One Time Payment Success. Payment Id: $paymentId");
      await Provider.of<Orders>(context, listen: false).payOrders();
    }, (error) {
      print("One Time Payment Failed. Error: $error");
    }, () {
      print("One Time Payment Dismissed");
    });
  }

  CustomerTableOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: staffAppBar(context, title: 'Table Orders'),
      drawer: CustomerAppDrawer(drawerItemName: DrawerItems.ORDER),
      body: FutureBuilder(
        future: _refreshItems(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshItems(context),
                    child: Consumer<Orders>(
                      builder: (ctx, orderProvider, _) {
                        final orderData = orderProvider.tableOrders;
                        return (orderData == null || orderData.isEmpty)
                            ? NoDataFound("No Orders Found")
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
                                            'Total Amount',
                                            style: titleTextStyle1,
                                          ),
                                          Spacer(),
                                          Chip(
                                            label: Text(
                                                'Rs. ${orderProvider.tableTotalAmount.toStringAsFixed(2)}',
                                                style: inputTextStyle),
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                          ),
                                          TextButton(
                                            child: Text(
                                              'Pay All',
                                              style: textButtonStyle1.copyWith(
                                                  color: kPrimaryColor),
                                            ),
                                            onPressed: () {
                                              _payAll(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Expanded(
                                    child: orderList(
                                        orderData, customerOrderViewScreen),
                                  )
                                ],
                              );
                      },
                    )),
      ),
    );
  }
}
