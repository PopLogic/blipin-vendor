import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blipin_vendor/generated/app_localizations.dart';
import 'package:blipin_vendor/pages/verification_page/verification_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:blipin_vendor/utils/route_utils.dart';

class VerificationPage extends HookConsumerWidget {
  const VerificationPage({super.key, this.email});

  final String? email;

  static Future<void> enterPage(BuildContext context, {String? email}) async {
    await RouteUtils.pushPage(context, VerificationPage(email: email));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final vm = ref.read(verificationViewModelProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                SizedBox(
                  height: 56,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => Navigator.maybePop(context),
                        ),
                      ),
                      Text(
                        l10n.createAccountTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 3,
                  width: double.infinity,
                  color: const Color(0xFFE07820),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    l10n.verificationPageTitle,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.verificationPageSubtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF888888),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _OtpRow(
                    controllers: vm.controllers,
                    focusNodes: vm.focusNodes,
                    hasError: vm.hasError,
                    onChanged: vm.onOtpChanged,
                    onKeyEvent: vm.onKeyEvent,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: vm.canResend
                        ? GestureDetector(
                      onTap: vm.resendCode,
                      child: Text(
                        l10n.verificationPageResendButton,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFFE07820),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFFE07820),
                        ),
                      ),
                    )
                        : Text(
                      _timerText(context, vm),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ),
                  if (vm.hasError) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.error, color: Color(0xFFD32F2F), size: 16),
                        const SizedBox(width: 4),
                        Text(
                          l10n.verificationPageErrorMessage,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFFD32F2F),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _timerText(BuildContext context, VerificationViewModel vm) {
    final m = vm.remainingSeconds ~/ 60;
    final s = (vm.remainingSeconds % 60).toString().padLeft(2, '0');
    return AppLocalizations.of(context)!.verificationPageResendTimer(m, s);
  }
}

class _OtpRow extends StatelessWidget {
  const _OtpRow({
    required this.controllers,
    required this.focusNodes,
    required this.hasError,
    required this.onChanged,
    required this.onKeyEvent,
  });

  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final bool hasError;
  final void Function(int index, String value) onChanged;
  final void Function(int index, KeyEvent event) onKeyEvent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        controllers.length,
        (i) => _OtpBox(
          controller: controllers[i],
          focusNode: focusNodes[i],
          hasError: hasError,
          onChanged: (v) => onChanged(i, v),
          onKeyEvent: (e) => onKeyEvent(i, e),
        ),
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.hasError,
    required this.onChanged,
    required this.onKeyEvent,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool hasError;
  final ValueChanged<String> onChanged;
  final void Function(KeyEvent) onKeyEvent;

  @override
  Widget build(BuildContext context) {
    final isFocused = focusNode.hasFocus;
    final isFilled = controller.text.isNotEmpty;

    Color borderColor;
    double borderWidth;
    if (hasError) {
      borderColor = const Color(0xFFD32F2F);
      borderWidth = 1.5;
    } else if (isFocused) {
      borderColor = const Color(0xFFE07820);
      borderWidth = 2;
    } else if (isFilled) {
      borderColor = const Color(0xFF555555);
      borderWidth = 1.5;
    } else {
      borderColor = const Color(0xFFCCCCCC);
      borderWidth = 1;
    }

    return SizedBox(
      width: 48,
      height: 56,
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: onKeyEvent,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: hasError ? const Color(0xFFD32F2F) : const Color(0xFF222222),
          ),
          decoration: InputDecoration(
            counterText: '',
            contentPadding: EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor, width: borderWidth),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor, width: borderWidth),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor, width: borderWidth),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
