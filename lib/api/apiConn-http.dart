// import 'dart:io';
// import 'dart:convert' as convert;
// import "package:http/http.dart" as http;
// import '../models/http_exception.dart';

// class APIConn {
//   static final APIConn _instance = APIConn._internal();

//   factory APIConn() {
//     return _instance;
//   }

//   APIConn._internal();

//   final _baseUrl = Uri.parse("http://10.0.2.2:8000");
//   // final _baseUrl = Uri.parse("https://rms-backend-cs3202.herokuapp.com");

//   String? _token;
//   String? _refreshToken;

//   // Generate bearer token header
//   Map<String, String> generateHeaders({bool auth = true}) {
//     Map<String, String> headers = Map();
//     if (auth && _token != null && _token != "") {
//       headers[HttpHeaders.authorizationHeader] = "Bearer $_token";
//       // headers[HttpHeaders.contentTypeHeader] =
//       //     "application/json; charset=UTF-8";
//     }
//     return headers;
//   }

//   void setAuthToken(String token, {String? refreshToken}) {
//     this._token = token;
//     this._refreshToken = refreshToken ?? "";
//   }

//   void removeAuthToken() {
//     this._token = null;
//     this._refreshToken = null;
//   }

//   Map<String, dynamic> jsonResponseGenerator(http.Response response) {
//     var json = convert.jsonDecode(response.body);
//     return {...json, 'statusCode': response.statusCode};
//   }

//   Future<Map<String, dynamic>> get(String path,
//       {Map<String, dynamic>? query, token}) async {
//     var url = _baseUrl.replace(path: path, queryParameters: query);
//     print(url);
//     try {
//       var response = await http.get(url, headers: generateHeaders(auth: true));

//       var json = jsonResponseGenerator(response);
//       if (response.statusCode != 200) {
//         throw HttpException(json['message']);
//       }
//       return json;
//     } catch (error) {
//       throw error;
//     }
//   }

//   Future<Map<String, dynamic>> post(String path, {dynamic body, token}) async {
//     var url = _baseUrl.replace(path: path);
//     print(url);
//     try {
//       var response = await http.post(
//         url,
//         body: body,
//         headers: {
//           ...generateHeaders(),
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         // {
//         //   'Content-Type': 'application/json; charset=UTF-8',
//         // },
//       ).timeout(const Duration(seconds: 3));
//       var json = jsonResponseGenerator(response);
//       if (response.statusCode != 200) {
//         throw HttpException(json['message']);
//       }
//       return json;
//     } catch (error) {
//       throw error;
//     }
//   }

//   Future<Map<String, dynamic>> put(String path, {dynamic body}) async {
//     var url = _baseUrl.replace(path: path);
//     print(url);
//     try {
//       var response =
//           await http.put(url, body: body, headers: generateHeaders(auth: true));
//       var json = jsonResponseGenerator(response);

//       if (response.statusCode != 200) {
//         throw HttpException(json['message']);
//       }
//       return json;
//     } catch (error) {
//       throw error;
//     }
//   }

//   Future<Map<String, dynamic>> delete(String path) async {
//     var url = _baseUrl.replace(path: path);
//     print(url);
//     try {
//       var response =
//           await http.delete(url, headers: generateHeaders(auth: true));
//       var json = jsonResponseGenerator(response);
//       if (response.statusCode != 200) {
//         throw HttpException(json['message']);
//       }
//       return json;
//     } catch (error) {
//       throw error;
//     }
//   }
// }
