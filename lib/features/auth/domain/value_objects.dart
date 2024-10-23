import '../../../shared/shared.dart';
import 'package:either_dart/either.dart';

final class EmailAddress extends ValueObject<String> {
  static final regexRule = RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) => EmailAddress._(_validator(input));

  static Either<ValueFailure<String>, String> _validator(String value) {
    String failure = '';

    if (!regexRule.hasMatch(value)) {
      failure = 'Please enter a valid email address';
    }

    if (value.isEmpty) {
      failure = 'Email address cannot be empty';
    }

    if (failure.isNotEmpty) return Left(ValueFailure(value, failure));
    return Right(value);
  }

  const EmailAddress._(this.value);
}

final class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) => Password._(_validator(input));

  static Either<ValueFailure<String>, String> _validator(String value) {
    String failure = '';

    if (value.isEmpty) {
      failure = 'Password cannot be empty';
    }

    if (failure.isNotEmpty) return Left(ValueFailure(value, failure));
    return Right(value);
  }

  const Password._(this.value);
}
