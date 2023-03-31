import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/di/provider/di.dart';
import 'package:survey_flutter_ic/model/profile_model.dart';
import 'package:survey_flutter_ic/ui/home/home_view_state.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecase/get_profile_use_case.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeViewState>(
        (_) => HomeViewModel(
              getIt.get<GetProfileUseCase>(),
            ));

class HomeViewModel extends StateNotifier<HomeViewState> {
  final GetProfileUseCase _getProfileUseCase;

  HomeViewModel(this._getProfileUseCase) : super(const HomeViewState.init());

  Future getProfile() async {
    state = const HomeViewState.loading();

    final result = await _getProfileUseCase.call();

    if (result is Failed<ProfileModel>) {
      final error = result.getErrorMessage();
      if (error != null) {
        state = HomeViewState.error(error);
      }
    } else {
      state = HomeViewState.getUserProfileSuccess(
          (result as Success<ProfileModel>).value);
    }
  }
}
