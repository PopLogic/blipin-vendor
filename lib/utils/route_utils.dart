import 'package:blipin_vendor/pages/verification_page/verification_page.dart';
import 'package:flutter/material.dart';

abstract class AppRoute {
  T accept<T>(AppRouteVisitor<T> visitor);
}

abstract class AppRouteVisitor<T> {
  T visitVerificationRoute(VerificationRoute route);
}

class VerificationRoute implements AppRoute {
  const VerificationRoute({this.email});

  final String? email;

  @override
  T accept<T>(AppRouteVisitor<T> visitor) {
    return visitor.visitVerificationRoute(this);
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
}