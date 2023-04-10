import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';

class SurveyUiModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isActive;
  final String coverImageUrl;
  final String largeCoverImageUrl;
  final String createdAt;
  final String surveyType;

  const SurveyUiModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isActive,
    required this.coverImageUrl,
    required this.largeCoverImageUrl,
    required this.createdAt,
    required this.surveyType,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        isActive,
        coverImageUrl,
        largeCoverImageUrl,
        createdAt,
        surveyType,
      ];

  factory SurveyUiModel.fromModel(SurveyModel model) {
    return SurveyUiModel(
      id: model.id,
      title: model.title,
      description: model.description,
      isActive: model.isActive,
      coverImageUrl: model.coverImageUrl,
      largeCoverImageUrl: model.largeCoverImageUrl,
      createdAt: model.createdAt,
      surveyType: model.surveyType,
    );
  }
}
