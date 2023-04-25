import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_questions_request.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_request.dart';
import 'package:survey_flutter_ic/di/provider/di.dart';
import 'package:survey_flutter_ic/model/survey_details_model.dart';
import 'package:survey_flutter_ic/ui/details/survey_details_ui_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_view_state.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecase/get_survey_details_use_case.dart';
import 'package:survey_flutter_ic/usecase/submit_survey_use_case.dart';

final surveyQuestionsViewModelProvider = StateNotifierProvider.autoDispose<
        SurveyQuestionsViewModel, SurveyQuestionsViewState>(
    (_) => SurveyQuestionsViewModel(
          getIt.get<GetSurveyDetailsUseCase>(),
          getIt.get<SubmitSurveyUseCase>(),
        ));

final visibleIndexStream = StreamProvider.autoDispose<int>((ref) => ref
    .watch(surveyQuestionsViewModelProvider.notifier)
    ._visibleIndexStreamController
    .stream);

final nextQuestionStream = StreamProvider.autoDispose<void>((ref) => ref
    .watch(surveyQuestionsViewModelProvider.notifier)
    ._nextQuestionStreamController
    .stream);

final surveySubmittedStream = StreamProvider.autoDispose<void>((ref) => ref
    .watch(surveyQuestionsViewModelProvider.notifier)
    ._surveySubmittedController
    .stream);

class SurveyQuestionsViewModel extends StateNotifier<SurveyQuestionsViewState> {
  final GetSurveyDetailsUseCase _getSurveyDetailsUseCase;
  final SubmitSurveyUseCase _submitSurveyUseCase;

  final _visibleIndexStreamController = StreamController<int>();
  final _nextQuestionStreamController = StreamController<void>();
  final _surveySubmittedController = StreamController<void>();
  final List<SubmitSurveyQuestionsRequest> _selectedAnswers = [];

  SurveyQuestionsViewModel(
    this._getSurveyDetailsUseCase,
    this._submitSurveyUseCase,
  ) : super(const SurveyQuestionsViewState.init());

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
      final surveyDetailsUiModel =
          SurveyDetailsUiModel.fromModel(surveyDetails.value);
      state = SurveyQuestionsViewState.success(surveyDetailsUiModel);
    }
  }

  Future cacheAnswers(SubmitSurveyQuestionsRequest request) async {
    _selectedAnswers.add(request);
  }

  Future submit(String surveyId) async {
    state = const SurveyQuestionsViewState.loading();
    final result = await _submitSurveyUseCase.call(
      SubmitSurveyRequest(
        surveyId: surveyId,
        questions: _selectedAnswers,
      ),
    );

    if (result is Failed<void>) {
      final error = result.getErrorMessage();
      state = SurveyQuestionsViewState.error(error);
    } else {
      _surveySubmittedController.add(null);
    }
  }

  @override
  void dispose() {
    _visibleIndexStreamController.close();
    _nextQuestionStreamController.close();
    super.dispose();
  }
}
