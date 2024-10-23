import 'package:busha_interview/features/auth/domain/domain.dart';
import 'package:busha_interview/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class RiverpodListener<T> extends Mock {
  void call(T? previous, T next);
}

class MockAuthRepository extends Mock implements AuthRepository {}

class UnitTestApp extends StatelessWidget {
  const UnitTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: BushaRouter.routeKey,
      home: ProviderScope(child: Scaffold()),
    );
  }
}
