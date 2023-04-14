import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/model/survey_details_model.dart';
import 'package:survey_flutter_ic/model/survey_question_model.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecase/get_survey_details_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetSurveyDetailsUseCase', () {
    late MockSurveyRepository mockRepository;
    late GetSurveyDetailsUseCase useCase;

    setUp(() {
      mockRepository = MockSurveyRepository();
      useCase = GetSurveyDetailsUseCase(mockRepository);
    });

    test(
        'When calling GetSurveyDetailsUseCase successfully, it returns the result Success',
        () async {
      const expected = SurveyDetailsModel(
        id: 'id',
        coverImageUrl: 'coverImageUrl',
        largeCoverImageUrl: 'largeCoverImageUrl',
        questions: <SurveyQuestionModel>[],
      );
      when(mockRepository.getSurveyDetails(id: 'id'))
          .thenAnswer((_) async => expected);

      final result = await useCase.call('id');

      expect(result, isA<Success>());
      expect((result as Success).value, expected);
    });

    test(
        'When calling GetSurveyDetailsUseCase failed, it returns the result Failed',
        () async {
      const expected = NetworkExceptions.unexpectedError();

      when(mockRepository.getSurveyDetails(id: 'id'))
          .thenAnswer((_) async => Future.error(expected));

      final result = await useCase.call('id');

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException, expected);
    });
  });
}
