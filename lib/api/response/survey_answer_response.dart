import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter_ic/api/response/converter/response_converter.dart';

part 'survey_answer_response.g.dart';

@JsonSerializable()
class SurveyAnswerResponse {
  final String id;
  String? text;

  SurveyAnswerResponse({
    required this.id,
    this.text,
  });

  factory SurveyAnswerResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyAnswerResponseFromJson(fromDataJsonApi(json));
}
