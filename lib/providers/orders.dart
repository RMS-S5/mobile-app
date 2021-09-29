import 'package:flutter/foundation.dart';
import 'package:rms_mobile_app/models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

import '../api/api.dart';

class Orders with ChangeNotifier {
  List<dynamic> _activeOrders = [];
  Map<String, dynamic> _tableOrder = {};
  List<dynamic> _waiterServedOrders = [];

  String _token;
  String? _userId;
  String _verificationCode = "";
  Map<String, dynamic> _tableData = {};
  List<dynamic> _branchTables = [];

  Orders(this._token, this._userId, this._activeOrders, this._tableOrder,
      this._waiterServedOrders) {}

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

  Map<String, dynamic> get tableOrder {
    return {..._tableOrder};
  }

  double get tableTotalAmount {
    return _tableOrder['totalAmount'] as double;
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

  // Updates
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
      };
      final reponse = await API.orderAPI.addOrder(data);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // Updates
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

  // Set verification code
  Future<void> setVerificationCode(String verificationCode) async {
    _verificationCode = verificationCode;
    try {
      await fetchAndSetTableData();
    } catch (error) {
      throw error;
    }
  }

  // Fetching data
  Future<void> fetchAndSetTableData() async {
    try {
      if (_verificationCode == null || _verificationCode == "") {
        final prefs = await SharedPreferences.getInstance();
        if (!prefs.containsKey('tableData')) {
          throw HttpException("Verification code not found!");
        }
        final extractedTableData = json
            .decode(prefs.getString('tableData') ?? "") as Map<String, dynamic>;
        _tableData = extractedTableData;
        _verificationCode = extractedTableData['verificationCode'] ?? "";
        return;
      }

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

  Future<void> fetchAndSetTableOrder() async {
    try {
      if (_tableData.isEmpty) {
        await fetchAndSetTableData();
      }

      final response = await API.orderAPI.getTableOrder(_verificationCode,
          query: {
            'branchId': _tableData['branchId'],
            'tableNumber': _tableData['tableNumber']
          },
          token: _token);
      _tableOrder = response?['data'] ?? {};
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

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
