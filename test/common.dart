import 'package:busha_interview/features/auth/domain/domain.dart';
import 'package:busha_interview/features/transactions/domain/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';

class RiverpodListener<T> extends Mock {
  void call(T? previous, T next);
}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockTransactionRepository extends Mock implements TransactionRepository {}
