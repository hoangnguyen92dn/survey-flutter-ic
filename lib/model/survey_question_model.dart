import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/api/response/question_display_type_response.dart';
import 'package:survey_flutter_ic/api/response/survey_question_response.dart';
import 'package:survey_flutter_ic/model/question_dislplay_type_model.dart';
import 'package:survey_flutter_ic/model/survey_answer_model.dart';

class SurveyQuestionModel extends Equatable {
  final String id;
  final String text;
  final int displayOrder;
  final QuestionDisplayType displayType;
  final String coverImageUrl;
  final List<SurveyAnswerModel> answers;

  const SurveyQuestionModel({
    required this.id,
    required this.text,
    required this.displayOrder,
    required this.displayType,
    required this.coverImageUrl,
    required this.answers,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        displayOrder,
        displayType,
        coverImageUrl,
        answers,
      ];

  factory SurveyQuestionModel.fromResponse(SurveyQuestionResponse response) {
    return SurveyQuestionModel(
      id: response.id,
      text: response.text ?? '',
      displayOrder: response.displayOrder ?? 0,
      displayType: QuestionDisplayType.fromResponse(
          response.displayType ?? QuestionDisplayTypeResponse.unknown),
      coverImageUrl: response.coverImageUrl ?? '',
      answers: response.answers
              ?.map((e) => SurveyAnswerModel.fromResponse(e))
              .toList() ??
          [],
    );
  }
}
