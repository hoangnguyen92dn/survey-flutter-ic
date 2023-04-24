import 'package:flutter_test/flutter_test.dart';
import 'package:retrofit/retrofit.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_request.dart';
import 'package:survey_flutter_ic/api/response/survey_details_response.dart';
import 'package:survey_flutter_ic/api/response/surveys_response.dart';
import 'package:survey_flutter_ic/api/service/survey_service.dart';

import '../fake_data.dart';

class FakeSurveyService extends Fake implements SurveyService {
  @override
  Future<SurveysResponse> getSurveys(
    @Path('number') int number,
    @Path('size') int size,
  ) async {
    final response = FakeData.apiAndResponse[keySurveys]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
    return SurveysResponse.fromJson(response.json);
  }

  @override
  Future<SurveyDetailsResponse> getSurveyDetails(@Path('id') String id) async {
    final response = FakeData.apiAndResponse[keySurveyDetails]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
    return SurveyDetailsResponse.fromJson(response.json);
  }

  @override
  Future<void> submitSurvey(
    @Body() SubmitSurveyRequest body,
  ) async {
    final response = FakeData.apiAndResponse[keySubmitSurvey]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
    return Future.value();
  }
}
