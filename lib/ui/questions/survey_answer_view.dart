import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/model/question_display_type_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_question_ui_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_widget_id.dart';
import 'package:survey_flutter_ic/widget/answer_dropdown.dart';
import 'package:survey_flutter_ic/widget/answer_emoji.dart';
import 'package:survey_flutter_ic/widget/answer_form.dart';
import 'package:survey_flutter_ic/widget/answer_multiple_choices.dart';
import 'package:survey_flutter_ic/widget/answer_nps.dart';
import 'package:survey_flutter_ic/widget/answer_textarea.dart';

class SurveyAnswerView extends ConsumerStatefulWidget {
  final SurveyQuestionUiModel question;

  const SurveyAnswerView({
    super.key,
    required this.question,
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
          questionId: question.id,
          answers: question.answers,
        );
      case QuestionDisplayType.star:
      case QuestionDisplayType.heart:
      case QuestionDisplayType.smiley:
        return AnswerEmoji(
          key: SurveyQuestionsWidgetId.answersRating,
          questionId: question.id,
          displayType: question.displayType,
          answers: question.answers,
        );
      case QuestionDisplayType.nps:
        return AnswerNps(
          questionId: question.id,
          answers: question.answers,
        );
      case QuestionDisplayType.textarea:
        return AnswerTextarea(
          questionId: question.id,
          answers: question.answers,
        );
      case QuestionDisplayType.textfield:
        return AnswerForm(
          questionId: question.id,
          answers: question.answers,
        );
      case QuestionDisplayType.choice:
        return AnswerMultipleChoices(
          key: SurveyQuestionsWidgetId.answersMultipleChoices,
          questionId: question.id,
          answers: question.answers,
          answerType: question.answerType,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
