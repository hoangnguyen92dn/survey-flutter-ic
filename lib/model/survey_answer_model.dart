import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/api/response/survey_answer_response.dart';

class SurveyAnswerModel extends Equatable {
  final String id;
  final String text;

  const SurveyAnswerModel({
    required this.id,
    required this.text,
  });

  @override
  List<Object?> get props => [
        id,
        text,
      ];

  factory SurveyAnswerModel.fromResponse(SurveyAnswerResponse response) {
    return SurveyAnswerModel(
      id: response.id,
      text: response.text ?? '',
    );
  }
}
