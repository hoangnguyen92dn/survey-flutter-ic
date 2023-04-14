import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/model/survey_answer_model.dart';

class SurveyAnswerUiModel extends Equatable {
  final String id;
  final String text;

  const SurveyAnswerUiModel({
    required this.id,
    required this.text,
  });

  @override
  List<Object?> get props => [
        id,
        text,
      ];

  factory SurveyAnswerUiModel.fromModel(SurveyAnswerModel model) {
    return SurveyAnswerUiModel(
      id: model.id,
      text: model.text,
    );
  }
}
