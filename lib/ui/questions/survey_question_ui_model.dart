import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/model/survey_question_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_answer_ui_model.dart';

class SurveyQuestionUiModel extends Equatable {
  final String id;
  final String text;
  final List<SurveyAnswerUiModel> answers;

  const SurveyQuestionUiModel({
    required this.id,
    required this.text,
    required this.answers,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        answers,
      ];

  factory SurveyQuestionUiModel.fromModel(SurveyQuestionModel model) {
    return SurveyQuestionUiModel(
      id: model.id,
      text: model.text,
      answers:
          model.answers.map((e) => SurveyAnswerUiModel.fromModel(e)).toList(),
    );
  }
}
