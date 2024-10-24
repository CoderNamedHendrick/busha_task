import 'package:busha_interview/shared/shared.dart';
import 'package:patrol_finders/patrol_finders.dart';

import '../common.dart';

abstract base class IRobot {
  final PatrolTester tester;

  const IRobot(this.tester);

  Future<void> tapBackButton() async {
    await tester(BushaBackButton).tap();
    return await Future.delayed(kActionDelay);
  }
}
