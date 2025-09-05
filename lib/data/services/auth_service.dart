// auth_service.dart
import 'package:dio/dio.dart';
import '../models/user.dart';
import 'api_client.dart';

class AuthService {
  Future<User?> login(String email, String password) async {
    try {
      final response = await ApiClient.dio.post(
        "/login", 
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data);
        ApiClient.setAuthToken(user.token);
        return user;
      }
      return null;
    } on DioException catch (e) {
      ("Error login: ${e.response?.data ?? e.message}");
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await ApiClient.dio.post("/logout");
    } catch (_) {}
    ApiClient.clearAuthToken();
  }
}