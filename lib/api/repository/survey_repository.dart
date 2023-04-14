import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/service/survey_service.dart';
import 'package:survey_flutter_ic/model/survey_details_model.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';

abstract class SurveyRepository {
  Future<List<SurveyModel>> getSurveys({
    required int number,
    required int size,
  });

  Future<SurveyDetailsModel> getSurveyDetails({
    required String id,
  });
}

@Singleton(as: SurveyRepository)
class SurveyRepositoryImpl extends SurveyRepository {
  final SurveyService _surveyService;

  SurveyRepositoryImpl(this._surveyService);

  @override
  Future<List<SurveyModel>> getSurveys({
    required int number,
    required int size,
  }) async {
    try {
      final response = await _surveyService.getSurveys(number, size);
      final surveysModel = response.surveys
          .map((survey) => SurveyModel.fromResponse(survey))
          .toList();

      return surveysModel;
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  @override
  Future<SurveyDetailsModel> getSurveyDetails({
    required String id,
  }) async {
    try {
      final response = await _surveyService.getSurveyDetails(id);
      final surveyDetailsModel = SurveyDetailsModel.fromResponse(response);

      return surveyDetailsModel;
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
