import 'package:json_annotation/json_annotation.dart';

part 'submit_survey_answers_request.g.dart';

@JsonSerializable()
class SubmitSurveyAnswersRequest {
  final String answerId;
  final String? answer;

  const SubmitSurveyAnswersRequest({
    required this.answerId,
    this.answer,
  });

  factory SubmitSurveyAnswersRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyAnswersRequestFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': answerId,
        'answer': answer,
      };
}
