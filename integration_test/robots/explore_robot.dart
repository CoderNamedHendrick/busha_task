import 'package:busha_interview/features/explore/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../common.dart';
import 'i_robot.dart';

final class ExploreRobot extends IRobot {
  ExploreRobot(super.tester);

  Future<void> scrollToWidget(Finder finder,
      {AxisDirection scrollDirection = AxisDirection.down}) async {
    await tester(finder).scrollTo(scrollDirection: scrollDirection);
  }

  Future<void> tapMyAssetTile(String assetName) async {
    await tester(AssetTile)
        .which<AssetTile>((tile) => tile.name == assetName)
        .tap();
    return await Future.delayed(kActionDelay);
  }

  Future<void> tapVisibleIcon() async {
    if (tester(#visible).exists) {
      await tester(#visible).tap();
    } else {
      await tester(#hidden).tap();
    }

    return await Future.delayed(kActionDelay);
  }

  Future<void> tapMoverTile(String assetName) async {
    await tester(MoverTile)
        .which<MoverTile>((tile) => tile.name == assetName)
        .tap();
    return await Future.delayed(kActionDelay);
  }

  Future<void> tapNewsTile() async {
    await tester(NewsTile).tap();
    return await Future.delayed(kActionDelay);
  }
}
