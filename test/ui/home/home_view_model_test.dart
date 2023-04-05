import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/model/profile_model.dart';
import 'package:survey_flutter_ic/ui/home/home_view_model.dart';
import 'package:survey_flutter_ic/ui/home/home_view_state.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('HomeViewModel', () {
    late MockGetProfileUseCase mockGetProfileUseCase;
    late HomeViewModel viewModel;
    late ProviderContainer container;

    setUp(() {
      mockGetProfileUseCase = MockGetProfileUseCase();

      container = ProviderContainer(overrides: [
        homeViewModelProvider
            .overrideWith((ref) => HomeViewModel(mockGetProfileUseCase))
      ]);
      viewModel = container.read(homeViewModelProvider.notifier);
      addTearDown(() => container.dispose());
    });

    test('When initializing HomeViewModel, its state is Init', () {
      expect(container.read(homeViewModelProvider), const HomeViewState.init());
    });

    test(
        'When calling getProfile success, it returns GetUserProfileSuccess state',
        () {
      const profile = ProfileModel(avatarUrl: "avatarUrl");
      when(mockGetProfileUseCase.call())
          .thenAnswer((_) async => Success(profile));

      expect(
          viewModel.stream,
          emitsInOrder([
            const HomeViewState.loading(),
            const HomeViewState.success(),
          ]));

      expect(container.read(profileStream.stream), emits(profile));

      container.read(homeViewModelProvider.notifier).getProfile();
    });

    test('When calling getProfile failed, it returns Error state', () {
      when(mockGetProfileUseCase.call()).thenAnswer((_) async => Failed(
          UseCaseException(const NetworkExceptions.defaultError("Error"))));

      expect(
          viewModel.stream,
          emitsInOrder([
            const HomeViewState.loading(),
            const HomeViewState.error("Error"),
          ]));

      container.read(homeViewModelProvider.notifier).getProfile();
    });
  });
}
