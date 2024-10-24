// ignore: depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';
import '../../../shared/network/data_transformer.dart';
import '../data/auth_repository.dart';
import 'domain.dart';

abstract interface class AuthRepository {
  const AuthRepository();

  FutureBushaExceptionOr<String> loginUser(AuthDto dto);

  FutureBushaExceptionOr<String> signupUser(AuthDto dto);
}

final authRepositoryProvider = Provider.autoDispose<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});
