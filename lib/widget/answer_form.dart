import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_answers_request.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_questions_request.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/questions/survey_answer_ui_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_view_model.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_widget_id.dart';

class AnswerForm extends ConsumerStatefulWidget {
  final String questionId;
  final List<SurveyAnswerUiModel> answers;

  const AnswerForm({
    super.key,
    required this.questionId,
    required this.answers,
  });

  @override
  ConsumerState<AnswerForm> createState() => _AnswerFormState();
}

class _AnswerFormState extends ConsumerState<AnswerForm> {
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    _controllers.addAll(List<TextEditingController>.generate(
      widget.answers.length,
      (index) => TextEditingController(),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(nextQuestionStream, (previous, next) {
      ref.watch(surveyQuestionsViewModelProvider.notifier).cacheAnswers(
            SubmitSurveyQuestionsRequest(
              questionId: widget.questionId,
              answers: _controllers
                  .map((e) => SubmitSurveyAnswersRequest(
                        answerId: widget.answers[_controllers.indexOf(e)].id,
                        answer: e.text,
                      ))
                  .toList(),
            ),
          );
    });
    return Center(
      key: SurveyQuestionsWidgetId.answersForm,
      child: _buildForm(widget.answers),
    );
  }

  Widget _buildForm(List<SurveyAnswerUiModel> answers) {
    return Column(
      children: [
        for (int i = 0; i < answers.length; i++) ...[
          _buildTextInputField(i, answers[i]),
          SizedBox.fromSize(size: const Size.fromHeight(space16)),
        ],
      ],
    );
  }

  Widget _buildTextInputField(int index, SurveyAnswerUiModel answer) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(borderRadius10),
      ),
      child: TextField(
        controller: _controllers[index],
        keyboardType: _getTextInputType(answer),
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Colors.white,
        style: const TextStyle(
          color: Colors.white,
          fontSize: fontSize17,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: answer.text,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
            fontSize: fontSize17,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: space10,
            vertical: space16,
          ),
        ),
      ),
    );
  }

  TextInputType _getTextInputType(SurveyAnswerUiModel answer) {
    final hintText = answer.text.toLowerCase();
    if (hintText.contains('@') || hintText.contains('email')) {
      return TextInputType.emailAddress;
    } else if (hintText.contains('phone')) {
      return TextInputType.phone;
    } else if (hintText.contains('number') || hintText.contains('no.')) {
      return TextInputType.number;
    } else {
      return TextInputType.text;
    }
  }

  @override
  void dispose() {
    for (var element in _controllers) {
      element.dispose();
    }
    super.dispose();
  }
}
