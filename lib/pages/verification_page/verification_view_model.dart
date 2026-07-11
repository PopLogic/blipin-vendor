import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blipin_vendor/utils/route_utils.dart';

abstract class VerificationViewModel extends ChangeNotifier {
  static const int otpLength = 6;

  List<TextEditingController> get controllers;
  List<FocusNode> get focusNodes;

  int get remainingSeconds;
  bool get canResend;
  bool get hasError;
  bool get isVerifying;

  void initialize({String? email});
  void onOtpChanged(int index, String value);
  void onKeyEvent(int index, KeyEvent event);
  void resendCode();
  AppRoute? consumePendingRoute();

  factory VerificationViewModel.impl() = _VerificationViewModelImpl._;

}

class _VerificationViewModelImpl extends ChangeNotifier implements VerificationViewModel {
  static const int _totalSeconds = 2 * 60 + 59;

  @override
  final List<TextEditingController> controllers =
      List.generate(VerificationViewModel.otpLength, (_) => TextEditingController());
  @override
  final List<FocusNode> focusNodes =
      List.generate(VerificationViewModel.otpLength, (_) => FocusNode());

  int _remainingSeconds = _totalSeconds;
  Timer? _timer;
  bool _canResend = false;
  bool _hasError = false;
  bool _isVerifying = false;
  AppRoute? _pendingRoute;
  String? _email;

  @override
  int get remainingSeconds => _remainingSeconds;
  @override
  bool get canResend => _canResend;
  @override
  bool get hasError => _hasError;
  @override
  bool get isVerifying => _isVerifying;

  bool _isDisposed = false;

  _VerificationViewModelImpl._(){
    _startTimer();
    for (final fn in focusNodes) {
      fn.addListener(notifyListeners);
    }
  }

  @override
  void initialize({String? email}) {
    _email = email;
    _pendingRoute = null;
    _hasError = false;
    _isVerifying = false;
    for (final c in controllers) {
      c.clear();
    }
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _remainingSeconds = _totalSeconds;
    _canResend = false;
    notifyListeners();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remainingSeconds <= 0) {
        t.cancel();
        _canResend = true;
        notifyListeners();
      } else {
        _remainingSeconds--;
        notifyListeners();
      }
    });
  }

  @override
  void onOtpChanged(int index, String value) {
    if (value.length == 1) {
      if (index < VerificationViewModel.otpLength - 1) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
      }
    }
    _hasError = false;
    _triggerAutoVerify();
    notifyListeners();
  }

  @override
  void onKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        controllers[index].text.isEmpty &&
        index > 0) {
      focusNodes[index - 1].requestFocus();
      controllers[index - 1].clear();
      _hasError = false;
      notifyListeners();
    }
  }

  void _triggerAutoVerify() {
    final code = controllers.map((c) => c.text).join();
    if (_pendingRoute != null || _isVerifying) {
      return;
    }
    if (code.length == VerificationViewModel.otpLength) {
      _validateOtp(code);
    }
  }

  Future<void> _validateOtp(String code) async {
    _isVerifying = true;
    notifyListeners();
    final isMatched = await _compareOtp(code);
    _isVerifying = false;
    if (isMatched) {
      _hasError = false;
      _pendingRoute = CreatePasswordRoute(email: _email);
    } else {
      _hasError = true;
    }
    notifyListeners();
  }

  Future<bool> _compareOtp(String code) async {
    return true;
  }

  @override
  void resendCode() {
    for (final c in controllers) {
      c.clear();
    }
    _hasError = false;
    focusNodes[0].requestFocus();
    _startTimer();
    // TODO: call API to resend code
  }

  @override
  AppRoute? consumePendingRoute() {
    final route = _pendingRoute;
    _pendingRoute = null;
    return route;
  }

  @override
  void dispose() {
    _isDisposed = true;
    _timer?.cancel();
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }


}