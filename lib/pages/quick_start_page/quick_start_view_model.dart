import 'package:flutter/material.dart';
import 'package:blipin_vendor/utils/route_utils.dart';

class QuickStartViewModel {
  QuickStartViewModel() : emailController = TextEditingController();

  final TextEditingController emailController;

  AppRoute onContinuePressed() {
    return VerificationRoute(email: emailController.text.trim());
  }

  void dispose() {
    emailController.dispose();
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
