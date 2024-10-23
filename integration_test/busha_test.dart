import 'package:flutter_test/flutter_test.dart';

import 'scenarios/authentication_test.dart' as auth_test;
import 'scenarios/dashboard_test.dart' as dashboard_test;

void main() {
  group('Busha Scenarios', () {
    auth_test.main();
    dashboard_test.main();
  });
}
