import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/shared.dart';
import '../../domain/domain.dart';

part 'ui_state.dart';

final class SignUpViewModel extends AutoDisposeNotifier<SignUpUiState> {
  late AuthRepository _authRepository;

  @override
  SignUpUiState build() {
    _authRepository = ref.read(authRepositoryProvider);
    return SignUpUiState.initial();
  }

  void emailAddressOnChanged(String input) {
    state = state.copyWith(
      signUpForm: state.signUpForm.copyWith(emailAddress: EmailAddress(input)),
    );
  }

  void passwordOnChanged(String input) {
    state = state.copyWith(
      signUpForm: state.signUpForm.copyWith(password: Password(input)),
    );
  }

  Future<void> signup() async {
    if (state.signUpForm.failureOption.isNone()) {
      await launch(state.reference, (model) async {
        state = state.sLoading().emitTo(model);
        final result = await Future.delayed(
          const Duration(seconds: 2),
          () async =>
              await _authRepository.signupUser(state.signUpForm.toDto()),
        );

        state = result
            .fold(state.sError, (right) => state.sSuccess())
            .emitTo(model);
      });

      state = state.reset();
      return;
    }

    state = state.toggleFormErrors();
  }
}
