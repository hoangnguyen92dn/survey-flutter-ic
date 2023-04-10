import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:survey_flutter_ic/ui/details/survey_details_widget_id.dart';
import 'package:survey_flutter_ic/ui/surveys/survey_ui_model.dart';
import 'package:survey_flutter_ic/widget/flat_button_text.dart';

import 'fake_data/fake_data.dart';
import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  surveyDetailsScreenTest();
}

void surveyDetailsScreenTest() {
  group('Survey Details Page', () {
    const survey = SurveyUiModel(
        id: 'id',
        title: 'Fake Survey Title',
        description: 'Fake Survey Description',
        isActive: true,
        coverImageUrl: 'https://example.com/fake-image.png',
        largeCoverImageUrl: 'https://example.com/fake-image.pngl',
        createdAt: 'createdAt',
        surveyType: 'surveyType');

    late Finder backButton;
    late Finder surveyBackgroundContainer;
    late Finder surveyTitleText;
    late Finder surveyDescriptionText;
    late Finder startSurveyButton;

    setUpAll(() async {
      await TestUtil.setupTestEnvironment();
    });

    setUp(() {
      backButton = find.byKey(SurveyDetailsWidgetId.backButton);
      surveyBackgroundContainer =
          find.byKey(SurveyDetailsWidgetId.surveyBackgroundContainer);
      surveyTitleText = find.byKey(SurveyDetailsWidgetId.surveyTitleText);
      surveyDescriptionText =
          find.byKey(SurveyDetailsWidgetId.surveyDescriptionText);
      startSurveyButton = find.byKey(SurveyDetailsWidgetId.startSurveyButton);
    });

    testWidgets(
        "When the survey details screen shown, it displays the survey details screen correctly",
        (WidgetTester tester) async {
      await FakeData.initDefault();
      await tester.pumpWidget(
          TestUtil.pumpWidgetWithRoutePath('/home/details', extra: survey));
      await tester.pumpAndSettle();

      expect(backButton, findsOneWidget);
      expect(surveyBackgroundContainer, findsOneWidget);
      expect(surveyTitleText, findsOneWidget);
      expect(surveyDescriptionText, findsOneWidget);
      expect(startSurveyButton, findsOneWidget);
    });

    testWidgets(
        "When the survey details screen shown, it binds the Survey correctly",
        (WidgetTester tester) async {
      await FakeData.initDefault();
      await tester.pumpWidget(
          TestUtil.pumpWidgetWithRoutePath('/home/details', extra: survey));
      await tester.pumpAndSettle();

      const surveyBackground = BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://example.com/fake-image.pngl'),
          fit: BoxFit.cover,
        ),
      );
      expect(
        tester.widget<Container>(surveyBackgroundContainer).decoration,
        surveyBackground,
      );

      expect(
        tester.widget<Text>(surveyTitleText).data,
        'Fake Survey Title',
      );

      expect(
        tester.widget<Text>(surveyDescriptionText).data,
        'Fake Survey Description',
      );

      expect(
        tester.widget<FlatButtonText>(startSurveyButton).text,
        'Start survey',
      );
    });
  });
}
