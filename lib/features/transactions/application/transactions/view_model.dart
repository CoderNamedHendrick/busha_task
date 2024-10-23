import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/shared.dart';
import '../../domain/dtos/dtos.dart';
import '../../domain/repositories/repositories.dart';

part 'ui_state.dart';

final class TransactionsViewModel
    extends AutoDisposeNotifier<TransactionsUiState> {
  late TransactionRepository _transactionRepository;

  @override
  TransactionsUiState build() {
    return const TransactionsUiState.initial();
  }

  void initialise(String assetShortName) {
    _transactionRepository =
        ref.read(transactionRepositoryProvider(assetShortName));
  }

  Future<void> fetchRecentTransactions() async {
    await launch(state.reference, (model) async {
      state = state.sLoading().emitTo(model);
      final result = await _transactionRepository.fetchRecentTransactions();

      state = result
          .fold(state.sError,
              (right) => state.sSuccess().copyWith(transactions: right))
          .emitTo(model);
    }, displayError: false);
  }
}
