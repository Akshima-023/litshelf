import 'package:flutter/material.dart';

class Forgetpasswordprovider extends ChangeNotifier {
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  void toggleNewPassword() {
    obscureNewPassword = !obscureNewPassword;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  bool validate(String password, String confirmPassword) {
    if (password.isEmpty || confirmPassword.isEmpty) return false;
    if (password.length < 6) return false;
    if (password != confirmPassword) return false;
    return true;
  }
}