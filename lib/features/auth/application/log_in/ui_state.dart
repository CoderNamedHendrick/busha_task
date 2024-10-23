part of 'view_model.dart';

final class LoginUiState extends BushaFormUiState<LoginUiState> {
  final AuthEntity loginForm;

  const LoginUiState({
    super.uiState,
    super.exception,
    super.showFormErrors,
    required this.loginForm,
  });

  LoginUiState.initial() : this(loginForm: AuthEntity.empty());

  @override
  LoginUiState copyWith({
    UiState? uiState,
    BushaException? exception,
    bool? showFormErrors,
    AuthEntity? loginForm,
  }) {
    return LoginUiState(
      uiState: uiState ?? this.uiState,
      exception: exception ?? this.exception,
      showFormErrors: showFormErrors ?? this.showFormErrors,
      loginForm: loginForm ?? this.loginForm,
    );
  }

  @override
  List<Object?> get props => [loginForm];
}
