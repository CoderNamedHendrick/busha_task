import 'package:patrol_finders/patrol_finders.dart';

abstract base class IRobot {
  final PatrolTester tester;

  const IRobot(this.tester);
}
