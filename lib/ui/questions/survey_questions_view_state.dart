import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter_ic/ui/details/survey_details_ui_model.dart';

part 'survey_questions_view_state.freezed.dart';

@freezed
class SurveyQuestionsViewState with _$SurveyQuestionsViewState {
  const factory SurveyQuestionsViewState.init() = _Init;

  const factory SurveyQuestionsViewState.loading() = _Loading;

  const factory SurveyQuestionsViewState.success(
      SurveyDetailsUiModel surveyDetails) = _Success;

  const factory SurveyQuestionsViewState.error(String message) = _Error;
}
