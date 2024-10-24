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
    await robot.tapContinue();

    // Then:
    expect(tester('Email address cannot be empty').exists, true);
    expect(tester('Password cannot be empty').exists, true);

    // When:
    await robot.tapBackButton();

    // Then:
    expect(tester(SignUpPage).exists, true);

    // When:
    await robot.enterEmail('sebastinesoacatp@gmail.com');
    await robot.enterPassword('Sebastine');
    await robot.tapPasswordVisibilityToggle();
    await robot.tapContinue();

    // Then:
    expect(tester(LoginPage).exists, true);

    // When:
    await robot.enterEmail('sebastinesoacatp1@gmail.com');
    await robot.enterPassword('Sebastine');
    await robot.tapContinue(settlePolicy: SettlePolicy.noSettle);

    // Then:
    expect(
      await tester('User not found').safeExists(const Duration(seconds: 5)),
      true,
    );
    await tester.pumpAndSettle();

    // When:
    await robot.enterEmail('sebastinesoacatp@gmail.com');
    await robot.enterPassword('Sebastine');
    await robot.tapContinue();

    // Then:
    expect(await tester(DashboardPage).safeExists(), true);
  });
}
