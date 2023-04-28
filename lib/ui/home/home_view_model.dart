import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/di/provider/di.dart';
import 'package:survey_flutter_ic/extension/date_extension.dart';
import 'package:survey_flutter_ic/model/profile_model.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/ui/home/home_view_state.dart';
import 'package:survey_flutter_ic/ui/home/profile_ui_model.dart';
import 'package:survey_flutter_ic/ui/surveys/survey_ui_model.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecase/get_profile_use_case.dart';
import 'package:survey_flutter_ic/usecase/get_survey_use_case.dart';
import 'package:survey_flutter_ic/usecase/sign_out_use_case.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeViewState>(
        (_) => HomeViewModel(
              getIt.get<GetProfileUseCase>(),
              getIt.get<GetSurveysUseCase>(),
              getIt.get<SignOutUseCase>(),
            ));

final todayStream = StreamProvider.autoDispose<String>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._todayStreamController.stream);

final profileStream = StreamProvider.autoDispose<ProfileUiModel>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._profileStreamController.stream);

final surveysStream = StreamProvider.autoDispose<List<SurveyUiModel>>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._surveysStreamController.stream);

final visibleIndexStream = StreamProvider.autoDispose<int>((ref) => ref
    .watch(homeViewModelProvider.notifier)
    ._visibleIndexStreamController
    .stream);

final loadingIndicatorStream = StreamProvider.autoDispose<bool>((ref) => ref
    .watch(homeViewModelProvider.notifier)
    ._loadingIndicatorStreamController
    .stream);

final signOutStream = StreamProvider.autoDispose<void>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._signOutStreamController.stream);

const _defaultFirstPageIndex = 1;
const _defaultPageSize = 10;

class HomeViewModel extends StateNotifier<HomeViewState> {
  final GetProfileUseCase _getProfileUseCase;
  final GetSurveysUseCase _getSurveyUseCase;
  final SignOutUseCase _signOutUseCase;

  final _todayStreamController = StreamController<String>();
  final _profileStreamController = StreamController<ProfileUiModel>();
  final _surveysStreamController = StreamController<List<SurveyUiModel>>();
  final _visibleIndexStreamController = StreamController<int>();
  final _loadingIndicatorStreamController = StreamController<bool>();
  final _signOutStreamController = StreamController<void>();

  HomeViewModel(
      this._getProfileUseCase, this._getSurveyUseCase, this._signOutUseCase)
      : super(const HomeViewState.init());

  void setVisibleSurveyIndex(int index) {
    _visibleIndexStreamController.add(index);
  }

  Future init() async {
    await _getProfile();
    await _getSurveys();

    // Bind Today to stream
    _todayStreamController.add(DateTime.now().getFormattedString());

    state = const HomeViewState.success();
  }

  Future _getProfile() async {
    final result = await _getProfileUseCase.call();

    if (result is Failed<ProfileModel>) {
      final error = result.getErrorMessage();
      state = HomeViewState.error(error);
    } else {
      final profile = (result as Success<ProfileModel>).value;
      _profileStreamController.add(ProfileUiModel.fromModel(profile));
    }

    // Bind Today to stream
    _todayStreamController.add(DateTime.now().getFormattedString());
  }

  Future _getSurveys() async {
    final input = GetSurveysInput(
      pageNumber: _defaultFirstPageIndex,
      pageSize: _defaultPageSize,
    );

    final result = await _getSurveyUseCase.call(input);

    if (result is Failed<List<SurveyModel>>) {
      final error = result.getErrorMessage();
      state = HomeViewState.error(error);
    } else {
      final surveys = (result as Success<List<SurveyModel>>).value;
      final surveyUiModels =
          surveys.map((survey) => SurveyUiModel.fromModel(survey));
      _surveysStreamController.add(surveyUiModels.toList(growable: false));
    }
  }

  Future signOut() async {
    _loadingIndicatorStreamController.add(true);

    final result = await _signOutUseCase.call();
    if (result is Failed<void>) {
      final error = result.getErrorMessage();
      state = HomeViewState.error(error);
    } else {
      _signOutStreamController.add(null);
    }
    _loadingIndicatorStreamController.add(false);
  }

  @override
  void dispose() {
    _todayStreamController.close();
    _profileStreamController.close();
    _surveysStreamController.close();
    _visibleIndexStreamController.close();
    _loadingIndicatorStreamController.close();
    _signOutStreamController.close();
    super.dispose();
  }
}
