import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  bool _isAuthenticated = false;
  String? _username;
  String? _email;

  AuthProvider(this.sharedPreferences) {
    _isAuthenticated = sharedPreferences.getBool('isAuthenticated') ?? false;
    _username = sharedPreferences.getString('username');
    _email = sharedPreferences.getString('email');
  }

  bool get isAuthenticated => _isAuthenticated;
  String? get username => _username;
  String? get email => _email;

  Future<void> login(String username, String email, String password) async {
    // Mocked authentication
    if (email.isNotEmpty && password.isNotEmpty) {
      _isAuthenticated = true;
      _username = username;
      _email = email;
      await sharedPreferences.setBool('isAuthenticated', true);
      await sharedPreferences.setString('username', username);
      await sharedPreferences.setString('email', email);
      notifyListeners();
    }
  }

  Future<void> signUp(String username, String email, String password) async {
    // Mocked sign up
    if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      _isAuthenticated = true;
      _username = username;
      _email = email;
      await sharedPreferences.setBool('isAuthenticated', true);
      await sharedPreferences.setString('username', username);
      await sharedPreferences.setString('email', email);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _username = null;
    _email = null;
    await sharedPreferences.setBool('isAuthenticated', false);
    await sharedPreferences.remove('username');
    await sharedPreferences.remove('email');
    notifyListeners();
  }

  Future<void> updateProfile(String username, String email) async {
    _username = username;
    _email = email;
    await sharedPreferences.setString('username', username);
    await sharedPreferences.setString('email', email);
    notifyListeners();
  }
}
