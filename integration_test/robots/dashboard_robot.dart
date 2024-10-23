import 'i_robot.dart';

final class DashboardRobot extends IRobot {
  const DashboardRobot(super.tester);

  Future<void> tapBottomNavItem(BottomNavItem option) async {
    return await tester(option.label).tap();
  }
}

enum BottomNavItem {
  explore('Explore'),
  portfolio('Portfolio'),
  earn('Earn'),
  spend('Spend'),
  connect('Connect');

  const BottomNavItem(this.label);

  final String label;
}
