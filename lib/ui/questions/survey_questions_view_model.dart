import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/di/provider/di.dart';
import 'package:survey_flutter_ic/model/survey_details_model.dart';
import 'package:survey_flutter_ic/ui/details/survey_details_ui_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_view_state.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecase/get_survey_details_use_case.dart';

final surveyQuestionsViewModelProvider = StateNotifierProvider.autoDispose<
        SurveyQuestionsViewModel, SurveyQuestionsViewState>(
    (_) => SurveyQuestionsViewModel(
          getIt.get<GetSurveyDetailsUseCase>(),
        ));

final surveyDetailsStream = StreamProvider.autoDispose<SurveyDetailsUiModel>(
    (ref) => ref
        .watch(surveyQuestionsViewModelProvider.notifier)
        ._surveyDetailsStreamController
        .stream);

final visibleIndexStream = StreamProvider.autoDispose<int>((ref) => ref
    .watch(surveyQuestionsViewModelProvider.notifier)
    ._visibleIndexStreamController
    .stream);

final nextQuestionStream = StreamProvider.autoDispose<void>((ref) => ref
    .watch(surveyQuestionsViewModelProvider.notifier)
    ._nextQuestionStreamController
    .stream);

class SurveyQuestionsViewModel extends StateNotifier<SurveyQuestionsViewState> {
  final GetSurveyDetailsUseCase _getSurveyDetailsUseCase;

  final _surveyDetailsStreamController =
      StreamController<SurveyDetailsUiModel>();
  final _visibleIndexStreamController = StreamController<int>();
  final _nextQuestionStreamController = StreamController<void>();

  SurveyQuestionsViewModel(this._getSurveyDetailsUseCase)
      : super(const SurveyQuestionsViewState.init());

  void setVisibleSurveyIndex(int index) {
    _visibleIndexStreamController.add(index);
  }

  void nextQuestion() {
    _nextQuestionStreamController.add(null);
  }

  Future getSurveyDetails(String surveyId) async {
    state = const SurveyQuestionsViewState.loading();
    final result = await _getSurveyDetailsUseCase.call(surveyId);

    if (result is Failed<SurveyDetailsModel>) {
      final error = result.getErrorMessage();
      state = SurveyQuestionsViewState.error(error);
    } else {
      final surveyDetails = result as Success<SurveyDetailsModel>;
      _surveyDetailsStreamController
          .add(SurveyDetailsUiModel.fromModel(surveyDetails.value));
      state = const SurveyQuestionsViewState.success();
    }
  }

  @override
  void dispose() {
    _surveyDetailsStreamController.close();
    super.dispose();
  }
}
