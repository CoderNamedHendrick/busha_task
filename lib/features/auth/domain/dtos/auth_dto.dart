import 'package:equatable/equatable.dart';

final class AuthDto extends Equatable {
  final String emailAddress;
  final String password;

  const AuthDto({
    required this.emailAddress,
    required this.password,
  });

  factory AuthDto.fromJson(Map<String, dynamic> json) => AuthDto(
        emailAddress: json['emailAddress'] ?? '',
        password: json['password'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'emailAddress': emailAddress,
        'password': password,
      };

  @override
  List<Object?> get props => [emailAddress, password];
}
