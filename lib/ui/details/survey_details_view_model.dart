import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/ui/details/survey_details_view_state.dart';
import 'package:survey_flutter_ic/ui/surveys/survey_ui_model.dart';

final surveyDetailsViewModelProvider = StateNotifierProvider.autoDispose<
    SurveyDetailsViewModel,
    SurveyDetailsViewState>((_) => SurveyDetailsViewModel());

final surveyDetailStream = StreamProvider.autoDispose<SurveyUiModel>((ref) =>
    ref
        .watch(surveyDetailsViewModelProvider.notifier)
        ._surveyStreamController
        .stream);

class SurveyDetailsViewModel extends StateNotifier<SurveyDetailsViewState> {
  final _surveyStreamController = StreamController<SurveyUiModel>();

  SurveyDetailsViewModel() : super(const SurveyDetailsViewState.init());

  void setSurvey(SurveyUiModel survey) {
    _surveyStreamController.add(survey);
  }

  @override
  void dispose() {
    _surveyStreamController.close();
    super.dispose();
  }
}
