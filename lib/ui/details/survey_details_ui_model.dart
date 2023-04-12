import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/model/survey_details_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_question_ui_model.dart';

class SurveyDetailsUiModel extends Equatable {
  final String id;
  final String largeCoverImageUrl;
  final List<SurveyQuestionUiModel> questions;

  const SurveyDetailsUiModel({
    required this.id,
    required this.largeCoverImageUrl,
    required this.questions,
  });

  @override
  List<Object?> get props => [
        id,
        largeCoverImageUrl,
        questions,
      ];

  factory SurveyDetailsUiModel.fromModel(SurveyDetailsModel model) {
    return SurveyDetailsUiModel(
      id: model.id,
      largeCoverImageUrl: model.largeCoverImageUrl,
      questions: model.questions
          .map((e) => SurveyQuestionUiModel.fromModel(e))
          .toList(),
    );
  }
}
