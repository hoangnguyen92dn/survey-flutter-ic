import 'package:json_annotation/json_annotation.dart';

part 'submit_survey_answers_request.g.dart';

@JsonSerializable(includeIfNull: false)
class SubmitSurveyAnswersRequest {
  @JsonKey(name: 'id')
  final String answerId;
  final String? answer;

  const SubmitSurveyAnswersRequest({
    required this.answerId,
    this.answer,
  });

  factory SubmitSurveyAnswersRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyAnswersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitSurveyAnswersRequestToJson(this);
}
