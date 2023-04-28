import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_answers_request.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_questions_request.dart';
import 'package:survey_flutter_ic/extension/context_extension.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/questions/survey_answer_ui_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_view_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_widget_id.dart';

class AnswerTextarea extends ConsumerStatefulWidget {
  final String questionId;
  final List<SurveyAnswerUiModel> answers;

  const AnswerTextarea({
    super.key,
    required this.questionId,
    required this.answers,
  });

  @override
  ConsumerState<AnswerTextarea> createState() => _AnswerTextareaState();
}

class _AnswerTextareaState extends ConsumerState<AnswerTextarea> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(nextQuestionStream, (previous, next) {
      ref.watch(surveyQuestionsViewModelProvider.notifier).cacheAnswers(
            SubmitSurveyQuestionsRequest(
              questionId: widget.questionId,
              answers: [
                SubmitSurveyAnswersRequest(
                  answerId: widget.answers.first.id,
                  answer: _controller.text,
                )
              ],
            ),
          );
    });
    return Expanded(
      key: SurveyQuestionsWidgetId.answersTextArea,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(borderRadius10),
        ),
        child: TextField(
          controller: _controller,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.start,
          cursorColor: Colors.white,
          style: const TextStyle(
            color: Colors.white,
            fontSize: fontSize17,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: context.localization.survey_question_textarea_hint,
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: fontSize17,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: space10,
              vertical: space18,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
