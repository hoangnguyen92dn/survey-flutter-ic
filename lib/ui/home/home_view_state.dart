import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_view_state.freezed.dart';

@freezed
class HomeViewState with _$HomeViewState {
  const factory HomeViewState.init() = _Init;

  const factory HomeViewState.loading() = _Loading;

  const factory HomeViewState.success() = _Success;

  const factory HomeViewState.error(String message) = _Error;
}
