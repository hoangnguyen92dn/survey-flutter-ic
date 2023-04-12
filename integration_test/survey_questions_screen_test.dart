import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_widget_id.dart';

import 'fake_data/fake_data.dart';
import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  surveyQuestionsScreenTest();
}

void surveyQuestionsScreenTest() {
  group('Survey Questions Page', () {
    late Finder closeSurveyButton;
    late Finder questionBackgroundContainer;
    late Finder questionIndicator;
    late Finder questionText;
    late Finder nextQuestionButton;

    setUpAll(() async {
      await TestUtil.setupTestEnvironment();
    });

    setUp(() {
      nextQuestionButton =
          find.byKey(SurveyQuestionsWidgetId.nextQuestionButton);
      closeSurveyButton = find.byKey(SurveyQuestionsWidgetId.closeSurveyButton);
      questionBackgroundContainer =
          find.byKey(SurveyQuestionsWidgetId.questionBackgroundContainer);
      questionText = find.byKey(SurveyQuestionsWidgetId.questionText);
      questionIndicator = find.byKey(SurveyQuestionsWidgetId.questionIndicator);
    });

    testWidgets(
        "When the survey questions screen shown, it displays the survey questions screen correctly",
        (WidgetTester tester) async {
      await FakeData.initDefault();
      await tester
          .pumpWidget(TestUtil.pumpWidgetWithRoutePath('/home/questions/1'));
      await tester.pumpAndSettle();

      expect(closeSurveyButton, findsOneWidget);
      expect(questionBackgroundContainer, findsOneWidget);
      expect(questionText, findsOneWidget);
      expect(questionIndicator, findsOneWidget);
      expect(nextQuestionButton, findsOneWidget);
    });

    testWidgets(
        "When the survey questions screen shown, it binds the Questions correctly",
        (WidgetTester tester) async {
      await FakeData.initDefault();
      await tester
          .pumpWidget(TestUtil.pumpWidgetWithRoutePath('/home/questions/1'));
      await tester.pumpAndSettle();

      const surveyBackground = BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://example.com/fake-image.pngl'),
          fit: BoxFit.cover,
        ),
      );
      expect(
        tester.widget<Container>(questionBackgroundContainer).decoration,
        surveyBackground,
      );

      expect(
        tester.widget<Text>(questionText).data,
        'Fake Survey Question Text',
      );

      expect(
        tester.widget<Text>(questionIndicator).data,
        '1/12',
      );
    });
  });
}
