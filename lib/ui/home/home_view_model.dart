import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/di/provider/di.dart';
import 'package:survey_flutter_ic/extension/date_extension.dart';
import 'package:survey_flutter_ic/model/profile_model.dart';
import 'package:survey_flutter_ic/ui/home/home_view_state.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecase/get_profile_use_case.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeViewState>(
        (_) => HomeViewModel(
              getIt.get<GetProfileUseCase>(),
            ));

final todayStream = StreamProvider.autoDispose<String>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._todayStreamController.stream);

final profileStream = StreamProvider.autoDispose<ProfileModel>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._profileStreamController.stream);

final visibleIndexStream = StreamProvider.autoDispose<int>((ref) => ref
    .watch(homeViewModelProvider.notifier)
    ._visibleIndexStreamController
    .stream);

class HomeViewModel extends StateNotifier<HomeViewState> {
  final GetProfileUseCase _getProfileUseCase;

  final _todayStreamController = StreamController<String>();
  final _profileStreamController = StreamController<ProfileModel>();
  final _visibleIndexStreamController = StreamController<int>();

  HomeViewModel(this._getProfileUseCase) : super(const HomeViewState.init());

  void setVisibleSurveyIndex(int index) {
    _visibleIndexStreamController.add(index);
  }

  Future getProfile() async {
    state = const HomeViewState.loading();

    final result = await _getProfileUseCase.call();

    if (result is Failed<ProfileModel>) {
      final error = result.getErrorMessage();
      state = HomeViewState.error(error);
    } else {
      final profile = (result as Success<ProfileModel>).value;
      state = const HomeViewState.success();
      _profileStreamController.add(profile);
    }

    // Bind Today to stream
    _todayStreamController.add(DateTime.now().getFormattedString());
  }
}
