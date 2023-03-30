import 'package:flutter_config/flutter_config.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/api/response/surveys_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import '../../mocks/generate_mocks.mocks.dart';
import '../../utils/file_utils.dart';

void main() {
  FlutterConfig.loadValueForTesting({
    'CLIENT_ID': 'CLIENT_ID',
    'CLIENT_SECRET': 'CLIENT_SECRET',
  });

  group('SurveyRepository', () {
    late MockSurveyService mockSurveyService;
    late SurveyRepository repository;

    setUp(() {
      mockSurveyService = MockSurveyService();
      repository = SurveyRepositoryImpl(mockSurveyService);
    });

    test(
        'When calling GetSurveys successfully, it emits the corresponding AuthModel',
        () async {
      final json = await FileUtils.loadFile('mock_response/surveys.json');
      final expected = SurveysResponse.fromJson(json);

      when(mockSurveyService.getSurveys(any, any))
          .thenAnswer((_) async => expected);

      final result = await repository.getSurveys(
        number: 1,
        size: 10,
      );

      expect(result.first, SurveyModel.fromResponse(expected.surveys.first));
      expect(result.last, SurveyModel.fromResponse(expected.surveys.last));
    });

    test('When calling GetSurveys failed, it returns NetworkExceptions error',
        () async {
      when(mockSurveyService.getSurveys(any, any)).thenThrow(MockDioError());

      result() => repository.getSurveys(number: 1, size: 10);

      expect(result, throwsA(isA<NetworkExceptions>()));
    });
  });
}