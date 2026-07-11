import 'dart:async';

import 'package:blipin_vendor/generated/app_localizations.dart';
import 'package:blipin_vendor/utils/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'create_password_view_model.dart';

class CreatePasswordPage extends HookWidget {
  const CreatePasswordPage({super.key, required this.vm, this.email});

  final CreatePasswordViewModel vm;
  final String? email;

  static Future<void> enterPage(BuildContext context, {String? email}) async {
    final vm = CreatePasswordViewModel();
    vm.initialize(email: email);
    final page = CreatePasswordPage(vm: vm, email: email);
    RouteUtils.pushPage(context, page);
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      return vm.dispose;
    }, [vm]);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
            Expanded(
              child: AnimatedBuilder(
                animation: vm,
                builder: (context, _) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 36),
                        const Text(
                          '建立您的密碼',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 44),
                        _FieldLabel(text: '密碼${l10n.requiredFieldMark}'),
                        const SizedBox(height: 8),
                        TextField(
                          controller: vm.passwordController,
                          obscureText: vm.obscurePassword,
                          decoration: _inputDecoration(
                            suffixIcon: IconButton(
                              onPressed: vm.togglePasswordObscure,
                              icon: Icon(
                                vm.obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 20,
                                color: const Color(0xFF9A9A9A),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: List.generate(
                            3,
                            (index) => Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: index == 2 ? 0 : 8),
                                height: 4,
                                decoration: BoxDecoration(
                                  color: vm.strengthColor(index),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _RuleRow(
                          text: '長度至少8字元',
                          matched: vm.hasMinLength,
                          hasInput: vm.password.isNotEmpty,
                        ),
                        _RuleRow(
                          text: '半形英文字母大小寫',
                          matched: vm.hasUpperAndLowerCase,
                          hasInput: vm.password.isNotEmpty,
                        ),
                        _RuleRow(
                          text: '至少1數字',
                          matched: vm.hasNumber,
                          hasInput: vm.password.isNotEmpty,
                        ),
                        _RuleRow(
                          text: '包含1特殊符號',
                          matched: vm.hasSpecialChar,
                          hasInput: vm.password.isNotEmpty,
                        ),
                        const SizedBox(height: 34),
                        _FieldLabel(text: '確認密碼${l10n.requiredFieldMark}'),
                        const SizedBox(height: 8),
                        TextField(
                          controller: vm.confirmPasswordController,
                          obscureText: vm.obscureConfirmPassword,
                          decoration: _inputDecoration(
                            showErrorBorder: vm.showMismatchError,
                            suffixIcon: IconButton(
                              onPressed: vm.toggleConfirmPasswordObscure,
                              icon: Icon(
                                vm.obscureConfirmPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 20,
                                color: const Color(0xFF9A9A9A),
                              ),
                            ),
                          ),
                        ),
                        if (vm.showMismatchError) ...[
                          const SizedBox(height: 10),
                          const Row(
                            children: [
                              Icon(Icons.error, color: Color(0xFFE84545), size: 16),
                              SizedBox(width: 6),
                              Text(
                                '密碼不相符',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFE84545),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: vm.canSubmit ? () {} : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: vm.canSubmit
                                  ? const Color(0xFFE07820)
                                  : const Color(0xFFF6DCC8),
                              disabledBackgroundColor: const Color(0xFFF6DCC8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              '下一步',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required Widget suffixIcon,
    bool showErrorBorder = false,
  }) {
    final borderColor =
        showErrorBorder ? const Color(0xFFE84545) : const Color(0xFFD9D9D9);
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _RuleRow extends StatelessWidget {
  const _RuleRow({
    required this.text,
    required this.matched,
    required this.hasInput,
  });

  final String text;
  final bool matched;
  final bool hasInput;

  @override
  Widget build(BuildContext context) {
    final Color color;
    if (!hasInput) {
      color = const Color(0xFFD9D9D9);
    } else {
      color = matched ? const Color(0xFF42C782) : const Color(0xFFE84545);
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: hasInput ? color : const Color(0xFF9A9A9A),
            ),
          ),
        ],
      ),
    );
  }
}
