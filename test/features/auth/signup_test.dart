import 'package:busha_interview/features/auth/application/notifiers.dart';
import 'package:busha_interview/features/auth/application/sign_up/view_model.dart';
import 'package:busha_interview/features/auth/domain/domain.dart';
import 'package:busha_interview/shared/shared.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../common.dart';

void main() {
  final mockAuthRepo = MockAuthRepository();

  group('Sign up view model test suite', () {
    late ProviderContainer container;
    late RiverpodListener<SignUpUiState> listener;

    setUpAll(() => registerFallbackValue(SignUpUiState.initial()));

    setUp(() {
      container = ProviderContainer(
          overrides: [authRepositoryProvider.overrideWithValue(mockAuthRepo)]);
      listener = RiverpodListener();
    });

    tearDown(() => container.dispose());

    test('Sign up success test', () async {
      when(() => mockAuthRepo.signupUser(const AuthDto(
              emailAddress: 'johndoe@gmail.com', password: 'BushaTestTest')))
          .thenAnswer((_) => Future.value(const Right('Login successful')));

      expect(container.read(signupViewModelProvider).uiState, UiState.idle);
      expect(
          container
              .read(signupViewModelProvider)
              .signUpForm
              .failureOption
              .isNone(),
          false,
          reason: 'Sign up form has invalid values');

      container
          .read(signupViewModelProvider.notifier)
          .emailAddressOnChanged('johndoe@gmail.com');
      await container.read(signupViewModelProvider.notifier).signup();

      container
          .read(signupViewModelProvider.notifier)
          .passwordOnChanged('BushaTestTest');

      expect(container.read(signupViewModelProvider).showFormErrors, true,
          reason: 'Sign up form has invalid so show form errors is true');

      container.listen(signupViewModelProvider, listener.call,
          fireImmediately: true);

      final currentState = container.read(signupViewModelProvider);
      await container.read(signupViewModelProvider.notifier).signup();

      verifyInOrder([
        () => listener(null, currentState.copyWith(uiState: UiState.idle)),
        () => listener(
            any(that: isA<SignUpUiState>()),
            any(
                that: isA<SignUpUiState>().having((state) => state.uiState,
                    'current state is loading', UiState.loading))),
        () => listener(
            any(that: isA<SignUpUiState>()),
            any(
                that: isA<SignUpUiState>().having((state) => state.uiState,
                    'current state is success', UiState.success))),
      ]);

      expect(currentState.uiState, UiState.idle, reason: 'reset state');
    });

    testWidgets('sign up failure test', (tester) async {
      when(() => mockAuthRepo.signupUser(
          const AuthDto(
              emailAddress: 'johndoe@gmail.com',
              password: 'BushaTestTest'))).thenAnswer(
          (_) => Future.value(const Left(MessageException('User already exists'))));

      expect(container.read(signupViewModelProvider).uiState, UiState.idle);
      expect(
          container
              .read(signupViewModelProvider)
              .signUpForm
              .failureOption
              .isNone(),
          false,
          reason: 'Sign up form has invalid values');

      container
          .read(signupViewModelProvider.notifier)
          .emailAddressOnChanged('johndoe@gmail.com');
      await container.read(signupViewModelProvider.notifier).signup();

      container
          .read(signupViewModelProvider.notifier)
          .passwordOnChanged('BushaTestTest');

      expect(container.read(signupViewModelProvider).showFormErrors, true,
          reason: 'Sign up form has invalid so show form errors is true');

      container.listen(signupViewModelProvider, listener.call,
          fireImmediately: true);

      final currentState = container.read(signupViewModelProvider);

      await tester.pumpWidget(const UnitTestApp());
      await container.read(signupViewModelProvider.notifier).signup();
      await tester.pumpAndSettle();

      verifyInOrder([
        () => listener(null, currentState.copyWith(uiState: UiState.idle)),
        () => listener(
            any(that: isA<SignUpUiState>()),
            any(
                that: isA<SignUpUiState>().having((state) => state.uiState,
                    'current state is loading', UiState.loading))),
        () => listener(
            any(that: isA<SignUpUiState>()),
            any(
                that: isA<SignUpUiState>()
                    .having((state) => state.uiState, 'current state is error',
                        UiState.error)
                    .having((state) => state.exception is MessageException,
                        'error message is correctly message exception', true)
                    .having(
                        (state) => state.exception.toString(),
                        'ensure the error message is correct',
                        'User already exists'))),
      ]);
    });
  });
}
