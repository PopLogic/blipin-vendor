import 'package:blipin_vendor/utils/route_utils.dart';
import 'package:flutter/material.dart';

class PasswordLoginViewModel extends ChangeNotifier {
  PasswordLoginViewModel() : passwordController = TextEditingController();

  final TextEditingController passwordController;

  String account = '';
  bool obscurePassword = true;
  bool hasError = false;
  AppRoute? _pendingRoute;

  void initialize({required String account}) {
    this.account = account;
    obscurePassword = true;
    hasError = false;
    _pendingRoute = null;
    passwordController.clear();
    notifyListeners();
  }

  bool get canSubmit => passwordController.text.isNotEmpty;

  void togglePasswordObscure() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void onPasswordChanged(String value) {
    if (hasError) {
      hasError = false;
    }
    notifyListeners();
  }

  void onNextPressed() {
    if (passwordController.text == '123') {
      hasError = false;
      _pendingRoute = const CreateMenuSuccessRoute();
    } else {
      hasError = true;
    }
    notifyListeners();
  }

  AppRoute? consumePendingRoute() {
    final route = _pendingRoute;
    _pendingRoute = null;
    return route;
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
