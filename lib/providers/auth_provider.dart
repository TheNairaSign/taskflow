import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  bool _isAuthenticated = false;

  AuthProvider(this.sharedPreferences) {
    _isAuthenticated = sharedPreferences.getBool('isAuthenticated') ?? false;
  }

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String email, String password) async {
    // Mocked authentication
    if (email.isNotEmpty && password.isNotEmpty) {
      _isAuthenticated = true;
      await sharedPreferences.setBool('isAuthenticated', true);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    await sharedPreferences.setBool('isAuthenticated', false);
    notifyListeners();
  }
}
