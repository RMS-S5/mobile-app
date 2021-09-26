import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './prepared_order_view_screen.dart';

import '../../providers/orders.dart';
import '../../widgets/staff_app_bar.dart';
import '../../widgets/order_list.dart';
import '../../widgets/drawers/waiter_app_drawer.dart';

import '../../config/constants.dart';
import '../../widgets/no_data_found.dart';
import '../../widgets/simple_error_dialog.dart';
import '../../models/http_exception.dart';

class WaiterPreparedOrdersScreen extends StatelessWidget {
  static final routeName = "waiter/prepared-orders";
  final preparedOrderViewScreenRouteName =
      WaiterPreparedOrderViewScreen.routeName;

  WaiterPreparedOrdersScreen({Key? key}) : super(key: key);

  Future<void> _refreshItems(BuildContext context) async {
    try {
      await Provider.of<Orders>(context, listen: false)
          .fetchAndSetActiveOrders();
    } on HttpException catch (error) {
      showErrorDialog(error.toString(), context);
    } catch (error) {
      final errorMessage = 'Something went wrong.';
      showErrorDialog(errorMessage, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: staffAppBar(context, title: 'Prepared Orders'),
      drawer: WaiterAppDrawer(drawerItemName: DrawerItems.PREPAREDORDERS),
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
                        final orderData = orderProvider
                            .getOrdersByStatus(kOrderStatusTypes['Prepared']);
                        return (orderData == null || orderData.isEmpty)
                            ? NoDataFound("No Orders Found")
                            : orderList(
                                orderData, preparedOrderViewScreenRouteName);
                      },
                    )),
      ),
    );
  }
}
