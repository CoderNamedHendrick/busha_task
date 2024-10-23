import 'package:busha_interview/features/auth/auth.dart';
import 'package:busha_interview/features/dashboard/dashboard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol_finders/patrol_finders.dart';

import '../common.dart';
import '../robots/auth_robot.dart';

void main() {
  patrolWidgetTest('User signs up and logs in scenario', (tester) async {
    final robot = AuthRobot(tester);
    await createApp(tester);

    // Given:
    expect(await tester(LoginPage).safeExists(), true);

    // When:
    await robot.tapBackButton();

    // Then:
    expect(tester(SignUpPage).exists, true);

    // When:
    await robot.enterEmail('sebastinesoacatp@gmail.com');
    await robot.enterPassword('Sebastine');
    await robot.tapContinue();

    // Then:
    expect(tester(LoginPage).exists, true);

    // When:
    await robot.enterEmail('sebastinesoacatp@gmail.com');
    await robot.enterPassword('Sebastine');
    await robot.tapContinue();

    // Then:
    expect(await tester(DashboardPage).safeExists(), true);
  });
}
