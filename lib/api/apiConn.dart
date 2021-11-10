import 'dart:io';
import 'dart:convert' as convert;
import '../models/http_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class APIConn {
  static final APIConn _instance = APIConn._internal();
  var _dio = new Dio();

  factory APIConn() {
    return _instance;
  }

  APIConn._internal() {
    _dio.options.connectTimeout = 8000;
    _dio.options.receiveTimeout = 4000;
  }

  final _baseUrl = Uri.parse(dotenv.env['BACKEND_URL'] ?? "");

  String? _token;
  String? _refreshToken;

  // Generate bearer token header
  Map<String, String> generateHeaders({bool auth = true}) {
    Map<String, String> headers = Map();
    if (auth && _token != null && _token != "") {
      headers[HttpHeaders.authorizationHeader] = "Bearer $_token";
      // headers[HttpHeaders.contentTypeHeader] =
      //     "application/json; charset=UTF-8";
    }
    return headers;
  }

  // Set access token and refresh token
  void setAuthToken(String token, {String? refreshToken}) {
    this._token = token;
    this._refreshToken = refreshToken ?? "";
  }

  // Remove access token and refresh token
  void removeAuthToken() {
    this._token = null;
    this._refreshToken = null;
  }

  // Get request
  Future<Map<String, dynamic>> get(String path,
      {Map<String, dynamic>? query, String? token}) async {
    var url = _baseUrl.replace(path: path);

    print(url);
    try {
      if (token != null || token != "") {
        setAuthToken(token ?? "");
      }
      Response response = await _dio.get(url.toString(),
          queryParameters: query, options: Options(headers: generateHeaders()));

      var json = response.data;
      if (response.statusCode != 200) {
        throw HttpException(json['message']);
      }
      // print(json);
      return json;
    } on DioError catch (e) {
      print("API Conn error");
      print(e.response?.data);
      if (e.response != null) {
        throw HttpException(e.response?.data['message'] ??
            "Something went wrong! Check your internet connection.");
      } else {
        throw HttpException(
            "Something went wrong! Check your internet connection.");
      }
    } catch (error) {
      print('get error');

      throw error;
    }
  }

  // Post request
  Future<Map<String, dynamic>> post(String path,
      {dynamic body, String? token}) async {
    var url = _baseUrl.replace(path: path);

    print(url);
    try {
      if (token != null || token != "") {
        setAuthToken(token ?? "");
      }
      Response response = await _dio.post(url.toString(),
          data: body, options: Options(headers: generateHeaders()));
      final json = response.data;
      if (response.statusCode != 200) {
        throw HttpException(json['message']);
      }
      return json;
    } on DioError catch (e) {
      print("API Conn error");
      print(e.response?.data);
      if (e.response != null) {
        throw HttpException(e.response?.data['message'] ??
            "Something went wrong! Check your internet connection.");
      } else {
        throw HttpException(
            "Something went wrong! Check your internet connection.");
      }
    } catch (error) {
      throw error;
    }
  }

// Put request -> Update
  Future<Map<String, dynamic>> put(String path,
      {dynamic body, String? token}) async {
    var url = _baseUrl.replace(path: path);

    print(url);
    try {
      if (token != null || token != "") {
        setAuthToken(token ?? "");
      }
      Response response = await _dio.put(url.toString(),
          data: body, options: Options(headers: generateHeaders()));

      final json = response.data;
      if (response.statusCode != 200) {
        throw HttpException(json['message']);
      }
      return json;
    } on DioError catch (e) {
      print("API Conn error");
      print(e.response?.data);
      if (e.response != null) {
        throw HttpException(e.response?.data['message'] ??
            "Something went wrong! Check your internet connection.");
      } else {
        throw HttpException(
            "Something went wrong! Check your internet connection.");
      }
    } catch (error) {
      throw error;
    }
  }

  // Delete request
  Future<Map<String, dynamic>> delete(String path, {String? token}) async {
    var url = _baseUrl.replace(path: path);

    try {
      if (token != null || token != "") {
        setAuthToken(token ?? "");
      }

      var response = await _dio.delete(url.toString(),
          options: Options(headers: generateHeaders()));

      final json = response.data;
      if (response.statusCode != 200) {
        throw HttpException(json['message']);
      }
      return json;
    } on DioError catch (e) {
      if (e.response != null) {
        throw HttpException(e.response?.data['message'] ??
            "Something went wrong! Check your internet connection.");
      } else {
        throw HttpException(
            "Something went wrong! Check your internet connection.");
      }
    } catch (error) {
      throw error;
    }
  }
}
