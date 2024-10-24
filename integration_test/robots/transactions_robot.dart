import 'package:busha_interview/features/transactions/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../common.dart';
import 'i_robot.dart';

final class TransactionsRobot extends IRobot {
  TransactionsRobot(super.tester);

  Future<void> tapTransactionTile(int index) async {
    final transactionTiles = tester(TransactionTile).allCandidates;
    if (transactionTiles.isEmpty) {
      throw Exception('No transaction tile found');
    }

    final tile = await tester(Key('transaction$index')).scrollTo();
    await tile.tap();
    return await Future.delayed(kActionDelay);
  }
}
