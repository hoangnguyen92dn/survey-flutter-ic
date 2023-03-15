import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/ui/signin/sign_in_view_model.dart';
import 'package:survey_flutter_ic/ui/signin/sign_in_view_state.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('SignInViewModel', () {
    late MockSignInUseCase mockSignInUseCase;
    late ProviderContainer container;

    setUp(() {
      mockSignInUseCase = MockSignInUseCase();

      container = ProviderContainer(overrides: [
        signInViewModelProvider
            .overrideWith((ref) => SignInViewModel(mockSignInUseCase))
      ]);
      addTearDown(() => container.dispose());
    });

    test('When initializing SignInViewModel, its state is Init', () {
      expect(container.read(signInViewModelProvider),
          const SignInViewState.init());
    });

    test('When calling signIn success, it returns success state', () {
      final stateStream =
          container.read(signInViewModelProvider.notifier).stream;
      when(mockSignInUseCase.call(any)).thenAnswer((_) async => Success(null));

      expect(
          stateStream,
          emitsInOrder([
            const SignInViewState.loading(),
            const SignInViewState.success(),
          ]));
      container
          .read(signInViewModelProvider.notifier)
          .signIn('email', 'password');
    });

    test('When calling signIn failed, it returns error state', () {
      final stateStream =
          container.read(signInViewModelProvider.notifier).stream;
      when(mockSignInUseCase.call(any)).thenAnswer((_) async => Failed(
          UseCaseException(const NetworkExceptions.defaultError("Error"))));

      expect(
          stateStream,
          emitsInOrder([
            const SignInViewState.loading(),
            const SignInViewState.error("Error"),
          ]));
      container
          .read(signInViewModelProvider.notifier)
          .signIn('email', 'password');
    });
  });
}
