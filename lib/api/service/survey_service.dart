import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_request.dart';
import 'package:survey_flutter_ic/api/response/survey_details_response.dart';
import 'package:survey_flutter_ic/api/response/surveys_response.dart';

part 'survey_service.g.dart';

abstract class SurveyService {
  Future<SurveysResponse> getSurveys(
    @Path('number') int number,
    @Path('size') int size,
  );

  Future<SurveyDetailsResponse> getSurveyDetails(
    @Path('id') String id,
  );

  Future<void> submitSurvey(
    @Body() SubmitSurveyRequest body,
  );
}

@RestApi()
abstract class SurveyServiceImpl extends SurveyService {
  factory SurveyServiceImpl(Dio dio, {String baseUrl}) = _SurveyServiceImpl;

  @override
  @GET('/api/v1/surveys?page[number]={number}&page[size]={size}')
  Future<SurveysResponse> getSurveys(
    @Path('number') int number,
    @Path('size') int size,
  );

  @override
  @GET('/api/v1/surveys/{id}')
  Future<SurveyDetailsResponse> getSurveyDetails(
    @Path('id') String id,
  );

  @override
  @GET('/api/v1/responses')
  Future<void> submitSurvey(
    @Body() SubmitSurveyRequest body,
  );
}
