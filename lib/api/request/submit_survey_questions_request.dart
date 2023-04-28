import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_answers_request.dart';

part 'submit_survey_questions_request.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SubmitSurveyQuestionsRequest {
  @JsonKey(name: 'id')
  final String questionId;
  final List<SubmitSurveyAnswersRequest> answers;

  const SubmitSurveyQuestionsRequest({
    required this.questionId,
    required this.answers,
  });

  factory SubmitSurveyQuestionsRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyQuestionsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitSurveyQuestionsRequestToJson(this);
}
