import 'package:busha_interview/features/transactions/application/notifiers.dart';
import 'package:busha_interview/features/transactions/application/transactions/view_model.dart';
import 'package:busha_interview/features/transactions/domain/dtos/dtos.dart';
import 'package:busha_interview/features/transactions/domain/repositories/repositories.dart';
import 'package:busha_interview/shared/shared.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../common.dart';

void main() {
  final mockTransactionRepo = MockTransactionRepository();

  group('Transactions view model test suite', () {
    late ProviderContainer container;
    late RiverpodListener<TransactionsUiState> listener;

    setUpAll(() => registerFallbackValue(const TransactionsUiState.initial()));

    setUp(() {
      container = ProviderContainer(overrides: [
        transactionRepositoryProvider
            .overrideWith((ref, _) => mockTransactionRepo)
      ]);
      listener = RiverpodListener();
    });

    tearDown(() => container.dispose());

    test('fetch btc transactions success test', () async {
      when(() => mockTransactionRepo.fetchRecentTransactions())
          .thenAnswer((_) => Future.value(Right(List.generate(
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
              ))));

      expect(
          container.read(transactionsViewModelProvider).uiState, UiState.idle);
      expect(container.read(transactionsViewModelProvider).transactions.isEmpty,
          true);

      container.read(transactionsViewModelProvider.notifier).initialise('BTC');

      container.listen(transactionsViewModelProvider, (prev, next) {
        listener.call(prev, next);
      }, fireImmediately: true);

      final currentState = container.read(transactionsViewModelProvider);
      await container
          .read(transactionsViewModelProvider.notifier)
          .fetchRecentTransactions();

      verifyInOrder([
        () => listener(null, currentState.copyWith(uiState: UiState.idle)),
        () => listener(
            any(that: isA<TransactionsUiState>()),
            any(
                that: isA<TransactionsUiState>().having(
                    (state) => state.uiState,
                    'current state is loading',
                    UiState.loading))),
        () => listener(
            any(that: isA<TransactionsUiState>()),
            any(
              that: isA<TransactionsUiState>()
                  .having((state) => state.uiState, 'current state is success',
                      UiState.success)
                  .having((state) => state.transactions.length,
                      'Confirm the transaction length comes in correctly', 30),
            )),
      ]);
    });

    testWidgets('fetch btc transactions failure test', (tester) async {
      when(() => mockTransactionRepo.fetchRecentTransactions())
          .thenAnswer((_) => Future.value(Left(ServerException.fromJson({
                'message': 'Service Unavailable',
                'error': 'unavailable',
              }))));

      expect(
          container.read(transactionsViewModelProvider).uiState, UiState.idle);
      expect(container.read(transactionsViewModelProvider).transactions.isEmpty,
          true);

      container.read(transactionsViewModelProvider.notifier).initialise('BTC');

      container.listen(transactionsViewModelProvider, (prev, next) {
        listener.call(prev, next);
      }, fireImmediately: true);

      final currentState = container.read(transactionsViewModelProvider);

      await tester.pumpWidget(const UnitTestApp());
      await container
          .read(transactionsViewModelProvider.notifier)
          .fetchRecentTransactions();
      await tester.pumpAndSettle();

      verifyInOrder([
        () => listener(null, currentState.copyWith(uiState: UiState.idle)),
        () => listener(
            any(that: isA<TransactionsUiState>()),
            any(
                that: isA<TransactionsUiState>().having(
                    (state) => state.uiState,
                    'current state is loading',
                    UiState.loading))),
        () => listener(
            any(that: isA<TransactionsUiState>()),
            any(
              that: isA<TransactionsUiState>()
                  .having((state) => state.uiState, 'current state is error',
                      UiState.error)
                  .having((state) => state.exception is ServerException,
                      'error message is correctly server exception', true),
            )),
      ]);
    });

    test('fetch tezos transactions success test', () async {
      when(() => mockTransactionRepo.fetchRecentTransactions())
          .thenAnswer((_) => Future.value(
                Right(
                  List.generate(
                    30,
                    (index) => TransactionDto(
                      hash: 'tezos transaction for $index'.hashCode.toString(),
                      time: DateTime.now().subtract(Duration(days: index)),
                      metadata: {
                        'Level': IntlFormats()
                            .currencyFormat(symbol: '')
                            .format(index),
                        'Reward': index * 2,
                        'Bonus': index * 3,
                        'Fees': index * 2,
                      },
                    ),
                  ),
                ),
              ));

      expect(
          container.read(transactionsViewModelProvider).uiState, UiState.idle);
      expect(container.read(transactionsViewModelProvider).transactions.isEmpty,
          true);

      container.read(transactionsViewModelProvider.notifier).initialise('XTZ');

      container.listen(transactionsViewModelProvider, (prev, next) {
        listener.call(prev, next);
      }, fireImmediately: true);

      final currentState = container.read(transactionsViewModelProvider);
      await container
          .read(transactionsViewModelProvider.notifier)
          .fetchRecentTransactions();

      verifyInOrder([
        () => listener(null, currentState.copyWith(uiState: UiState.idle)),
        () => listener(
            any(that: isA<TransactionsUiState>()),
            any(
                that: isA<TransactionsUiState>().having(
                    (state) => state.uiState,
                    'current state is loading',
                    UiState.loading))),
        () => listener(
            any(that: isA<TransactionsUiState>()),
            any(
              that: isA<TransactionsUiState>()
                  .having((state) => state.uiState, 'current state is success',
                      UiState.success)
                  .having((state) => state.transactions.length,
                      'Confirm the transaction length comes in correctly', 30),
            )),
      ]);
    });

    testWidgets('fetch tezos transactions failure test', (tester) async {
      when(() => mockTransactionRepo.fetchRecentTransactions())
          .thenAnswer((_) => Future.value(Left(ServerException.fromJson({
                'message': 'Service Unavailable',
                'error': 'unavailable',
              }))));

      expect(
          container.read(transactionsViewModelProvider).uiState, UiState.idle);
      expect(container.read(transactionsViewModelProvider).transactions.isEmpty,
          true);

      container.read(transactionsViewModelProvider.notifier).initialise('XTZ');

      container.listen(transactionsViewModelProvider, (prev, next) {
        listener.call(prev, next);
      }, fireImmediately: true);

      final currentState = container.read(transactionsViewModelProvider);

      await tester.pumpWidget(const UnitTestApp());
      await container
          .read(transactionsViewModelProvider.notifier)
          .fetchRecentTransactions();
      await tester.pumpAndSettle();

      verifyInOrder([
        () => listener(null, currentState.copyWith(uiState: UiState.idle)),
        () => listener(
            any(that: isA<TransactionsUiState>()),
            any(
                that: isA<TransactionsUiState>().having(
                    (state) => state.uiState,
                    'current state is loading',
                    UiState.loading))),
        () => listener(
            any(that: isA<TransactionsUiState>()),
            any(
              that: isA<TransactionsUiState>()
                  .having((state) => state.uiState, 'current state is error',
                      UiState.error)
                  .having((state) => state.exception is ServerException,
                      'error message is correctly server exception', true),
            )),
      ]);
    });
  });
}
