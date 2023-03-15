import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/di/provider/di.dart';
import 'package:survey_flutter_ic/ui/signin/sign_in_view_state.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecase/sign_in_use_case.dart';

final signInViewModelProvider =
    StateNotifierProvider.autoDispose<SignInViewModel, SignInViewState>(
        (_) => SignInViewModel(
              getIt.get<SignInUseCase>(),
            ));

class SignInViewModel extends StateNotifier<SignInViewState> {
  final SignInUseCase _signInUseCase;

  SignInViewModel(this._signInUseCase) : super(const SignInViewState.init());

  Future signIn(String email, String password) async {
    state = const SignInViewState.loading();

    final result = await _signInUseCase.call(SignInInput(
      email: email,
      password: password,
    ));

    if (result is Failed) {
      final error = result.getErrorMessage();
      if (error != null) {
        state = SignInViewState.error(error);
      }
    } else {
      state = const SignInViewState.success();
    }
  }
}
