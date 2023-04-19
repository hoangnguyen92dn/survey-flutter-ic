import 'package:json_annotation/json_annotation.dart';

// TODO Create custom JsonConverter for enum
@JsonEnum()
enum SelectionAnswerTypeResponse {
  single,
  multiple,
  unknown;

  factory SelectionAnswerTypeResponse.fromJson(String type) {
    switch (type) {
      case 'one':
        return SelectionAnswerTypeResponse.single;
      case 'any':
        return SelectionAnswerTypeResponse.multiple;
      default:
        return SelectionAnswerTypeResponse.unknown;
    }
  }
}
