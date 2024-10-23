import '../../../shared/shared.dart';
import 'package:equatable/equatable.dart';

import 'domain.dart';

final class AuthEntity extends Equatable {
  final EmailAddress emailAddress;
  final Password password;

  const AuthEntity({
    required this.emailAddress,
    required this.password,
  });

  AuthEntity.empty()
      : this(emailAddress: EmailAddress(''), password: Password(''));

  AuthDto toDto() {
    return AuthDto(
      emailAddress: emailAddress.getOrCrash(),
      password: password.getOrCrash(),
    );
  }

  AuthEntity copyWith({
    EmailAddress? emailAddress,
    Password? password,
  }) {
    return AuthEntity(
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
    );
  }

  Option<ValueFailure> get failureOption => emailAddress.value.fold(
        (value) => Some(value),
        (_) => password.value.fold(
          (value) => Some(value),
          (_) => const None(),
        ),
      );

  @override
  List<Object?> get props => [emailAddress, password];
}
