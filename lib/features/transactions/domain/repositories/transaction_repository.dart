// ignore: depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';
import '../../../../shared/shared.dart';
import '../../data/repositories/repositories.dart';
import '../dtos/dtos.dart';

abstract interface class TransactionRepository {
  FutureBushaExceptionOr<List<TransactionDto>> fetchRecentTransactions();
}

final transactionRepositoryProvider = Provider.autoDispose
    .family<TransactionRepository, String>((ref, assetShortName) {
  return switch (assetShortName) {
    'BTC' => BtcTransactionRepository(ref.read(bushaNetworkClientProvider)),
    'XTZ' => TezosTransactionRepository(ref.read(bushaNetworkClientProvider)),
    _ => throw UnimplementedError('Asset $assetShortName not supported'),
  };
});
