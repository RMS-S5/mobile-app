import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/orders.dart';

import '../../widgets/staff_app_bar.dart';
import '../../widgets/order_food_item.dart';
import '../../widgets/order_view_items_list.dart';

import '../../widgets/simple_error_dialog.dart';
import '../../widgets/confirm_dialog.dart';
import '../../widgets/no_data_found.dart';
import '../../../config/constants.dart';
import '../../models/http_exception.dart';

class KitchenStaffPreparingOrderViewScreen extends StatelessWidget {
  static const routeName = '/kitchen-staff/preparing-order-view';

  preparedOrder(orderId, context) async {
    try {
      if (!await confirmDialog(context)) {
        return;
      }
      await Provider.of<Orders>(context, listen: false)
          .updateOrderStatus(orderId, kOrderStatusTypes['Prepared']);
      // Navigator.of(context).pop();
    } on HttpException catch (error) {
      showErrorDialog(error.toString(), context);
    } catch (error) {
      final errorMessage = 'Something went wrong.';
      showErrorDialog(errorMessage, context);
    }
  }

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
                        Spacer(),
                        TextButton(
                          child: Text(
                            'Prepared',
                            style:
                                textButtonStyle1.copyWith(color: kPrimaryColor),
                          ),
                          onPressed: () {
                            preparedOrder(orderId, context);
                          },
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
