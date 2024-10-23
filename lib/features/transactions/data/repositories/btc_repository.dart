// coverage:ignore-file

import 'package:either_dart/either.dart';
import '../../../../shared/shared.dart';
import '../../domain/dtos/transaction_dto.dart';
import '../../domain/repositories/repositories.dart';
import '../dtos/bitcoin_block_info.dart';

final class BtcTransactionRepository implements TransactionRepository {
  BtcTransactionRepository(this._client);

  final BushaNetworkClient _client;

  static const _baseUrl = 'https://blockchain.info';

  @override
  FutureBushaExceptionOr<List<TransactionDto>> fetchRecentTransactions() async {
    final latestBlockResponse = await _client.call(
      path: '$_baseUrl/latestblock',
      method: RequestMethod.get,
    );

    final latestBlockResult = await processData(
        (p0) => LatestBlockInfo.fromJson(p0), latestBlockResponse);
    if (latestBlockResult.isLeft) return Left(latestBlockResult.left);

    final rawLatestBlock = await _client.call(
      path: '$_baseUrl/rawblock/${latestBlockResult.right.hash}',
      method: RequestMethod.get,
    );

    return await processData((p0) {
      final info = BitcoinBlockInfo.fromJson(p0);
      final transactions = info.tx.map((transaction) => TransactionDto(
            hash: transaction.hash,
            time: DateTime.fromMillisecondsSinceEpoch(transaction.time),
            metadata: {
              'Size': transaction.size,
              'Block index': transaction.blockIndex,
              'Height': transaction.blockHeight,
              'Received time': IntlFormats().transactionDateFormat.format(
                  DateTime.fromMillisecondsSinceEpoch(transaction.lockTime)),
            },
          ));

      return transactions.toList();
    }, rawLatestBlock);
  }
}
