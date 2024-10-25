import 'package:busha_interview/busha_app.dart';
import 'package:busha_interview/features/auth/domain/domain.dart';
import 'package:busha_interview/features/transactions/domain/repositories/repositories.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patrol_finders/patrol_finders.dart';

import 'mocks.dart';

const waitTime = Duration(milliseconds: 700);
const kActionDelay = Duration(milliseconds: 800);

Future<void> createApp(PatrolTester tester) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (defaultTargetPlatform == TargetPlatform.android) {
    const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );

  await tester.pumpWidgetAndSettle(ProviderScope(
    overrides: [
      authRepositoryProvider.overrideWithValue(MockAuthRepository()),
      transactionRepositoryProvider('BTC')
          .overrideWithValue(MockBTCTransactionRepository()),
      transactionRepositoryProvider('XTZ')
          .overrideWithValue(MockBTCTransactionRepository()),
    ],
    child: const BushaApp(),
  ));
}

extension PatrolFinderX on PatrolFinder {
  Future<bool> safeExists(
      [Duration timeout = const Duration(seconds: 3)]) async {
    try {
      await waitUntilExists(timeout: timeout);
      return true;
    } on WaitUntilExistsTimeoutException catch (_) {
      return false;
    }
  }
}

extension PatrolTesterX on PatrolTester {
  /// run the loading animation while counteracting the countdown animation
  /// pumpAndSettle timeout issue
  Future<void> progressAnimationSafely([int cycles = 10]) async {
    for (int i = 0; i < cycles; i++) {
      await pump(waitTime);
    }
  }
}
