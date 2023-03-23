import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter_ic/api/response/converter/response_converter.dart';
import 'package:survey_flutter_ic/api/response/survey_response.dart';

part 'surveys_response.g.dart';

@JsonSerializable()
class SurveysResponse {
  @JsonKey(name: 'data')
  final List<SurveyResponse> surveys;

  SurveysResponse({
    required this.surveys,
  });

  factory SurveysResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveysResponseFromJson(fromDataJsonApi(json));
}
