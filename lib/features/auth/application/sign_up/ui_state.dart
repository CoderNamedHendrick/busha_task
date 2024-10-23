part of 'view_model.dart';

final class SignUpUiState extends BushaFormUiState<SignUpUiState> {
  final AuthEntity signUpForm;

  const SignUpUiState({
    super.uiState,
    super.exception,
    super.showFormErrors,
    required this.signUpForm,
  });

  SignUpUiState.initial() : this(signUpForm: AuthEntity.empty());

  @override
  SignUpUiState copyWith({
    UiState? uiState,
    BushaException? exception,
    bool? showFormErrors,
    AuthEntity? signUpForm,
  }) {
    return SignUpUiState(
      uiState: uiState ?? this.uiState,
      exception: exception ?? this.exception,
      showFormErrors: showFormErrors ?? this.showFormErrors,
      signUpForm: signUpForm ?? this.signUpForm,
    );
  }

  @override
  List<Object?> get otherProps => [signUpForm];
}
