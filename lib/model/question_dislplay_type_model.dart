import 'package:survey_flutter_ic/api/response/question_display_type_response.dart';

enum QuestionDisplayType {
  singleChoice,
  multipleChoice,
  text,
  number,
  email,
  dateTime,
  image,
  video,
  audio,
  unknown;

  factory QuestionDisplayType.fromResponse(
      QuestionDisplayTypeResponse response) {
    return QuestionDisplayType.values.firstWhere(
      (e) => e.toString() == 'QuestionDisplayType.${response.name}',
      orElse: () => QuestionDisplayType.unknown,
    );
  }
}
