import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:survey_flutter_ic/ui/home/home_screen.dart';
import 'package:survey_flutter_ic/ui/home/home_widget_id.dart';

import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  homeScreenTest();
}

void homeScreenTest() {
  group('Home Page', () {
    late Finder profileAvatar;

    setUpAll(() async {
      await TestUtil.setupTestEnvironment();
    });

    setUp(() {
      profileAvatar = find.byKey(HomeWidgetId.profileAvatarImage);
    });

    testWidgets(
        "When the home screen shown, it displays the Home screen correctly",
        (WidgetTester tester) async {
      await tester
          .pumpWidget(TestUtil.pumpWidgetWithShellApp(const HomeScreen()));
      await tester.pumpAndSettle();

      expect(profileAvatar, findsOneWidget);
    });
  });
}
