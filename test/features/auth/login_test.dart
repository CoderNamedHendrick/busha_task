import 'package:busha_interview/features/auth/application/log_in/view_model.dart';
import 'package:busha_interview/features/auth/application/notifiers.dart';
import 'package:busha_interview/features/auth/domain/domain.dart';
import 'package:busha_interview/shared/shared.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../common.dart';

void main() {
  final mockAuthRepo = MockAuthRepository();
  group('Log in view model test suite', () {
    late ProviderContainer container;
    late RiverpodListener<LoginUiState> listener;

    setUpAll(() => registerFallbackValue(LoginUiState.initial()));

    setUp(() {
      container = ProviderContainer(
          overrides: [authRepositoryProvider.overrideWithValue(mockAuthRepo)]);
      listener = RiverpodListener();
    });

    tearDown(() => container.dispose());

    test('log in success test', () async {
      when(() => mockAuthRepo.loginUser(const AuthDto(
              emailAddress: 'johndoe@gmail.com', password: 'BushaTestTest')))
          .thenAnswer((_) => Future.value(const Right('Login successful')));

      expect(container.read(loginViewModelProvider).uiState, UiState.idle);
      expect(
          container
              .read(loginViewModelProvider)
              .loginForm
              .failureOption
              .isNone(),
          false,
          reason: 'Login form has invalid values');

      container
          .read(loginViewModelProvider.notifier)
          .emailAddressOnChanged('johndoe@gmail.com');
      await container.read(loginViewModelProvider.notifier).login();

      container
          .read(loginViewModelProvider.notifier)
          .passwordOnChanged('BushaTestTest');

      expect(container.read(loginViewModelProvider).showFormErrors, true,
          reason: 'Login form has invalid so show form errors is true');

      container.listen(loginViewModelProvider, listener.call,
          fireImmediately: true);

      final currentState = container.read(loginViewModelProvider);
      await container.read(loginViewModelProvider.notifier).login();

      verifyInOrder([
        () => listener(null, currentState.copyWith(uiState: UiState.idle)),
        () => listener(
            any(that: isA<LoginUiState>()),
            any(
                that: isA<LoginUiState>().having((state) => state.uiState,
                    'current state is loading', UiState.loading))),
        () => listener(
            any(that: isA<LoginUiState>()),
            any(
                that: isA<LoginUiState>().having((state) => state.uiState,
                    'current state is success', UiState.success))),
      ]);

      expect(container.read(loginViewModelProvider).uiState, UiState.idle);
    });

    test('log in failure test', () async {
      when(() => mockAuthRepo.loginUser(
          const AuthDto(
              emailAddress: 'johndoe@gmail.com',
              password: 'BushaTestTest'))).thenAnswer(
          (_) => Future.value(const Left(MessageException('User not found'))));

      expect(container.read(loginViewModelProvider).uiState, UiState.idle);
      expect(
          container
              .read(loginViewModelProvider)
              .loginForm
              .failureOption
              .isNone(),
          false,
          reason: 'Login form has invalid values');

      container
          .read(loginViewModelProvider.notifier)
          .emailAddressOnChanged('johndoe@gmail.com');
      await container.read(loginViewModelProvider.notifier).login();

      container
          .read(loginViewModelProvider.notifier)
          .passwordOnChanged('BushaTestTest');

      expect(container.read(loginViewModelProvider).showFormErrors, true,
          reason: 'Login form has invalid so show form errors is true');

      container.listen(loginViewModelProvider, listener.call,
          fireImmediately: true);

      final currentState = container.read(loginViewModelProvider);
      await container.read(loginViewModelProvider.notifier).login();

      verifyInOrder([
        () => listener(null, currentState.copyWith(uiState: UiState.idle)),
        () => listener(
            any(that: isA<LoginUiState>()),
            any(
                that: isA<LoginUiState>().having((state) => state.uiState,
                    'current state is loading', UiState.loading))),
        () => listener(
            any(that: isA<LoginUiState>()),
            any(
                that: isA<LoginUiState>()
                    .having((state) => state.uiState, 'current state is error',
                        UiState.error)
                    .having((state) => state.exception is MessageException,
                        'error message is correctly message exception', true)
                    .having(
                        (state) => state.exception.toString(),
                        'ensure the error message is correct',
                        'User not found'))),
      ]);

      expect(container.read(loginViewModelProvider).uiState, UiState.idle);
    });
  });
}
