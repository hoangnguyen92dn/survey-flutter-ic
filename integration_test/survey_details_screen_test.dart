import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  surveyDetailsScreenTest();
}

void surveyDetailsScreenTest() {
  group('Survey Details Page', () {
    // late Finder backButton;
    // late Finder surveyBackgroundImage;
    // late Finder surveyTitleText;
    // late Finder surveyDescriptionText;
    // late Finder startSurveyButton;

    setUpAll(() async {
      await TestUtil.setupTestEnvironment();
    });

    setUp(() {
      // backButton = find.byKey(SurveyDetailsWidgetId.backButton);
      // surveyBackgroundImage =
      //     find.byKey(SurveyDetailsWidgetId.surveyBackgroundImage);
      // surveyTitleText = find.byKey(SurveyDetailsWidgetId.surveyTitleText);
      // surveyDescriptionText =
      //     find.byKey(SurveyDetailsWidgetId.surveyDescriptionText);
      // startSurveyButton = find.byKey(SurveyDetailsWidgetId.startSurveyButton);
    });

    // TODO: Skip this test due to unable to pass the :extra with go_router
    // testWidgets(
    //     "When the survey details screen shown, it displays the survey details screen correctly",
    //     (WidgetTester tester) async {
    //   await FakeData.initDefault();
    //   await tester
    //       .pumpWidget(TestUtil.pumpWidgetWithRoutePath(RoutePath.details.path));
    //   await tester.pumpAndSettle();
    //
    //   expect(backButton, findsOneWidget);
    //   expect(surveyBackgroundImage, findsOneWidget);
    //   expect(surveyTitleText, findsOneWidget);
    //   expect(surveyDescriptionText, findsOneWidget);
    //   expect(startSurveyButton, findsOneWidget);
    // });
  });
}
