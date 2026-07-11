import 'package:flutter/material.dart';

class CreatePasswordViewModel extends ChangeNotifier {
  CreatePasswordViewModel({
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
  })  : passwordController = passwordController ?? TextEditingController(),
        confirmPasswordController =
            confirmPasswordController ?? TextEditingController() {
    this.passwordController.addListener(_onInputChanged);
    this.confirmPasswordController.addListener(_onInputChanged);
  }

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  void initialize({String? email}) {
    passwordController.clear();
    confirmPasswordController.clear();
    obscurePassword = true;
    obscureConfirmPassword = true;
    notifyListeners();
  }

  String get password => passwordController.text;
  String get confirmPassword => confirmPasswordController.text;

  bool get hasMinLength => password.length >= 8;
  bool get hasUpperAndLowerCase =>
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])').hasMatch(password);
  bool get hasNumber => RegExp(r'\d').hasMatch(password);
  bool get hasSpecialChar =>
      RegExp(r'[!@#$%^&*(),.?":{}|<>\[\]\\/\-_+=;`~]').hasMatch(password);

  int get matchedRuleCount {
    var count = 0;
    if (hasMinLength) count++;
    if (hasUpperAndLowerCase) count++;
    if (hasNumber) count++;
    if (hasSpecialChar) count++;
    return count;
  }

  bool get isPasswordValid => matchedRuleCount == 4;
  bool get isConfirmMatched =>
      confirmPassword.isNotEmpty && password == confirmPassword;
  bool get showMismatchError =>
      confirmPassword.isNotEmpty && password != confirmPassword;
  bool get canSubmit => isPasswordValid && isConfirmMatched;

  void togglePasswordObscure() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordObscure() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  Color strengthColor(int index) {
    if (password.isEmpty) {
      return const Color(0xFFE6E6E6);
    }
    if (matchedRuleCount <= 2) {
      return index == 0 ? const Color(0xFFE84545) : const Color(0xFFE6E6E6);
    }
    if (matchedRuleCount == 3) {
      return index <= 1 ? const Color(0xFFF5A623) : const Color(0xFFE6E6E6);
    }
    return const Color(0xFF42C782);
  }

  void _onInputChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    passwordController.removeListener(_onInputChanged);
    confirmPasswordController.removeListener(_onInputChanged);
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
