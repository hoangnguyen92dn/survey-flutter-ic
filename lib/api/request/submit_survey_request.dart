import 'package:freezed_annotation/freezed_annotation.dart';

part 'submit_survey_request.g.dart';

@JsonSerializable()
class SubmitSurveyRequest {
  final String surveyId;
  final List<SubmitSurveyQuestionsRequest> questions;

  SubmitSurveyRequest({
    required this.surveyId,
    required this.questions,
  });

  factory SubmitSurveyRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitSurveyRequestToJson(this);
}

@JsonSerializable()
class SubmitSurveyQuestionsRequest {
  final String questionId;
  final List<SubmitSurveyAnswersRequest> answers;

  SubmitSurveyQuestionsRequest({
    required this.questionId,
    required this.answers,
  });

  factory SubmitSurveyQuestionsRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyQuestionsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitSurveyQuestionsRequestToJson(this);
}

@JsonSerializable()
class SubmitSurveyAnswersRequest {
  final String answerId;
  final String? answer;

  SubmitSurveyAnswersRequest({
    required this.answerId,
    this.answer,
  });

  factory SubmitSurveyAnswersRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyAnswersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitSurveyAnswersRequestToJson(this);
}
