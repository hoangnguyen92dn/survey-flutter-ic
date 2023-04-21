import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_request.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecase/submit_survey_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('SubmitSurveyUseCase', () {
    late MockSurveyRepository mockRepository;
    late SubmitSurveyUseCase useCase;

    setUp(() {
      mockRepository = MockSurveyRepository();
      useCase = SubmitSurveyUseCase(mockRepository);
    });

    test(
        'When calling SubmitSurveyUseCase successfully, it returns the result Success',
        () async {
      when(mockRepository.submitSurvey(request: anyNamed('request')))
          .thenAnswer((_) async => (null));

      final result = await useCase.call(SubmitSurveyRequest(
        surveyId: 'survey_id',
        questions: <SubmitSurveyQuestionsRequest>[],
      ));

      expect(result, isA<Success>());
      expect((result as Success).value, null);
    });

    test(
        'When calling SubmitSurveyUseCase failed, it returns the result Failed',
        () async {
      const expected = NetworkExceptions.unexpectedError();

      when(mockRepository.submitSurvey(request: anyNamed('request')))
          .thenAnswer((_) async => Future.error(expected));

      final result = await useCase.call(SubmitSurveyRequest(
        surveyId: 'survey_id',
        questions: <SubmitSurveyQuestionsRequest>[],
      ));

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException, expected);
    });
  });
}
