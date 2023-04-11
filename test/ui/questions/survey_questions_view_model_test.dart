import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/model/question_dislplay_type_model.dart';
import 'package:survey_flutter_ic/model/survey_answer_model.dart';
import 'package:survey_flutter_ic/model/survey_details_model.dart';
import 'package:survey_flutter_ic/model/survey_question_model.dart';
import 'package:survey_flutter_ic/ui/details/survey_details_ui_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_view_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_view_state.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('SurveyQuestionsViewModel', () {
    late MockGetSurveyDetailsUseCase mockGetSurveyDetailsUseCase;
    late SurveyQuestionsViewModel viewModel;
    late ProviderContainer container;

    setUp(() {
      mockGetSurveyDetailsUseCase = MockGetSurveyDetailsUseCase();

      container = ProviderContainer(overrides: [
        surveyQuestionsViewModelProvider.overrideWith(
            (ref) => SurveyQuestionsViewModel(mockGetSurveyDetailsUseCase))
      ]);
      viewModel = container.read(surveyQuestionsViewModelProvider.notifier);
      addTearDown(() => container.dispose());
    });

    test('When initializing SurveyQuestionsViewModel, it emits Init state', () {
      expect(container.read(surveyQuestionsViewModelProvider),
          const SurveyQuestionsViewState.init());
    });

    test('When calling getSurveyDetails success, it emits Success state', () {
      const surveyDetails = SurveyDetailsModel(
        id: 'surveyId',
        coverImageUrl: 'coverImageUrl',
        largeCoverImageUrl: 'largeCoverImageUrl',
        questions: [
          SurveyQuestionModel(
            id: 'questionId',
            text: 'text',
            displayOrder: 1,
            displayType: QuestionDisplayType.choice,
            coverImageUrl: 'coverImageUrl',
            answers: [
              SurveyAnswerModel(
                id: 'answerId',
                text: 'text',
              )
            ],
          )
        ],
      );
      when(mockGetSurveyDetailsUseCase.call(any))
          .thenAnswer((_) async => Success(surveyDetails));

      expect(
          viewModel.stream,
          emitsInOrder([
            const SurveyQuestionsViewState.loading(),
            const SurveyQuestionsViewState.success(),
          ]));

      final surveyDetailsUiModel =
          SurveyDetailsUiModel.fromModel(surveyDetails);
      expect(container.read(surveyDetailsStream.future).asStream(),
          emits(surveyDetailsUiModel));

      container
          .read(surveyQuestionsViewModelProvider.notifier)
          .getSurveyDetails('surveyId');
    });

    test('When calling getSurveyDetails failed, it emits Error state', () {
      when(mockGetSurveyDetailsUseCase.call(any)).thenAnswer((_) async =>
          Failed(
              UseCaseException(const NetworkExceptions.defaultError('Error'))));

      expect(
          viewModel.stream,
          emitsInOrder([
            const SurveyQuestionsViewState.loading(),
            const SurveyQuestionsViewState.error('Error'),
          ]));

      container
          .read(surveyQuestionsViewModelProvider.notifier)
          .getSurveyDetails('surveyId');
    });

    test('When calling setVisibleSurveyIndex success, it emits new index', () {
      expect(container.read(visibleIndexStream.future).asStream(), emits(0));

      container
          .read(surveyQuestionsViewModelProvider.notifier)
          .setVisibleSurveyIndex(0);
    });

    test('When calling nextQuestion success, it emits new event', () {
      expect(container.read(nextQuestionStream.future).asStream(), emits(null));

      container.read(surveyQuestionsViewModelProvider.notifier).nextQuestion();
    });
  });
}
