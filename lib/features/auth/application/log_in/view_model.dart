import '../../../../shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';

part 'ui_state.dart';

final class LoginViewModel extends AutoDisposeNotifier<LoginUiState> {
  late AuthRepository _authRepository;

  @override
  LoginUiState build() {
    _authRepository = ref.read(authRepositoryProvider);
    return LoginUiState.initial();
  }

  void emailAddressOnChanged(String input) {
    state = state.copyWith(
      loginForm: state.loginForm.copyWith(emailAddress: EmailAddress(input)),
    );
  }

  void passwordOnChanged(String input) {
    state = state.copyWith(
      loginForm: state.loginForm.copyWith(password: Password(input)),
    );
  }

  Future<void> login() async {
    if (state.loginForm.failureOption.isNone()) {
      await launch(state.reference, (model) async {
        state = state.sLoading().emitTo(model);

        final result = await Future.delayed(
          const Duration(seconds: 2),
          () async => await _authRepository.loginUser(state.loginForm.toDto()),
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
