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
    late Finder answerDropdown;

    setUpAll(() async {
      await TestUtil.setupTestEnvironment();
    });

    setUp(() {
      closeSurveyButton = find.byKey(SurveyQuestionsWidgetId.closeSurveyButton);
      questionBackgroundContainer =
          find.byKey(SurveyQuestionsWidgetId.questionBackgroundContainer);
      questionIndicator = find.byKey(SurveyQuestionsWidgetId.questionIndicator);
      questionText = find.byKey(SurveyQuestionsWidgetId.questionText);
      nextQuestionButton =
          find.byKey(SurveyQuestionsWidgetId.nextQuestionButton);
      answerDropdown = find.byKey(SurveyQuestionsWidgetId.answersDropdown);
    });

    Future nextQuestionTest(
      WidgetTester tester,
      String indicatorText,
      Finder answer,
      Matcher matcher,
    ) async {
      await tester.tap(nextQuestionButton);
      await tester.pumpAndSettle();
      expect(
        tester.widget<Text>(questionIndicator).data,
        indicatorText,
      );
      expect(answer, matcher);
    }

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
      expect(answerDropdown, findsNothing);
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
          image: NetworkImage(
              'https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_l'),
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

    testWidgets(
        "When the survey questions screen shown, it displays the dropdown answers correctly",
        (WidgetTester tester) async {
      await FakeData.initDefault();
      await tester
          .pumpWidget(TestUtil.pumpWidgetWithRoutePath('/home/questions/1'));
      await tester.pumpAndSettle();

      await nextQuestionTest(tester, '2/12', answerDropdown, findsNothing);
      await nextQuestionTest(tester, '3/12', answerDropdown, findsNothing);
      await nextQuestionTest(tester, '4/12', answerDropdown, findsNothing);
      await nextQuestionTest(tester, '5/12', answerDropdown, findsNothing);
      await nextQuestionTest(tester, '6/12', answerDropdown, findsNothing);
      await nextQuestionTest(tester, '7/12', answerDropdown, findsNothing);
      await nextQuestionTest(tester, '8/12', answerDropdown, findsNothing);
      await nextQuestionTest(tester, '9/12', answerDropdown, findsNothing);
      await nextQuestionTest(tester, '10/12', answerDropdown, findsOneWidget);
    });
  });
}
