import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'log_in/view_model.dart';
import 'sign_up/view_model.dart';

final loginViewModelProvider =
    AutoDisposeNotifierProvider<LoginViewModel, LoginUiState>(
  () => LoginViewModel(),
);

final signupViewModelProvider =
    AutoDisposeNotifierProvider<SignUpViewModel, SignUpUiState>(
  () => SignUpViewModel(),
);
