import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:sint/sint.dart';

import 'domain/interfaces/auth_service.dart';
import 'ui/auth/login_page.dart';
import 'ui/home/home_page.dart';

abstract final class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';

  static final List<SintPage<dynamic>> pages = <SintPage<dynamic>>[
    SintPage<dynamic>(
      name: login,
      page: () => const LoginPage(),
    ),
    SintPage<dynamic>(
      name: home,
      page: () => const HomePage(),
    ),
  ];
}

/// Cross-cutting route guard registered once via `SintMaterialApp.globalMiddlewares`.
class AuthGuard extends SintMiddleware {
  AuthGuard() : super(priority: -100);

  bool _isAllowed(String? path) {
    if (path == null || path == AppRoutes.login) return true;
    if (!Sint.isRegistered<AuthService>() && !Sint.isPrepared<AuthService>()) {
      return false;
    }
    return Sint.find<AuthService>().isAuthenticated;
  }

  @override
  RouteSettings? redirect(String? route) {
    return _isAllowed(route) ? null : const RouteSettings(name: AppRoutes.login);
  }

  @override
  FutureOr<RouteDecoder?> redirectDelegate(RouteDecoder route) {
    final path = route.pageSettings?.name ?? route.route?.name;
    if (!_isAllowed(path)) {
      return RouteDecoder.fromRoute(AppRoutes.login);
    }
    return route;
  }
}
