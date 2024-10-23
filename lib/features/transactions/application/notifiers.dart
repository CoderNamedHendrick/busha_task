import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'transactions/view_model.dart';

final transactionsViewModelProvider =
    AutoDisposeNotifierProvider<TransactionsViewModel, TransactionsUiState>(
  () => TransactionsViewModel(),
);
