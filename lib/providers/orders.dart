import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

import '../api/api.dart';
import '../models/validate_exception.dart';
import '../models/http_exception.dart';

class Orders with ChangeNotifier {
  List<dynamic> _activeOrders = [];
  List<dynamic> _tableOrders = [];
  List<dynamic> _waiterServedOrders = [];

  String _token;
  String? _userId;
  String? _fcmToken;
  String _verificationCode = "";
  Map<String, dynamic> _tableData = {};
  List<dynamic> _branchTables = [];

  Orders(this._token, this._userId, this._activeOrders, this._tableOrders,
      this._waiterServedOrders, this._fcmToken) {}

  //Getters
  Map<String, dynamic> get tableData {
    return {..._tableData};
  }

  List<Map<String, dynamic>> get activeOrders {
    return [..._activeOrders];
  }

  String get verificationCode {
    return _verificationCode;
  }

  List<Map<String, dynamic>> get waiterServedOrders {
    return [..._waiterServedOrders];
  }

  List<dynamic> get tableOrders {
    return [..._tableOrders];
  }

  double get tableTotalAmount {
    var total = 0.0;
    _tableOrders.forEach((order) {
      if (order['orderStatus'] != "Rejected" &&
          order['orderStatus'] != "Paid" &&
          order['orderStatus'] != "Closed")
        total += double.parse(order["totalAmount"]);
    });
    return total;
  }

  int get activeOrderCount {
    return _activeOrders.length;
  }

  List get tableNumebrs {
    return _branchTables.map((table) => table['tableNumber']).toList();
  }

  String getVerificationCodeByTableNumber(int tableNumber) {
    final table = _branchTables
        .firstWhere((table) => table['tableNumber'] == tableNumber);
    return table['verificationCode'];
  }

  // Get orders accordint to order status
  List getOrdersByStatus(orderStatus) {
    return _activeOrders
        .where((order) => order["orderStatus"] == orderStatus)
        .toList();
  }

  // Get order by status but only relevant waiter's orders
  List getOrdersByStatusWaiter(orderStatus) {
    return _activeOrders
        .where((order) =>
            order["orderStatus"] == orderStatus && order['waiterId'] == _userId)
        .toList();
  }

  // Get Order by Order Id
  Map getOrdersByOrderId(orderId) {
    return _activeOrders.firstWhere((order) => order["orderId"] == orderId);
  }

  // Get Table Order by Order Id
  Map getTableOrdersByOrderId(orderId) {
    return _tableOrders.firstWhere((order) => order["orderId"] == orderId);
  }

  String? get fcmToken {
    return _fcmToken;
  }

  // Set fcm token
  void setFCMToken(String? token) {
    _fcmToken = token;
    notifyListeners();
  }

  // Add order
  Future<void> addOrder(dynamic orderData) async {
    try {
      if (_tableData.isEmpty) {
        await fetchAndSetTableData();
      }
      final data = {
        'totalAmount': orderData['totalAmount'],
        'cartItems': json.encode(orderData['cartItems']),
        'tableNumber': _tableData['tableNumber'],
        'branchId': _tableData['branchId'],
        'fcmToken': _fcmToken
      };
      final response = await API.orderAPI.addOrder(data, token: _token);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // Update order status
  Future<void> updateOrderStatus(orderId, status) async {
    try {
      if (_token == null || _token == "") {
        throw HttpException('Token error!');
      }
      final response = await API.orderAPI
          .updateOrder(orderId, {"orderStatus": status}, token: _token);
      await fetchAndSetActiveOrders();
    } catch (error) {
      throw error;
    }
  }

  // By customer to pay multiple orders
  Future<void> payOrders() async {
    try {
      var orderIds = [];

      _tableOrders.forEach((order) {
        if (order['orderStatus'] != 'Rejected' &&
            order['orderStatus'] != 'Paid' &&
            order['orderStatus'] != 'Closed') {
          orderIds.add(order['orderId']);
        }
      });
      final response = await API.orderAPI.updateOrdersStatus(
          {"orderStatus": "Paid", "orderIds": json.encode(orderIds)});
      await fetchAndSetTableOrder();
    } catch (error) {
      throw error;
    }
  }

  // Set verification code
  Future<void> setVerificationCode(String verificationCode) async {
    _verificationCode = verificationCode;
    try {
      await fetchAndSetNewTableData();
    } catch (error) {
      throw error;
    }
  }

  // Fetch and set new Table data using verfication code
  Future<void> fetchAndSetNewTableData() async {
    try {
      final response =
          await API.branchAPI.getTableDataByVerificationCode(_verificationCode);
      _tableData = response['data'];
      notifyListeners();
      final tableData = json.encode({
        'tableNumber': _tableData['tableNumber'],
        'branchId': _tableData['branchId'],
        'branchName': _tableData['branchName'],
        'verficationCode': _tableData['verificationCode']
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('tableData', tableData);
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  // Fetching table data using local saved data
  Future<void> fetchAndSetTableData() async {
    try {
      if (!_tableData.isEmpty) {
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('tableData')) {
        throw HttpException("Verification code not found!");
      }
      final extractedTableData = json.decode(prefs.getString('tableData') ?? "")
          as Map<String, dynamic>;
      _tableData = extractedTableData;
      _verificationCode = extractedTableData['verificationCode'] ?? "";
      return;

      await fetchAndSetNewTableData();
    } catch (error) {
      throw error;
    }
  }

  // Fetch and set active orders -> waiter , kitchen staff
  Future<void> fetchAndSetActiveOrders() async {
    try {
      if (_token == null || _token == "") {
        return;
        // throw HttpException('Token error');
      }
      final response = await API.orderAPI.getActiveOrders(
        token: _token,
      );
      _activeOrders = response?['data'] ?? {};
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // Fetch and set table orders -> Customer , Guest User
  Future<void> fetchAndSetTableOrder() async {
    try {
      if (_tableData.isEmpty) {
        await fetchAndSetTableData();
      }

      final response = await API.orderAPI.getTableOrders(
        query: {
          'branchId': _tableData['branchId'],
          'tableNumber': _tableData['tableNumber']
        },
      );
      _tableOrders = response?['data'] ?? [];
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // Fetch and set branch tables -> Waiter
  Future<void> fetchAndSetBranchTables() async {
    try {
      if (_token == null || _token == "") {
        throw HttpException('Token error');
      }
      final response = await API.branchAPI.getBranchTables(
        token: _token,
      );
      _branchTables = response?['data'] ?? [];
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // Clear Data
  Future<void> clearTableData() async {
    _tableData = {};
    _verificationCode = "";
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('tableData')) {
      await prefs.remove('tableData');
    }

    notifyListeners();
  }
}
