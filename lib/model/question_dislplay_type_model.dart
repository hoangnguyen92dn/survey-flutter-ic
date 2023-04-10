import 'package:survey_flutter_ic/api/response/question_display_type_response.dart';

enum QuestionDisplayType {
  intro,
  star,
  heart,
  smiley,
  choice,
  nps,
  textarea,
  textfield,
  outro,
  dropdown,
  unknown;

  factory QuestionDisplayType.fromResponse(
      QuestionDisplayTypeResponse response) {
    return QuestionDisplayType.values.firstWhere(
      (e) => e.toString() == 'QuestionDisplayType.${response.name}',
      orElse: () => QuestionDisplayType.unknown,
    );
  }
}
