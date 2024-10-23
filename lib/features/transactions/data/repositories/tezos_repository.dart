// coverage:ignore-file

import '../../../../shared/shared.dart';
import '../../domain/dtos/transaction_dto.dart';
import '../../domain/repositories/repositories.dart';
import '../dtos/tezos_block_info.dart';

final class TezosTransactionRepository implements TransactionRepository {
  TezosTransactionRepository(this._client);

  final BushaNetworkClient _client;

  static const _baseUrl = 'https://api.tzkt.io';

  @override
  FutureBushaExceptionOr<List<TransactionDto>> fetchRecentTransactions() async {
    final latestBlockResponse = await _client.call(
      path: '$_baseUrl/v1/blocks/${DateTime.now().toIso8601String()}',
      method: RequestMethod.get,
    );

    return await processData((p0) {
      final info = TezosBlockInfo.fromJson(p0);
      final transactions =
          info.transactions.map((transaction) => TransactionDto(
                hash: transaction.hash,
                time: DateTime.parse(transaction.timestamp),
                metadata: {
                  'Level': IntlFormats()
                      .currencyFormat(symbol: '')
                      .format(transaction.level),
                  'Reward': info.reward,
                  'Bonus': info.bonus,
                  'Fees': info.fees,
                },
              ));

      return transactions.toList();
    }, latestBlockResponse);
  }
}
