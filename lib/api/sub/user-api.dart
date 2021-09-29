import 'dart:convert';
import '../apiConn.dart' show APIConn;

class UserAPI {
  static final _conn = APIConn();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final data = {'email': email, 'password': password};
      var response = await _conn.post("api/user/login/user", body: data);
      return response;
    } catch (error) {
      throw error;
    }
  }

  Future<Map<String, dynamic>> customerRegister(
      Map<String, dynamic> data) async {
    try {
      var response = await _conn.post("api/user/register/customer", body: data);
      return response;
    } catch (error) {
      throw error;
    }
  }

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
}
