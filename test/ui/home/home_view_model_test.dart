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
    late MockSignOutUseCase mockSignOutUseCase;
    late MockGetCachedSurveysUseCase mockGetCachedSurveysUseCase;
    late HomeViewModel viewModel;
    late ProviderContainer container;

    setUp(() {
      mockGetProfileUseCase = MockGetProfileUseCase();
      mockGetSurveysUseCase = MockGetSurveysUseCase();
      mockSignOutUseCase = MockSignOutUseCase();
      mockGetCachedSurveysUseCase = MockGetCachedSurveysUseCase();

      const cachedSurveys = [
        SurveyModel(
          id: 'id',
          title: 'title',
          description: 'description',
          isActive: true,
          coverImageUrl: 'coverImageUrl',
          largeCoverImageUrl: 'largeCoverImageUrl',
          createdAt: 'createdAt',
          surveyType: 'surveyType',
        )
      ];
      when(mockGetCachedSurveysUseCase.call())
          .thenAnswer((_) async => Success(cachedSurveys));

      container = ProviderContainer(overrides: [
        homeViewModelProvider.overrideWith((ref) => HomeViewModel(
              mockGetProfileUseCase,
              mockGetSurveysUseCase,
              mockSignOutUseCase,
              mockGetCachedSurveysUseCase,
            )),
      ]);
      viewModel = container.read(homeViewModelProvider.notifier);
      addTearDown(() => container.dispose());
    });

    test('When calling init success, it emits Success state', () {
      const profile = ProfileModel(
        id: 'id',
        email: 'email',
        name: 'name',
        avatarUrl: 'avatarUrl',
      );
      when(mockGetProfileUseCase.call())
          .thenAnswer((_) async => Success(profile));

      const surveys = [
        SurveyModel(
          id: 'id',
          title: 'title',
          description: 'description',
          isActive: true,
          coverImageUrl: 'coverImageUrl',
          largeCoverImageUrl: 'largeCoverImageUrl',
          createdAt: 'createdAt',
          surveyType: 'surveyType',
        )
      ];
      when(mockGetSurveysUseCase.call(any))
          .thenAnswer((_) async => Success(surveys));

      expect(
          viewModel.stream,
          emitsInOrder([
            const HomeViewState.success(),
          ]));

      final profileUiModel = ProfileUiModel.fromModel(profile);
      expect(container.read(profileStream.future).asStream(),
          emits(profileUiModel));

      final surveyUiModels =
          surveys.map((e) => SurveyUiModel.fromModel(e)).toList();
      expect(container.read(surveysStream.future).asStream(),
          emits(surveyUiModels));

      container.read(homeViewModelProvider.notifier).init();
    });

    test('When calling init failed on getProfile, it emits Error state', () {
      when(mockGetProfileUseCase.call()).thenAnswer((_) async => Failed(
          UseCaseException(const NetworkExceptions.defaultError('Error'))));

      const surveys = [
        SurveyModel(
          id: 'id',
          title: 'title',
          description: 'description',
          isActive: true,
          coverImageUrl: 'coverImageUrl',
          largeCoverImageUrl: 'largeCoverImageUrl',
          createdAt: 'createdAt',
          surveyType: 'surveyType',
        )
      ];
      when(mockGetSurveysUseCase.call(any))
          .thenAnswer((_) async => Success(surveys));

      expect(
          viewModel.stream,
          emitsInOrder([
            const HomeViewState.error('Error'),
            const HomeViewState.success(),
          ]));

      final surveyUiModels =
          surveys.map((e) => SurveyUiModel.fromModel(e)).toList();
      expect(container.read(surveysStream.future).asStream(),
          emits(surveyUiModels));

      container.read(homeViewModelProvider.notifier).init();
    });

    test('When calling init failed on getSurveys, it emits Error state', () {
      const profile = ProfileModel(
        id: 'id',
        email: 'email',
        name: 'name',
        avatarUrl: 'avatarUrl',
      );
      when(mockGetProfileUseCase.call())
          .thenAnswer((_) async => Success(profile));

      when(mockGetSurveysUseCase.call(any)).thenAnswer((_) async => Failed(
          UseCaseException(const NetworkExceptions.defaultError('Error'))));

      expect(
          viewModel.stream,
          emitsInOrder([
            const HomeViewState.error('Error'),
            const HomeViewState.success(),
          ]));

      container.read(homeViewModelProvider.notifier).init();
    });

    test(
        'When calling init failed on getProfile and getSurveys, it emits Error state',
        () {
      when(mockGetProfileUseCase.call()).thenAnswer((_) async => Failed(
          UseCaseException(
              const NetworkExceptions.defaultError('Get Profile Error'))));

      when(mockGetSurveysUseCase.call(any)).thenAnswer((_) async => Failed(
          UseCaseException(
              const NetworkExceptions.defaultError('Get Surveys Error'))));

      expect(
          viewModel.stream,
          emitsInOrder([
            const HomeViewState.error('Get Profile Error'),
            const HomeViewState.error('Get Surveys Error'),
            const HomeViewState.success(),
          ]));

      container.read(homeViewModelProvider.notifier).init();
    });

    test('When calling signOut success, it emits Success state', () {
      when(mockSignOutUseCase.call()).thenAnswer((_) async => Success(null));

      expect(
        container.read(signOutStream.future).asStream(),
        emits(null),
      );

      // FIXME: This test is not working due to stream closed after first emitted value
      // expect(
      //   container.read(loadingIndicatorStream.future).asStream(),
      //   emitsInOrder(
      //     [
      //       true,
      //       false
      //     ],
      //   ),
      // );

      container.read(homeViewModelProvider.notifier).signOut();
    });

    test('When calling signOut failed, it emits Error state', () {
      when(mockSignOutUseCase.call()).thenAnswer((_) async => Failed(
          UseCaseException(
              const NetworkExceptions.defaultError('SignOut Error'))));
      expect(
        viewModel.stream,
        emits(
          const HomeViewState.error('SignOut Error'),
        ),
      );

      // FIXME: This test is not working due to stream closed after first emitted value
      // expect(
      //   container.read(loadingIndicatorStream.future).asStream(),
      //   emitsInOrder([
      //     true,
      //     false,
      //   ]),
      // );

      // expectLater(
      //   container.read(signOutStream.future).asStream(),
      //   neverEmits(null),
      // );

      container.read(homeViewModelProvider.notifier).signOut();
    });
  });
}
