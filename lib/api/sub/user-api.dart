import 'dart:convert';
import '../apiConn.dart' show APIConn;

class UserAPI {
  static final _conn = APIConn();

  // User login
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final data = {'email': email, 'password': password};
      var response = await _conn.post("api/user/login/user", body: data);
      return response;
    } catch (error) {
      throw error;
    }
  }

  // Customer register
  Future<Map<String, dynamic>> customerRegister(
      Map<String, dynamic> data) async {
    try {
      var response = await _conn.post("api/user/register/customer", body: data);
      return response;
    } catch (error) {
      throw error;
    }
  }

  // Update profile details -> Customer, Staff
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data,
      {String? token}) async {
    try {
      var response = await _conn.put("api/user/update-user-profile",
          body: data, token: token);
      return response;
    } catch (error) {
      throw error;
    }
  }

  // Change password -> Customer, Staff
  Future<Map<String, dynamic>> changePassword(
      String userId, Map<String, dynamic> data,
      {String? token}) async {
    try {
      var response = await _conn.put("api/user/update-password/$userId",
          body: data, token: token);
      return response;
    } catch (error) {
      throw error;
    }
  }

  // Reset password
  Future<Map<String, dynamic>> resetPassword(String email) async {
    try {
      var response = await _conn
          .put("api/user/request-reset-password", body: {"email": email});
      return response;
    } catch (error) {
      throw error;
    }
  }
}
