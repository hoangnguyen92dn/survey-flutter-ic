import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/api/response/survey_response.dart';

class SurveyModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isActive;
  final String coverImageUrl;
  final String largeCoverImageUrl;
  final String createdAt;
  final String surveyType;

  const SurveyModel({
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

  factory SurveyModel.fromResponse(SurveyResponse response) {
    return SurveyModel(
      id: response.id,
      title: response.title ?? '',
      description: response.description ?? '',
      isActive: response.isActive ?? false,
      coverImageUrl: response.coverImageUrl ?? '',
      largeCoverImageUrl: '${response.coverImageUrl ?? ''}l',
      createdAt: response.createdAt ?? '',
      surveyType: response.surveyType ?? '',
    );
  }
}
