import 'package:survey_flutter_ic/api/response/selection_answer_type_response.dart';

enum SelectionAnswerType {
  single,
  multiple,
  unknown;

  factory SelectionAnswerType.fromResponse(
      SelectionAnswerTypeResponse response) {
    return SelectionAnswerType.values.firstWhere(
      (e) => e.toString() == 'SelectionAnswerType.${response.name}',
      orElse: () => SelectionAnswerType.unknown,
    );
  }
}
