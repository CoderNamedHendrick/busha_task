import 'package:busha_interview/features/connect/connect.dart';
import 'package:busha_interview/features/dashboard/dashboard.dart';
import 'package:busha_interview/features/earn/earn.dart';
import 'package:busha_interview/features/explore/explore.dart';
import 'package:busha_interview/features/portfolio/portfolio.dart';
import 'package:busha_interview/features/spend/spend.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol_finders/patrol_finders.dart';

import '../common.dart';
import '../robots/robots.dart';

void main() {
  patrolWidgetTest('Dashboard scenario test', (tester) async {
    final authRobot = AuthRobot(tester);
    final robot = DashboardRobot(tester);
    // background:
    await createApp(tester);
    await authRobot.enterEmail('sebastinesoacatp@gmail.com');
    await authRobot.enterPassword('Sebastine');
    await authRobot.tapContinue();

    // Given:
    expect(await tester(DashboardPage).safeExists(), true);

    // When:
    await robot.tapBottomNavItem(BottomNavItem.portfolio);

    // Then:
    expect(tester(PortfolioHomePage).exists, true);

    // When:
    await robot.tapBottomNavItem(BottomNavItem.earn);

    // Then:
    expect(tester(EarnHomePage).exists, true);

    // When:
    await robot.tapBottomNavItem(BottomNavItem.spend);

    // Then:
    expect(tester(SpendHomePage).exists, true);

    // When:
    await robot.tapBottomNavItem(BottomNavItem.connect);

    // Then:
    expect(tester(ConnectHomePage).exists, true);

    // When:
    await robot.tapBottomNavItem(BottomNavItem.explore);

    // Then:
    expect(tester(ExploreHomePage).exists, true);
  });
}
