// auth_provider.dart
import 'package:flutter/foundation.dart';
import '../data/models/user.dart';
import '../data/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  final AuthService _authService = AuthService();

  User? get user => _user;
  bool get isAuthenticated => _user != null;

  Future<bool> login(String email, String password) async {
    try {
      final user = await _authService.login(email, password);
      if (user != null) {
        _user = user;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error en AuthProvider.login: $e');
      rethrow;
    }
  }

  void logout() {
    _user = null;
    _authService.logout();
    notifyListeners();
  }
}