import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_view_state.freezed.dart';

@freezed
class SignInViewState with _$SignInViewState {
  const factory SignInViewState.init() = _Init;

  const factory SignInViewState.loading() = _Loading;

  const factory SignInViewState.success() = _Success;

  const factory SignInViewState.error(String message) = _Error;
}
