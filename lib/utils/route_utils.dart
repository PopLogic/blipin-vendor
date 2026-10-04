import 'package:blipin_vendor/pages/create_menu_success_page/create_menu_success_page.dart';
import 'package:blipin_vendor/pages/launcher_page/launcher_page.dart';
import 'package:blipin_vendor/pages/password_login_page/password_login_page.dart';
import 'package:blipin_vendor/pages/quick_start_page/quick_start_page.dart';
import 'package:blipin_vendor/pages/register/account_name_page/account_name_page.dart';
import 'package:blipin_vendor/pages/register/create_password_page/create_password_page.dart';
import 'package:blipin_vendor/pages/register/legal_terms_page/legal_terms_page.dart';
import 'package:blipin_vendor/pages/register/legal_terms_page/privacy_policy_page.dart';
import 'package:blipin_vendor/pages/register/legal_terms_page/service_terms_page.dart';
import 'package:blipin_vendor/pages/register/verification_page/verification_page.dart';
import 'package:blipin_vendor/pages/splash_page/entry_page.dart';
import 'package:flutter/material.dart';

abstract class AppRoute {
  T accept<T>(AppRouteVisitor<T> visitor);
}

abstract class AppRouteVisitor<T> {
  T visitEntryRoute(EntryRoute route);
  T visitQuickStartRoute(QuickStartRoute route);
  T visitVerificationRoute(VerificationRoute route);
  T visitCreatePasswordRoute(CreatePasswordRoute route);
  T visitPasswordLoginRoute(PasswordLoginRoute route);
  T visitAccountNameRoute(AccountNameRoute route);
  T visitLegalTermsRoute(LegalTermsRoute route);
  T visitPrivacyPolicyRoute(PrivacyPolicyRoute route);
  T visitServiceTermsRoute(ServiceTermsRoute route);
  T visitCreateMenuSuccessRoute(CreateMenuSuccessRoute route);
  T visitLauncherRoute(LauncherRoute route);
}

class EntryRoute implements AppRoute {
  const EntryRoute({this.replaceCurrent = false});

  final bool replaceCurrent;

  @override
  T accept<T>(AppRouteVisitor<T> visitor) {
    return visitor.visitEntryRoute(this);
  }
}

class QuickStartRoute implements AppRoute {
  const QuickStartRoute();

  @override
  T accept<T>(AppRouteVisitor<T> visitor) {
    return visitor.visitQuickStartRoute(this);
  }
}

class VerificationRoute implements AppRoute {
  const VerificationRoute({this.email});

  final String? email;

  @override
  T accept<T>(AppRouteVisitor<T> visitor) {
    return visitor.visitVerificationRoute(this);
  }
}

class CreatePasswordRoute implements AppRoute {
  const CreatePasswordRoute({this.email});

  final String? email;

  @override
  T accept<T>(AppRouteVisitor<T> visitor) {
    return visitor.visitCreatePasswordRoute(this);
  }
}

class PasswordLoginRoute implements AppRoute {
  const PasswordLoginRoute({required this.account});

  final String account;

  @override
  T accept<T>(AppRouteVisitor<T> visitor) {
    return visitor.visitPasswordLoginRoute(this);
  }
}

class AccountNameRoute implements AppRoute {
  const AccountNameRoute();

  @override
  T accept<T>(AppRouteVisitor<T> visitor) {
    return visitor.visitAccountNameRoute(this);
  }
}

class LegalTermsRoute implements AppRoute {
  const LegalTermsRoute();

  @override
  T accept<T>(AppRouteVisitor<T> visitor) {
    return visitor.visitLegalTermsRoute(this);
  }
}

class PrivacyPolicyRoute implements AppRoute {
  const PrivacyPolicyRoute();

  @override
  T accept<T>(AppRouteVisitor<T> visitor) {
    return visitor.visitPrivacyPolicyRoute(this);
  }
}

class ServiceTermsRoute implements AppRoute {
  const ServiceTermsRoute();

  @override
  T accept<T>(AppRouteVisitor<T> visitor) {
    return visitor.visitServiceTermsRoute(this);
  }
}

class CreateMenuSuccessRoute implements AppRoute {
  const CreateMenuSuccessRoute();

  @override
  T accept<T>(AppRouteVisitor<T> visitor) {
    return visitor.visitCreateMenuSuccessRoute(this);
  }
}

class LauncherRoute implements AppRoute {
  const LauncherRoute({this.replaceCurrent = false, this.clearStack = false});

  final bool replaceCurrent;
  final bool clearStack;

  @override
  T accept<T>(AppRouteVisitor<T> visitor) {
    return visitor.visitLauncherRoute(this);
  }
}

class RouteUtils {
  static Future<void> pushPage(BuildContext context, Widget page) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  static Future<void> replaceWithPage(BuildContext context, Widget page) async {
    await Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  static Future<void> navigate(BuildContext context, AppRoute route) async {
    await route.accept(_NavigatorRouteVisitor(context));
  }
}

class _NavigatorRouteVisitor implements AppRouteVisitor<Future<void>> {
  _NavigatorRouteVisitor(this.context);

  final BuildContext context;

  @override
  Future<void> visitEntryRoute(EntryRoute route) async {
    await EntryPage.enterPage(context, replaceCurrent: route.replaceCurrent);
  }

  @override
  Future<void> visitQuickStartRoute(QuickStartRoute route) async {
    await QuickStartPage.enterPage(context);
  }

  @override
  Future<void> visitVerificationRoute(VerificationRoute route) async {
    await VerificationPage.enterPage(context, email: route.email);
  }

  @override
  Future<void> visitCreatePasswordRoute(CreatePasswordRoute route) async {
    await CreatePasswordPage.enterPage(context, email: route.email);
  }

  @override
  Future<void> visitPasswordLoginRoute(PasswordLoginRoute route) async {
    await PasswordLoginPage.enterPage(context, account: route.account);
  }

  @override
  Future<void> visitAccountNameRoute(AccountNameRoute route) async {
    await AccountNamePage.enterPage(context);
  }

  @override
  Future<void> visitLegalTermsRoute(LegalTermsRoute route) async {
    await LegalTermsPage.enterPage(context);
  }

  @override
  Future<void> visitPrivacyPolicyRoute(PrivacyPolicyRoute route) async {
    await PrivacyPolicyPage.enterPage(context);
  }

  @override
  Future<void> visitServiceTermsRoute(ServiceTermsRoute route) async {
    await ServiceTermsPage.enterPage(context);
  }

  @override
  Future<void> visitCreateMenuSuccessRoute(CreateMenuSuccessRoute route) async {
    await CreateMenuSuccessPage.enterPage(context);
  }

  @override
  Future<void> visitLauncherRoute(LauncherRoute route) async {
    await LauncherPage.enterPage(
      context,
      replaceCurrent: route.replaceCurrent,
      clearStack: route.clearStack,
    );
  }
}
