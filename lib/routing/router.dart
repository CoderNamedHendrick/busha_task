import '../features/auth/auth.dart';
import 'package:flutter/material.dart';

import '../features/dashboard/dashboard.dart';

class BushaRouter {
  const BushaRouter._();

  static const instance = BushaRouter._();

  static final routeKey = GlobalKey<NavigatorState>();

  static const initialRoute = '/auth/login';

  // static final transactions = '/transactions';
  // static final transactionDetails = '/transactions-details';

  Route<dynamic> routeGenerator(RouteSettings settings) {
    return switch (settings.name) {
      LoginPage.route => MaterialPageRoute(builder: (context) => const LoginPage()),
      SignUpPage.route => MaterialPageRoute(builder: (_) => const SignUpPage()),
      DashboardPage.route => MaterialPageRoute(builder: (_) => const DashboardPage()),
      _ => MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('404: Page not found for ${settings.name} route'),
            ),
          ),
        ),
    };
  }
}

extension RouterX on BuildContext {
  Future<dynamic> pushNamed(String route, {Object? arguments}) =>
      Navigator.of(this).pushNamed(route, arguments: arguments);
}
