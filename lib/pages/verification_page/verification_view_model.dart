import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final verificationViewModelProvider = ChangeNotifierProvider<VerificationViewModel>(
  (ref) => VerificationViewModel.impl(),
);

abstract class VerificationViewModel extends ChangeNotifier {
  static const int otpLength = 6;

  List<TextEditingController> get controllers;
  List<FocusNode> get focusNodes;

  int get remainingSeconds;
  bool get canResend;
  bool get hasError;

  void onOtpChanged(int index, String value);
  void onKeyEvent(int index, KeyEvent event);
  void resendCode();

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

  @override
  int get remainingSeconds => _remainingSeconds;
  @override
  bool get canResend => _canResend;
  @override
  bool get hasError => _hasError;

  bool _isDisposed = false;

  _VerificationViewModelImpl._(){
    _startTimer();
    for (final fn in focusNodes) {
      fn.addListener(notifyListeners);
    }
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
        _validateOtp();
      }
    }
    _hasError = false;
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
      notifyListeners();
    }
  }

  void _validateOtp() {
    final code = controllers.map((c) => c.text).join();
    if (code.length == VerificationViewModel.otpLength) {
      // TODO: call actual verification API
      _hasError = false;
      notifyListeners();
    }
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