import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_request.dart';
import 'package:survey_flutter_ic/api/service/survey_service.dart';
import 'package:survey_flutter_ic/database/dto/survey_dto.dart';
import 'package:survey_flutter_ic/database/persistence/survey_persistence.dart';
import 'package:survey_flutter_ic/model/survey_details_model.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';

abstract class SurveyRepository {
  Future<List<SurveyModel>> getSurveys({
    required int pageNumber,
    required int size,
  });

  Future<SurveyDetailsModel> getSurveyDetails({
    required String id,
  });

  Future<void> submitSurvey({
    required SubmitSurveyRequest request,
  });
}

@Singleton(as: SurveyRepository)
class SurveyRepositoryImpl extends SurveyRepository {
  final SurveyService _surveyService;
  final SurveyPersistence _surveyPersistence;

  SurveyRepositoryImpl(
    this._surveyService,
    this._surveyPersistence,
  );

  @override
  Future<List<SurveyModel>> getSurveys({
    required int pageNumber,
    required int size,
  }) async {
    try {
      final response = await _surveyService.getSurveys(pageNumber, size);
      final surveysModel = response.surveys
          .map((survey) => SurveyModel.fromResponse(survey))
          .toList();

      await _cacheSurveysToPersistence(pageNumber, surveysModel);

      return surveysModel;
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  Future<void> _cacheSurveysToPersistence(
    int pageNumber,
    List<SurveyModel> surveysModel,
  ) async {
    if (pageNumber == 1) {
      await _surveyPersistence.clear();
    }
    await _surveyPersistence
        .add(surveysModel.map((e) => SurveyDto.fromModel(e)).toList());
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

  @override
  Future<void> submitSurvey({required SubmitSurveyRequest request}) async {
    try {
      final response = await _surveyService.submitSurvey(request);
      return response;
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
