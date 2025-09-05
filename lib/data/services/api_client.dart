// api_client.dart
import 'package:dio/dio.dart';

class ApiClient {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://iotcyd.com/api",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        "Accept": "application/json",
      },
    ),
  );

  static void setAuthToken(String token) {
   
    dio.options.headers["Authorization"] = "Bearer $token";
    
  }

  static void clearAuthToken() {
   
    dio.options.headers.remove("Authorization");
  }

 
  static void printCurrentHeaders() {
    //print('Headers actuales: ${dio.options.headers}');
  }
}