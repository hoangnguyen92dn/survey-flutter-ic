import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/api/response/survey_details_response.dart';
import 'package:survey_flutter_ic/model/survey_question_model.dart';

class SurveyDetailsModel extends Equatable {
  final String id;
  final String coverImageUrl;
  final String largeCoverImageUrl;
  final List<SurveyQuestionModel> questions;

  const SurveyDetailsModel({
    required this.id,
    required this.coverImageUrl,
    required this.largeCoverImageUrl,
    required this.questions,
  });

  @override
  List<Object?> get props => [
        id,
        coverImageUrl,
        largeCoverImageUrl,
        questions,
      ];

  factory SurveyDetailsModel.fromResponse(SurveyDetailsResponse response) {
    return SurveyDetailsModel(
      id: response.id,
      coverImageUrl: response.coverImageUrl ?? '',
      largeCoverImageUrl: '${response.coverImageUrl ?? ''}l',
      questions: response.questions
              ?.map((e) => SurveyQuestionModel.fromResponse(e))
              .toList() ??
          [],
    );
  }
}
