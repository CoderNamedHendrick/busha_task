part of 'view_model.dart';

final class TransactionsUiState extends BushaUiState<TransactionsUiState> {
  final List<TransactionDto> transactions;

  const TransactionsUiState({
    super.uiState,
    super.exception,
    required this.transactions,
  });

  const TransactionsUiState.initial() : this(transactions: const []);

  @override
  TransactionsUiState copyWith({
    UiState? uiState,
    BushaException? exception,
    List<TransactionDto>? transactions,
  }) {
    return TransactionsUiState(
      uiState: uiState ?? this.uiState,
      exception: exception ?? this.exception,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get otherProps => [transactions];
}
