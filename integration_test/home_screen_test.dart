import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:survey_flutter_ic/navigation/app_router.dart';
import 'package:survey_flutter_ic/ui/home/home_widget_id.dart';

import 'fake_data/fake_data.dart';
import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  homeScreenTest();
}

void homeScreenTest() {
  group('Home Page', () {
    late Finder profileAvatarImage;
    late Finder headerTodayText;
    late Finder surveysPagerIndicator;
    late Finder surveyBackgroundImage;
    late Finder surveyTitleText;
    late Finder surveyDescriptionText;
    late Finder surveyDetailsButton;

    setUpAll(() async {
      await TestUtil.setupTestEnvironment();
    });

    setUp(() {
      profileAvatarImage = find.byKey(HomeWidgetId.profileAvatarImage);
      headerTodayText = find.byKey(HomeWidgetId.headerTodayText);
      surveysPagerIndicator = find.byKey(HomeWidgetId.surveysPagerIndicator);
      surveyBackgroundImage = find.byKey(HomeWidgetId.surveyBackgroundImage);
      surveyTitleText = find.byKey(HomeWidgetId.surveyTitleText);
      surveyDescriptionText = find.byKey(HomeWidgetId.surveyDescriptionText);
      surveyDetailsButton = find.byKey(HomeWidgetId.surveyDetailsButton);
    });

    testWidgets(
        "When the home screen shown, it displays the Home screen correctly",
        (WidgetTester tester) async {
          await FakeData.initDefault();
      await tester
          .pumpWidget(TestUtil.pumpWidgetWithRoutePath(RoutePath.home.path));
      await tester.pumpAndSettle();

      expect(profileAvatarImage, findsOneWidget);
      expect(headerTodayText, findsOneWidget);
      expect(surveysPagerIndicator, findsOneWidget);
      expect(surveyBackgroundImage, findsOneWidget);
      expect(surveyTitleText, findsOneWidget);
      expect(surveyDescriptionText, findsOneWidget);
      expect(surveyDetailsButton, findsOneWidget);
    });
  });
}
