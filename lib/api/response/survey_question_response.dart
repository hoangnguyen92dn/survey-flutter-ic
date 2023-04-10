import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter_ic/api/response/converter/response_converter.dart';
import 'package:survey_flutter_ic/api/response/question_display_type_response.dart';
import 'package:survey_flutter_ic/api/response/survey_answer_response.dart';

part 'survey_question_response.g.dart';

@JsonSerializable()
class SurveyQuestionResponse {
  final String id;
  String? text;
  int? displayOrder;
  QuestionDisplayTypeResponse? displayType;
  String? coverImageUrl;
  List<SurveyAnswerResponse>? answers;

  SurveyQuestionResponse({
    required this.id,
    this.text,
    this.displayOrder,
    this.displayType,
    this.coverImageUrl,
    this.answers,
  });

  factory SurveyQuestionResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyQuestionResponseFromJson(fromDataJsonApi(json));
}
