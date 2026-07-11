import 'package:flutter/material.dart';
import 'package:blipin_vendor/utils/route_utils.dart';

class QuickStartViewModel extends ChangeNotifier {
  QuickStartViewModel() : emailController = TextEditingController();

  final TextEditingController emailController;

  AppRoute onContinuePressed() {
    final email = emailController.text.trim();
    if (email == 'a') {
      return PasswordLoginRoute(account: email);
    }
    return VerificationRoute(email: email);
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  String getEmail() {
    return emailController.text;
  }

  void setEmail(String email) {
    emailController.text = email;
  }

  void clearEmail() {
    emailController.clear();
  }
}
