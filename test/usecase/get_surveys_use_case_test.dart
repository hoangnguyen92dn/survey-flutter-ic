import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecase/get_survey_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetSurveysUseCase', () {
    late MockSurveyRepository mockRepository;
    late GetSurveysUseCase useCase;

    setUp(() {
      mockRepository = MockSurveyRepository();
      useCase = GetSurveysUseCase(mockRepository);
    });

    test('When calling GetSurveys successfully, it returns the result Success',
        () async {
      final expected = <SurveyModel>[];
      when(mockRepository.getSurveys(
        pageNumber: 1,
        size: 10,
      )).thenAnswer((_) async => expected);

      final result = await useCase.call(
        GetSurveysInput(
          pageNumber: 1,
          pageSize: 10,
        ),
      );

      expect(result, isA<Success>());
      expect((result as Success).value, expected);
    });

    test('When calling GetSurveys failed, it returns the result Failed',
        () async {
      const expected = NetworkExceptions.unexpectedError();

      when(mockRepository.getSurveys(
        pageNumber: 1,
        size: 10,
      )).thenAnswer((_) async => Future.error(expected));

      final result = await useCase.call(
        GetSurveysInput(
          pageNumber: 1,
          pageSize: 10,
        ),
      );

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException, expected);
    });
  });
}
