import 'dart:math';

import 'package:busha_interview/features/explore/explore.dart';
import 'package:busha_interview/features/explore/view/widgets/widgets.dart';
import 'package:busha_interview/features/transactions/transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol_finders/patrol_finders.dart';

import '../common.dart';
import '../robots/robots.dart';

void main() {
  patrolWidgetTest(
    'Explore and transactions scenario test',
    (tester) async {
      final authRobot = AuthRobot(tester);
      final exploreRobot = ExploreRobot(tester);
      final transactionsRobot = TransactionsRobot(tester);

      // background:
      await createApp(tester);
      await authRobot.enterEmail('sebastinesoacatp@gmail.com');
      await authRobot.enterPassword('Sebastine');
      await authRobot.tapContinue();

      // Given:
      expect(await tester(ExploreHomePage).safeExists(), true);

      // When:
      await exploreRobot.tapVisibleIcon();

      // Then:
      expect(tester('****').exists, true);

      // When:
      await exploreRobot.tapMoverTile('Bitcoin');

      // Then:
      expect(tester(AssetDetailPage).exists, true);

      // When:
      await exploreRobot.tapBackButton();
      await exploreRobot.scrollToWidget(tester(NewsTile));
      await exploreRobot.tapNewsTile();

      // Then:
      expect(tester(NewsDetailPage).exists, true);

      // When:
      await exploreRobot.tapBackButton();
      await exploreRobot.scrollToWidget(tester(AssetTile),
          scrollDirection: AxisDirection.up);
      await exploreRobot.tapMyAssetTile('Bitcoin');

      // Then:
      expect(await tester(TransactionsHomePage).safeExists(), true);

      // When:
      await transactionsRobot.tapTransactionTile(Random().nextInt(20));

      // Then:
      expect(await tester(TransactionDetailPage).safeExists(), true);

      // When:
      await transactionsRobot.tapBackButton();
      await transactionsRobot.tapBackButton();

      // Then:
      expect(tester(ExploreHomePage).exists, true);

      // When:
      await exploreRobot.tapMyAssetTile('Tezos');

      // Then:
      expect(await tester(TransactionsHomePage).safeExists(), true);

      // When:
      await transactionsRobot.tapTransactionTile(Random().nextInt(20));

      // Then:
      expect(await tester(TransactionDetailPage).safeExists(), true);

      // When:
      await transactionsRobot.tapBackButton();
      await transactionsRobot.tapBackButton();

      // Then:
      expect(tester(ExploreHomePage).exists, true);
    },
  );
}
