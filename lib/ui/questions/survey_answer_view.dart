import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/model/question_display_type_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_answer_ui_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_question_ui_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_widget_id.dart';
import 'package:survey_flutter_ic/widget/answer_dropdown.dart';
import 'package:survey_flutter_ic/widget/answer_emoji.dart';
import 'package:survey_flutter_ic/widget/answer_nps.dart';
import 'package:survey_flutter_ic/widget/answer_textarea.dart';

class SurveyAnswerView extends ConsumerStatefulWidget {
  final SurveyQuestionUiModel question;
  final Function(SurveyAnswerUiModel) onAnswerSelected;

  const SurveyAnswerView({
    super.key,
    required this.question,
    required this.onAnswerSelected,
  });

  @override
  ConsumerState<SurveyAnswerView> createState() => _SurveyAnswerViewState();
}

class _SurveyAnswerViewState extends ConsumerState<SurveyAnswerView> {
  @override
  Widget build(BuildContext context) {
    final question = widget.question;
    switch (question.displayType) {
      case QuestionDisplayType.dropdown:
        return AnswerDropdown(
          key: SurveyQuestionsWidgetId.answersDropdown,
          answers: question.answers,
        );
      case QuestionDisplayType.star:
      case QuestionDisplayType.heart:
      case QuestionDisplayType.smiley:
        return AnswerEmoji(
          key: SurveyQuestionsWidgetId.answersRating,
          displayType: question.displayType,
          answers: question.answers,
          onAnswerSelected: (answer) {
            widget.onAnswerSelected.call(answer);
          },
        );
      case QuestionDisplayType.nps:
        return AnswerNps(
          answers: question.answers,
          onAnswerSelected: (answer) {
            widget.onAnswerSelected.call(answer);
          },
        );
      case QuestionDisplayType.textarea:
        // TODO: Handle filled text area
        return AnswerTextarea(
          answers: question.answers,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
