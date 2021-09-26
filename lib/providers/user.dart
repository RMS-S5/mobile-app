import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:async';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api.dart';

class User with ChangeNotifier {
  Map _userData = {};

  String? _token;
  DateTime? _expiryDate;
  String? _refreshToken;

  // Getters
  String? get token {
    if (isAuth() == true) {
      return _token;
    }
    return null;
  }

  Map get userData {
    return {..._userData};
  }

  String? get accountType {
    if (!isAuth()) {
      return null;
    }
    return _userData['accountType'];
  }

  // Functions

  bool isAuth() {
    print(_expiryDate);
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return true;
    } else if (_expiryDate == null && _token != null) {
      bool isExpired = Jwt.isExpired(_token ?? "");
      if (!isExpired) {
        return true;
      }
    }
    return false;
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await API.userAPI.login(email, password);
      _userData = response['data'];
      _token = response['token']['access'];
      _refreshToken = response['token']['refresh'];
      _expiryDate = Jwt.getExpiryDate(_token ?? "");

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();

      final localData = json.encode({
        'userId': _userData['userId'],
        'firstName': _userData['firstName'],
        'lastName': _userData['lastName'],
        'email': _userData['email'],
        'accountType': _userData['accountType'],
        'mobileNumber': _userData['mobileNumber'],
        'branchId': _userData['branchId'],
        'nic': _userData['nic'],
      });

      final tokenData = json.encode({
        'access': _token,
        "refresh": _refreshToken,
      });
      await prefs.setString('userData', localData);
      await prefs.setString('tokenData', tokenData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> customerRegister(String email, String password, String firstName,
      String lastName, String mobileNumber) async {
    try {
      final customerData = {
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "mobileNumber": mobileNumber
      };
      final response = await API.userAPI.customerRegister(customerData);
    } catch (error) {
      throw error;
    }
  }

// TODO: Update user
  Future<void> updateUser(Map<String, dynamic> updatedUserData) async {
    print(updatedUserData);
    try {
      final customerData = {
        "firstName": updatedUserData['firstName'],
        "lastName": updatedUserData['lastName'],
        "mobileNumber": updatedUserData['mobileNumber']
      };
      // final response = await API.userAPI.customerRegister(customerData);
    } catch (error) {
      throw error;
    }
  }

  // TODO: Change user password
  Future<void> forgotPassword(String email) async {
    try {
      // final response = await API.userAPI.forgotPassword(email);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData') || !prefs.containsKey('tokenData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData') ?? "") as Map<String, Object>;
    _userData = extractedUserData;

    final extractedTokenData =
        json.decode(prefs.getString('tokenData') ?? "") as Map<String, dynamic>;

    _token = extractedTokenData['access'];
    _refreshToken = extractedTokenData['refresh'];
    _expiryDate = Jwt.getExpiryDate(_token ?? "");
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userData = {};
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    prefs.remove('tokenData');
    prefs.remove('cartId');
  }

  // Auto logout
  // Future<void> autoLogout() async {
  //   if (isAuth()) return;
  //   _token = null;
  //   _userData = {};
  //   notifyListeners();
  //   final prefs = await SharedPreferences.getInstance();
  // prefs.clear();
  // }
}
