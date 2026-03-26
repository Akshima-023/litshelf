import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;      // For signup/login button
  bool _isInitializing = true;  // For initial app load
  String? _error;
  bool _isLoggedIn = false;
  String? _loggedInEmail;

  bool get isLoading => _isLoading;
  bool get isInitializing => _isInitializing;
  String? get error => _error;
  bool get isLoggedIn => _isLoggedIn;
  String? get loggedInEmail => _loggedInEmail;

  List<Map<String, String>> _users = [];

  AuthProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadUsers();
    await _checkLoggedIn();
    _isInitializing = false; // finished loading
    notifyListeners();
  }

  Future<void> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersString = prefs.getString('users');
    if (usersString != null) {
      _users = List<Map<String, String>>.from(
        json.decode(usersString).map((x) => Map<String, String>.from(x)),
      );
    }
  }

  Future<void> _saveUsers() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('users', json.encode(_users));
  }

  Future<void> _checkLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('loggedInEmail');
    if (email != null) {
      _isLoggedIn = true;
      _loggedInEmail = email;
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    if (_users.any((user) => user['email'] == email)) {
      _error = "Email already registered! Please login.";
      _isLoading = false;
      notifyListeners();
      return;
    }

    _users.add({'name': name, 'email': email, 'password': password});
    await _saveUsers();

    _loggedInEmail = email;
    _isLoggedIn = true;

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('loggedInEmail', email);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    final user = _users.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => {},
    );

    if (user.isNotEmpty) {
      _isLoggedIn = true;
      _loggedInEmail = email;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('loggedInEmail', email);
    } else {
      _error = "Invalid email or password";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _loggedInEmail = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('loggedInEmail');
    notifyListeners();
  }
}