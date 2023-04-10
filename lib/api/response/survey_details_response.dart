import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter_ic/api/response/converter/response_converter.dart';
import 'package:survey_flutter_ic/api/response/survey_question_response.dart';

part 'survey_details_response.g.dart';

@JsonSerializable()
class SurveyDetailsResponse {
  final String id;
  String? title;
  String? description;
  String? coverImageUrl;
  List<SurveyQuestionResponse>? questions;

  SurveyDetailsResponse({
    required this.id,
    this.title,
    this.description,
    this.coverImageUrl,
    this.questions,
  });

  factory SurveyDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyDetailsResponseFromJson(fromDataJsonApi(json));
}
