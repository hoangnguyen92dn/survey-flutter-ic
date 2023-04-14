import 'package:json_annotation/json_annotation.dart';

// TODO Create custom JsonConverter for enum
@JsonEnum()
enum QuestionDisplayTypeResponse {
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

  factory QuestionDisplayTypeResponse.fromJson(String displayType) {
    switch (displayType) {
      case 'intro':
        return QuestionDisplayTypeResponse.intro;
      case 'star':
        return QuestionDisplayTypeResponse.star;
      case 'heart':
        return QuestionDisplayTypeResponse.heart;
      case 'smiley':
        return QuestionDisplayTypeResponse.smiley;
      case 'choice':
        return QuestionDisplayTypeResponse.choice;
      case 'nps':
        return QuestionDisplayTypeResponse.nps;
      case 'textarea':
        return QuestionDisplayTypeResponse.textarea;
      case 'textfield':
        return QuestionDisplayTypeResponse.textfield;
      case 'outro':
        return QuestionDisplayTypeResponse.outro;
      case 'dropdown':
        return QuestionDisplayTypeResponse.dropdown;
      default:
        return QuestionDisplayTypeResponse.unknown;
    }
  }
}
