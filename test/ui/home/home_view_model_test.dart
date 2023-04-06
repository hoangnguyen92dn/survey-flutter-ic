import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/model/profile_model.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/ui/home/home_view_model.dart';
import 'package:survey_flutter_ic/ui/home/home_view_state.dart';
import 'package:survey_flutter_ic/ui/home/profile_ui_model.dart';
import 'package:survey_flutter_ic/ui/surveys/survey_ui_model.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('HomeViewModel', () {
    late MockGetProfileUseCase mockGetProfileUseCase;
    late MockGetSurveysUseCase mockGetSurveysUseCase;
    late HomeViewModel viewModel;
    late ProviderContainer container;

    setUp(() {
      mockGetProfileUseCase = MockGetProfileUseCase();
      mockGetSurveysUseCase = MockGetSurveysUseCase();

      container = ProviderContainer(overrides: [
        homeViewModelProvider.overrideWith((ref) =>
            HomeViewModel(mockGetProfileUseCase, mockGetSurveysUseCase))
      ]);
      viewModel = container.read(homeViewModelProvider.notifier);
      addTearDown(() => container.dispose());
    });

    test('When initializing HomeViewModel, its state is Init', () {
      expect(container.read(homeViewModelProvider), const HomeViewState.init());
    });

    test('When calling getProfile success, it returns Success state', () {
      const profile =
          ProfileModel(id: 'id', email: 'email', avatarUrl: 'avatarUrl');
      when(mockGetProfileUseCase.call())
          .thenAnswer((_) async => Success(profile));

      expect(
          viewModel.stream,
          emitsInOrder([
            const HomeViewState.loading(),
            const HomeViewState.success(),
          ]));

      final profileUiModel = ProfileUiModel.fromModel(profile);
      expect(container.read(profileStream.future).asStream(),
          emits(profileUiModel));

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

    test('When calling getSurveys success, it returns Success state', () {
      const surveys = [
        SurveyModel(
          id: "id",
          title: "title",
          description: "description",
          isActive: true,
          coverImageUrl: "coverImageUrl",
          largeCoverImageUrl: "largeCoverImageUrl",
          createdAt: "createdAt",
          surveyType: "surveyType",
        )
      ];
      when(mockGetSurveysUseCase.call(any))
          .thenAnswer((_) async => Success(surveys));

      expect(
          viewModel.stream,
          emitsInOrder([
            const HomeViewState.loading(),
            const HomeViewState.success(),
          ]));

      final surveyUiModels =
          surveys.map((e) => SurveyUiModel.fromModel(e)).toList();
      expect(container.read(surveysStream.future).asStream(),
          emits(surveyUiModels));

      container.read(homeViewModelProvider.notifier).getSurveys();
    });

    test('When calling getSurveys failed, it returns Error state', () {
      when(mockGetSurveysUseCase.call(any)).thenAnswer((_) async => Failed(
          UseCaseException(const NetworkExceptions.defaultError("Error"))));

      expect(
          viewModel.stream,
          emitsInOrder([
            const HomeViewState.loading(),
            const HomeViewState.error("Error"),
          ]));

      container.read(homeViewModelProvider.notifier).getSurveys();
    });
  });
}
