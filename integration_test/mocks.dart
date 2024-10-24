import 'package:busha_interview/features/auth/domain/domain.dart';
import 'package:busha_interview/features/transactions/domain/dtos/dtos.dart';
import 'package:busha_interview/features/transactions/domain/repositories/repositories.dart';
import 'package:busha_interview/shared/shared.dart';
import 'package:either_dart/either.dart';
import 'package:mocktail/mocktail.dart';

const _kSimulateDelay = Duration(seconds: 2);

class MockAuthRepository extends Mock implements AuthRepository {
  @override
  FutureBushaExceptionOr<String> loginUser(AuthDto dto) async {
    await Future.delayed(_kSimulateDelay);
    if (dto.emailAddress == 'sebastinesoacatp@gmail.com' &&
        dto.password == 'Sebastine') {
      return const Right('Login successful');
    }

    return const Left(MessageException('User not found'));
  }

  @override
  FutureBushaExceptionOr<String> signupUser(AuthDto dto) async {
    await Future.delayed(_kSimulateDelay);
    if (dto.emailAddress == 'sebastinehendrick@gmail.com') {
      return const Left(MessageException('User already exists'));
    }

    return const Right('Signup successful');
  }
}

class MockBTCTransactionRepository extends Mock
    implements TransactionRepository {
  @override
  FutureBushaExceptionOr<List<TransactionDto>> fetchRecentTransactions() async {
    await Future.delayed(_kSimulateDelay);

    return Right(
      List.generate(
        30,
        (index) => TransactionDto(
          hash: 'btc transaction for $index'.hashCode.toString(),
          time: DateTime.now().subtract(Duration(days: index)),
          metadata: {
            'Size': index * 10,
            'Block index': index,
            'Height': index * 2,
            'Received time': IntlFormats().transactionDateFormat.format(
                  DateTime.now().subtract(Duration(days: index)),
                ),
          },
        ),
      ),
    );
  }
}

class MockTezosTransactionRepository extends Mock
    implements TransactionRepository {
  @override
  FutureBushaExceptionOr<List<TransactionDto>> fetchRecentTransactions() async {
    await Future.delayed(_kSimulateDelay);

    return Right(
      List.generate(
        30,
        (index) => TransactionDto(
          hash: 'tezos transaction for $index'.hashCode.toString(),
          time: DateTime.now().subtract(Duration(days: index)),
          metadata: {
            'Level': IntlFormats().currencyFormat(symbol: '').format(index),
            'Reward': index * 2,
            'Bonus': index * 3,
            'Fees': index * 2,
          },
        ),
      ),
    );
  }
}
