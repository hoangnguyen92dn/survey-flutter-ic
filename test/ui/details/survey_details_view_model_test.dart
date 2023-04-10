import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_flutter_ic/ui/details/survey_details_view_model.dart';
import 'package:survey_flutter_ic/ui/details/survey_details_view_state.dart';
import 'package:survey_flutter_ic/ui/surveys/survey_ui_model.dart';

void main() {
  group('SurveyDetailsViewModel', () {
    late SurveyDetailsViewModel viewModel;
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(overrides: [
        surveyDetailsViewModelProvider
            .overrideWith((ref) => SurveyDetailsViewModel())
      ]);
      viewModel = container.read(surveyDetailsViewModelProvider.notifier);
      addTearDown(() => container.dispose());
    });

    test('When initializing SurveyDetailsViewModel, it emits Init state', () {
      expect(container.read(surveyDetailsViewModelProvider),
          const SurveyDetailsViewState.init());
    });

    test('When calling setSurvey, it emits survey on surveyDetailStream', () {
      const survey = SurveyUiModel(
        id: 'id',
        title: 'title',
        description: 'description',
        isActive: true,
        coverImageUrl: 'coverImageUrl',
        largeCoverImageUrl: 'largeCoverImageUrl',
        createdAt: 'createdAt',
        surveyType: 'surveyType',
      );

      expect(
        container.read(surveyStream.future).asStream(),
        emits(survey),
      );

      viewModel.setSurvey(survey);
    });
  });
}
