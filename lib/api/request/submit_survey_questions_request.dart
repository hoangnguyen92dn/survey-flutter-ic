import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_answers_request.dart';

part 'submit_survey_questions_request.g.dart';

@JsonSerializable()
class SubmitSurveyQuestionsRequest {
  final String questionId;
  final List<SubmitSurveyAnswersRequest> answers;

  const SubmitSurveyQuestionsRequest({
    required this.questionId,
    required this.answers,
  });

  factory SubmitSurveyQuestionsRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyQuestionsRequestFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': questionId,
        'answers': answers.map((e) => e.toJson()).toList(),
      };
}
