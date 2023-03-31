import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter_ic/model/profile_model.dart';

part 'home_view_state.freezed.dart';

@freezed
class HomeViewState with _$HomeViewState {
  const factory HomeViewState.init() = _Init;

  const factory HomeViewState.loading() = _Loading;

  const factory HomeViewState.getUserProfileSuccess(ProfileModel profile) =
      _GetUserProfileSuccess;

  const factory HomeViewState.error(String message) = _Error;
}
