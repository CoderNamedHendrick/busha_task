import '../features/auth/auth.dart';
import 'package:flutter/material.dart';

import '../features/dashboard/dashboard.dart';
import '../features/transactions/domain/dtos/dtos.dart';
import '../features/transactions/transactions.dart';

class BushaRouter {
  const BushaRouter._();

  static const instance = BushaRouter._();

  static final routeKey = GlobalKey<NavigatorState>();

  static const initialRoute = '/auth/login';

  Route<dynamic> routeGenerator(RouteSettings settings) {
    return switch (settings.name) {
      LoginPage.route =>
        MaterialPageRoute(builder: (context) => const LoginPage()),
      SignUpPage.route => MaterialPageRoute(builder: (_) => const SignUpPage()),
      DashboardPage.route =>
        MaterialPageRoute(builder: (_) => const DashboardPage()),
      TransactionsHomePage.route => MaterialPageRoute(
          builder: (_) => switch (settings.arguments) {
            String shortName => TransactionsHomePage(shortName: shortName),
            _ => throw ArgumentError(
                'Invalid arguments for ${settings.name} route'),
          },
        ),
      TransactionDetailPage.route => MaterialPageRoute(
          builder: (_) => switch (settings.arguments) {
            TransactionDto transaction =>
              TransactionDetailPage(transaction: transaction),
            _ => throw ArgumentError(
                'Invalid arguments for ${settings.name} route'),
          },
        ),
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
