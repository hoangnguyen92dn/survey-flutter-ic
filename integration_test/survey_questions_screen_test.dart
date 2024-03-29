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
    late Finder submitButton;
    late Finder answerDropdown;
    late Finder answerRating;
    late Finder answerEmoji;
    late Finder answerSmiley;
    late Finder answerNps;
    late Finder answerTextArea;
    late Finder answerForm;
    late Finder answerMultipleChoices;
    late Finder quitSurveyConfirmationDialog;

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
      submitButton = find.byKey(SurveyQuestionsWidgetId.submitButton);
      answerDropdown = find.byKey(SurveyQuestionsWidgetId.answersDropdown);
      answerRating = find.byKey(SurveyQuestionsWidgetId.answersRating);
      answerEmoji = find.byKey(SurveyQuestionsWidgetId.answersEmoji);
      answerSmiley = find.byKey(SurveyQuestionsWidgetId.answersSmiley);
      answerNps = find.byKey(SurveyQuestionsWidgetId.answersNps);
      answerTextArea = find.byKey(SurveyQuestionsWidgetId.answersTextArea);
      answerForm = find.byKey(SurveyQuestionsWidgetId.answersForm);
      answerMultipleChoices =
          find.byKey(SurveyQuestionsWidgetId.answersMultipleChoices);
      quitSurveyConfirmationDialog =
          find.byKey(SurveyQuestionsWidgetId.quitSurveyConfirmationDialog);
    });

    Future nextQuestionTest(
      WidgetTester tester,
      String indicatorText,
    ) async {
      await tester.tap(nextQuestionButton);
      await tester.pumpAndSettle();
      expect(
        tester.widget<Text>(questionIndicator).data,
        indicatorText,
      );
    }

    Future answerTest(
      Finder answer,
      Matcher matcher,
    ) async {
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
      expect(answerRating, findsNothing);
      expect(answerEmoji, findsNothing);
      expect(answerSmiley, findsNothing);
      expect(answerNps, findsNothing);
      expect(answerTextArea, findsNothing);
      expect(answerForm, findsNothing);
      expect(answerMultipleChoices, findsNothing);
      expect(quitSurveyConfirmationDialog, findsNothing);
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
        "When browse the questions list, it displays the answers correctly",
        (WidgetTester tester) async {
      await FakeData.initDefault();
      await tester
          .pumpWidget(TestUtil.pumpWidgetWithRoutePath('/home/questions/1'));
      await tester.pumpAndSettle();

      await nextQuestionTest(tester, '2/12');
      await answerTest(answerDropdown, findsNothing);
      await answerTest(answerEmoji, findsNothing);
      await answerTest(answerNps, findsNothing);
      await answerTest(answerTextArea, findsNothing);
      await answerTest(answerForm, findsNothing);
      await answerTest(answerMultipleChoices, findsOneWidget);
      await answerTest(nextQuestionButton, findsOneWidget);
      await answerTest(submitButton, findsNothing);

      await nextQuestionTest(tester, '3/12');
      await answerTest(answerDropdown, findsNothing);
      await answerTest(answerEmoji, findsNothing);
      await answerTest(answerNps, findsNothing);
      await answerTest(answerTextArea, findsNothing);
      await answerTest(answerForm, findsNothing);
      await answerTest(answerMultipleChoices, findsOneWidget);
      await answerTest(nextQuestionButton, findsOneWidget);
      await answerTest(submitButton, findsNothing);

      await nextQuestionTest(tester, '4/12');
      await answerTest(answerDropdown, findsNothing);
      await answerTest(answerEmoji, findsNothing);
      await answerTest(answerNps, findsOneWidget);
      await answerTest(answerTextArea, findsNothing);
      await answerTest(answerForm, findsNothing);
      await answerTest(answerMultipleChoices, findsNothing);
      await answerTest(nextQuestionButton, findsOneWidget);
      await answerTest(submitButton, findsNothing);

      await nextQuestionTest(tester, '5/12');
      await answerTest(answerDropdown, findsNothing);
      await answerTest(answerEmoji, findsOneWidget);
      await answerTest(answerNps, findsNothing);
      await answerTest(answerTextArea, findsNothing);
      await answerTest(answerForm, findsNothing);
      await answerTest(answerMultipleChoices, findsNothing);
      await answerTest(nextQuestionButton, findsOneWidget);
      await answerTest(submitButton, findsNothing);

      await nextQuestionTest(tester, '6/12');
      await answerTest(answerDropdown, findsNothing);
      await answerTest(answerEmoji, findsOneWidget);
      await answerTest(answerNps, findsNothing);
      await answerTest(answerTextArea, findsNothing);
      await answerTest(answerForm, findsNothing);
      await answerTest(answerMultipleChoices, findsNothing);
      await answerTest(nextQuestionButton, findsOneWidget);
      await answerTest(submitButton, findsNothing);

      await nextQuestionTest(tester, '7/12');
      await answerTest(answerDropdown, findsNothing);
      await answerTest(answerEmoji, findsOneWidget);
      await answerTest(answerNps, findsNothing);
      await answerTest(answerTextArea, findsNothing);
      await answerTest(answerForm, findsNothing);
      await answerTest(answerMultipleChoices, findsNothing);
      await answerTest(nextQuestionButton, findsOneWidget);
      await answerTest(submitButton, findsNothing);

      await nextQuestionTest(tester, '8/12');
      await answerTest(answerDropdown, findsNothing);
      await answerTest(answerEmoji, findsOneWidget);
      await answerTest(answerNps, findsNothing);
      await answerTest(answerTextArea, findsNothing);
      await answerTest(answerForm, findsNothing);
      await answerTest(answerMultipleChoices, findsNothing);
      await answerTest(nextQuestionButton, findsOneWidget);
      await answerTest(submitButton, findsNothing);

      await nextQuestionTest(tester, '9/12');
      await answerTest(answerDropdown, findsNothing);
      await answerTest(answerEmoji, findsNothing);
      await answerTest(answerNps, findsNothing);
      await answerTest(answerTextArea, findsOneWidget);
      await answerTest(answerForm, findsNothing);
      await answerTest(answerMultipleChoices, findsNothing);
      await answerTest(nextQuestionButton, findsOneWidget);
      await answerTest(submitButton, findsNothing);

      await nextQuestionTest(tester, '10/12');
      await answerTest(answerDropdown, findsOneWidget);
      await answerTest(answerEmoji, findsNothing);
      await answerTest(answerNps, findsNothing);
      await answerTest(answerTextArea, findsNothing);
      await answerTest(answerForm, findsNothing);
      await answerTest(answerMultipleChoices, findsNothing);
      await answerTest(nextQuestionButton, findsOneWidget);
      await answerTest(submitButton, findsNothing);

      await nextQuestionTest(tester, '11/12');
      await answerTest(answerDropdown, findsNothing);
      await answerTest(answerEmoji, findsNothing);
      await answerTest(answerNps, findsNothing);
      await answerTest(answerTextArea, findsNothing);
      await answerTest(answerForm, findsOneWidget);
      await answerTest(answerMultipleChoices, findsNothing);
      await answerTest(nextQuestionButton, findsOneWidget);
      await answerTest(submitButton, findsNothing);

      await nextQuestionTest(tester, '12/12');
      await answerTest(answerDropdown, findsNothing);
      await answerTest(answerEmoji, findsNothing);
      await answerTest(answerNps, findsNothing);
      await answerTest(answerTextArea, findsNothing);
      await answerTest(answerForm, findsNothing);
      await answerTest(answerMultipleChoices, findsNothing);
      await answerTest(nextQuestionButton, findsNothing);
      await answerTest(submitButton, findsOneWidget);
    });

    testWidgets(
        "When click on the close button, it displays the confirmation dialog correctly",
        (WidgetTester tester) async {
      await FakeData.initDefault();
      await tester
          .pumpWidget(TestUtil.pumpWidgetWithRoutePath('/home/questions/1'));
      await tester.pumpAndSettle();

      await tester.tap(closeSurveyButton);
      await tester.pumpAndSettle();

      expect(quitSurveyConfirmationDialog, findsOneWidget);
    });
  });
}
