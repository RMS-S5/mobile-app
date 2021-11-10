import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:async';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
  // Check if user is logged in or not
  bool isAuth() {
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

  Future<void> subscribeToChannel() async {
    switch (accountType) {
      case 'Kitchen Staff':
        print('Kitchen topic');
        await FirebaseMessaging.instance
            .subscribeToTopic('order-kitchen-staff');
        break;
      case 'Waiter':
        print('Waiter topic');
        await FirebaseMessaging.instance.subscribeToTopic('order-waiter');
        break;
      default:
        break;
    }
  }

  // User login -> Save user data to local, subscribe to cloud messaging
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
        'branchName': _userData['branchName'],
        'nic': _userData['nic'],
      });

      final tokenData = json.encode({
        'access': _token,
        "refresh": _refreshToken,
      });
      await prefs.setString('userData', localData);
      await prefs.setString('tokenData', tokenData);
      prefs.remove('cartId');

      // Subscribe users to cloud messaging
      await subscribeToChannel();
    } catch (error) {
      throw error;
    }
  }

  // Register customer
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

  // Update user details
  Future<void> updateUser(Map<String, dynamic> updatedUserData) async {
    try {
      final userData = {
        "firstName": updatedUserData['firstName'],
        "lastName": updatedUserData['lastName'],
        "mobileNumber": updatedUserData['mobileNumber']
      };
      final response = await API.userAPI.updateProfile(userData, token: _token);
      _userData['firstName'] =
          updatedUserData['firstName'] ?? _userData['firstName'];
      _userData['lastName'] =
          updatedUserData['lastName'] ?? _userData['lastName'];
      _userData['mobileNumber'] =
          updatedUserData['firstName'] ?? _userData['firstName'];

      notifyListeners();
      // Update the local storage
      final prefs = await SharedPreferences.getInstance();

      final localData = json.encode({
        'userId': _userData['userId'],
        'firstName': _userData['firstName'],
        'lastName': _userData['lastName'],
        'email': _userData['email'],
        'accountType': _userData['accountType'],
        'mobileNumber': _userData['mobileNumber'],
        'branchId': _userData['branchId'],
        'branchName': _userData['branchName'],
        'nic': _userData['nic'],
      });
      await prefs.remove('userData');
      await prefs.setString('userData', localData);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  // Change password
  Future<void> chnagePassword(Map<String, dynamic> passwordData) async {
    try {
      final passwordD = {
        "currentPassword": passwordData['currentPassword'],
        "password": passwordData['password'],
      };
      final response = await API.userAPI
          .changePassword(_userData['userId'], passwordD, token: _token);
    } catch (error) {
      throw error;
    }
  }

  // Call reset password
  Future<void> forgotPassword(String email) async {
    print(email);
    try {
      final response = await API.userAPI.resetPassword(email);
    } catch (error) {
      throw error;
    }
  }

  // Try auto login if token is valid
  Future<bool> tryAutoLogin() async {
    if (!_userData.isEmpty) {
      return true;
    }
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

    // Subscribe users to cloud messaging
    await subscribeToChannel();
    return true;
  }

  // Logout user
  Future<void> logout() async {
    _token = null;
    _userData = {};
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    prefs.remove('tokenData');
    prefs.remove('cartId');
    await FirebaseMessaging.instance
        .unsubscribeFromTopic('order-kitchen-staff');
    await FirebaseMessaging.instance.unsubscribeFromTopic('order-customer');
    await FirebaseMessaging.instance.unsubscribeFromTopic('order-waiter');
  }
}
