import 'package:blipin_vendor/generated/app_localizations.dart';
import 'package:blipin_vendor/utils/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'password_login_view_model.dart';

class PasswordLoginPage extends HookWidget {
  const PasswordLoginPage({super.key, required this.vm});

  final PasswordLoginViewModel vm;

  static Future<void> enterPage(
    BuildContext context, {
    required String account,
  }) async {
    final vm = PasswordLoginViewModel();
    vm.initialize(account: account);
    final page = PasswordLoginPage(vm: vm);
    await RouteUtils.pushPage(context, page);
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      return vm.dispose;
    }, [vm]);
    useListenable(vm);
    final l10n = AppLocalizations.of(context)!;

    final route = vm.consumePendingRoute();
    if (route != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        RouteUtils.navigate(context, route);
      });
    }

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
                    l10n.passwordLoginTitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 28),
                    Text(
                      l10n.passwordLoginHeading,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      '${l10n.passwordLabel} ${l10n.requiredFieldMark}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF555555),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: vm.passwordController,
                      obscureText: vm.obscurePassword,
                      onChanged: vm.onPasswordChanged,
                      decoration: InputDecoration(
                        hintText: l10n.passwordHint,
                        hintStyle: const TextStyle(
                          color: Color(0xFFB4B4B4),
                          fontSize: 16,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        suffixIcon: IconButton(
                          onPressed: vm.togglePasswordObscure,
                          icon: Icon(
                            vm.obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20,
                            color: const Color(0xFF8C8C8C),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: vm.hasError
                                ? const Color(0xFFD84E64)
                                : const Color(0xFFE3E3E3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: vm.hasError
                                ? const Color(0xFFD84E64)
                                : const Color(0xFFE3E3E3),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: vm.hasError
                                ? const Color(0xFFD84E64)
                                : const Color(0xFFE3E3E3),
                          ),
                        ),
                      ),
                    ),
                    if (vm.hasError) ...[
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.error, color: Color(0xFFD84E64), size: 16),
                          SizedBox(width: 6),
                          Text(
                            l10n.passwordInputError,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFD84E64),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        l10n.forgotPassword,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF9A9A9A),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: vm.canSubmit ? vm.onNextPressed : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: vm.canSubmit
                              ? const Color(0xFFFF6A00)
                              : const Color(0xFFF6DCC8),
                          disabledBackgroundColor: const Color(0xFFF6DCC8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          l10n.nextButton,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
