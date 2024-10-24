import 'package:busha_interview/shared/shared.dart';
import 'package:patrol_finders/patrol_finders.dart';

import '../common.dart';
import 'i_robot.dart';

final class AuthRobot extends IRobot {
  const AuthRobot(super.tester);

  Future<void> tapContinue({SettlePolicy? settlePolicy}) async {
    await tester('Continue').tap(settlePolicy: settlePolicy);
    return await Future.delayed(kActionDelay);
  }

  Future<void> tapLogin() async {
    await tester('Log in').tap();
    return await Future.delayed(kActionDelay);
  }

  Future<void> tapPasswordVisibilityToggle() async {
    if (tester(#showPassword).exists) {
      await tester(#showPassword).tap();
    } else {
      await tester(#hidePassword).tap();
    }

    return await Future.delayed(kActionDelay);
  }

  Future<void> enterEmail(String email) async {
    await tester(EmailTextFormField).enterText(email);
    return await Future.delayed(kActionDelay);
  }

  Future<void> enterPassword(String password) async {
    await tester(PasswordTextFormField).enterText(password);
    return await Future.delayed(kActionDelay);
  }
}
