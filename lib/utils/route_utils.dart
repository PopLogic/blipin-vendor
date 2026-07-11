import 'package:blipin_vendor/pages/verification_page/verification_page.dart';
import 'package:blipin_vendor/pages/create_password_page/create_password_page.dart';
import 'package:blipin_vendor/pages/password_login_page/password_login_page.dart';
import 'package:blipin_vendor/pages/create_menu_success_page/create_menu_success_page.dart';
import 'package:flutter/material.dart';

abstract class AppRoute {
  T accept<T>(AppRouteVisitor<T> visitor);
}

abstract class AppRouteVisitor<T> {
  T visitVerificationRoute(VerificationRoute route);
  T visitCreatePasswordRoute(CreatePasswordRoute route);
  T visitPasswordLoginRoute(PasswordLoginRoute route);
  T visitCreateMenuSuccessRoute(CreateMenuSuccessRoute route);
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

class CreateMenuSuccessRoute implements AppRoute {
  const CreateMenuSuccessRoute();

  @override
  T accept<T>(AppRouteVisitor<T> visitor) {
    return visitor.visitCreateMenuSuccessRoute(this);
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
  Future<void> visitCreateMenuSuccessRoute(CreateMenuSuccessRoute route) async {
    await CreateMenuSuccessPage.enterPage(context);
  }
}