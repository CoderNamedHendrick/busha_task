import 'package:busha_interview/shared/shared.dart';

import 'i_robot.dart';

final class AuthRobot extends IRobot {
  const AuthRobot(super.tester);

  Future<void> tapContinue() async {
    return await tester('Continue').tap();
  }

  Future<void> tapLogin() async {
    return await tester('Log in').tap();
  }

  Future<void> tapBackButton() async {
    return await tester(BushaBackButton).tap();
  }

  Future<void> tapPasswordVisibilityToggle() async {
    if (tester('SHOW').exists) {
      return await tester('SHOW').tap();
    } else {
      return await tester('HIDE').tap();
    }
  }

  Future<void> enterEmail(String email) async {
    return await tester(EmailTextFormField).enterText(email);
  }

  Future<void> enterPassword(String password) async {
    return await tester(PasswordTextFormField).enterText(password);
  }
}
