import 'package:freezed_annotation/freezed_annotation.dart';

part 'survey_details_view_state.freezed.dart';

@freezed
class SurveyDetailsViewState with _$SurveyDetailsViewState {
  const factory SurveyDetailsViewState.init() = _Init;

  const factory SurveyDetailsViewState.loading() = _Loading;

  const factory SurveyDetailsViewState.success() = _Success;

  const factory SurveyDetailsViewState.error(String message) = _Error;
}
