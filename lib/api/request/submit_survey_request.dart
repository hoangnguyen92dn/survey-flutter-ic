import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_questions_request.dart';

part 'submit_survey_request.g.dart';

@JsonSerializable()
class SubmitSurveyRequest {
  final String surveyId;
  final List<SubmitSurveyQuestionsRequest> questions;

  const SubmitSurveyRequest({
    required this.surveyId,
    required this.questions,
  });

  factory SubmitSurveyRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyRequestFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'survey_id': surveyId,
        'questions': questions.map((e) => e.toJson()).toList(),
      };
}
