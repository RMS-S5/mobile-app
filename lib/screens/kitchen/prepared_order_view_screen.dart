import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/orders.dart';

import '../../widgets/staff_app_bar.dart';
import '../../widgets/order_food_item.dart';
import '../../widgets/order_view_items_list.dart';

import '../../widgets/simple_error_dialog.dart';
import '../../widgets/no_data_found.dart';
import '../../../config/constants.dart';
import '../../models/http_exception.dart';

class KitchenStaffPreparedOrderViewScreen extends StatelessWidget {
  static const routeName = '/kitchen-staff/prepared-order-view';

  @override
  Widget build(BuildContext context) {
    final orderId = ModalRoute.of(context)?.settings.arguments as String;
    final orderData = Provider.of<Orders>(context).getOrdersByOrderId(orderId);

    return Scaffold(
      appBar: staffAppBar(context),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: (orderData.isEmpty)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'No any food items',
                          style: titleTextStyle1,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Order Status',
                          style: titleTextStyle1,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Chip(
                          label: Text('${orderData["orderStatus"]}',
                              style: inputTextStyle),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
            ),
          ),
          SizedBox(height: 10),
          (!orderData.isEmpty)
              ? orderViewItemList(orderData)
              : NoDataFound("No Order Items Found")
        ],
      ),
    );
  }
}
